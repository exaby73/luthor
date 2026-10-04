---
name: dpk
description: Use dpk, the Dart package manager that wraps dart pub, to manage dependencies, run scripts and hooks, run commands across pub workspace packages, apply a workspace catalog, patch dependencies, and release packages. Use when a project has a dpk.yaml or the user mentions dpk.
---

# dpk

dpk wraps `dart pub`. Every pub command works through it (`dpk get`, `dpk add`, `dpk upgrade`, ...), and it adds scripts, hooks, workspace runs, a catalog, dependency patches, and releases. This guide is for operating the CLI in a user's project. `dpk skills` prints it, and works outside a project.

## Read the project first

1. Find `dpk.yaml` at the package or workspace root. Its `version` is the dpk constraint, and dpk refuses to run outside it.
2. Run `dpk run` to list the scripts, with descriptions and hooks.
3. In a workspace, run `dpk list` to see the workspace packages, or `dpk list --graph` for their dependencies.
4. Run `dpk doctor` when something looks wrong. It checks the config, the workspace, pubspec drift, and the project cache, and exits 1 on a problem.

## Command line rule

dpk's own options go **before** the command. Everything **after** the command belongs to it.

```bash
dpk -C packages/app run test --coverage=coverage   # -C is dpk's, --coverage is the script's
dpk add http -C packages/app                       # -C goes to dart pub add
```

dpk options: `-C, --directory <dir>`, `--cache-dir <dir>`, `-v, --verbose`, `-q, --quiet`, `--[no-]color`, `--version`, `-h, --help`. `-d` is not an option.

## Dependencies

| Task | Command |
| --- | --- |
| Get dependencies, apply the catalog, sort pubspecs, apply patches | `dpk get` |
| Fail in CI when `dpk get` would change files | `dpk get --check` |
| Preview without writing | `dpk get --dry-run` |
| Add or remove dependencies | `dpk add http dev:test`, `dpk remove http` |
| Upgrade | `dpk upgrade`, `dpk upgrade --major-versions` |
| Inspect | `dpk outdated`, `dpk deps` |

Prefer `dpk add` over editing pubspecs by hand. `dpk add <package>` without a version uses the catalog's version when the catalog has one.

The pub commands `add`, `remove`, `upgrade` (`update`), `downgrade`, `outdated`, `deps`, `bump`, `publish`, `workspace`, `cache`, `global`, `unpack`, `login`, `logout`, and `token` pass every argument to `dart pub`. `cache`, `global`, `unpack`, `login`, `logout`, and `token` work outside a project.

## Scripts

```yaml
scripts:
  analyze: dart analyze
  test:
    command: dart test
    description: Run the tests.
    env: {LOG_LEVEL: verbose}
    env_file: .env.test
```

- `dpk run <script> [args]` runs a script. Every argument after the name reaches the script, appended to the command and quoted.
- Script keys: `command` (required in the mapping form), `description`, `env`, `env_file` (dotenv, relative to the workspace root, overridden by `env`), `depends_on`, `run_in_packages`, `run_hooks_from`, `concurrency`, `fail_fast`, `dependency_order`.
- Scripts run in `/bin/sh` (`cmd.exe` on Windows), never the login shell. Write POSIX shell.
- A script runs in the workspace package it is started from. From the root or a folder outside any package, it runs at the root.
- Scripts get `DPK_ROOT`, `DPK_PACKAGE_NAME`, `DPK_PACKAGE_PATH`, and in project mode `PUB_CACHE`.
- dpk prints `> name: command` to stderr before each script and hook. `-q` hides it. Stdout stays clean for piping.
- `dpk` inside a script is the same dpk that started it: dpk puts a launcher first on the script's `PATH`. Calling `dpk run other` from a script is safe.
- `depends_on: [build]` runs `build` first, once per dpk run, before the script's hooks. `depends_on: [^build]` runs `build` in the workspace packages the script's packages depend on, in dependency order. `build: {command: ..., depends_on: [^build]}` builds a package's workspace dependencies before it.

## Hooks

- `pre:<name>` / `post:<name>` run right before and after the hook target `<name>`, a script or a pub command such as `get` or `add`.
- `before` / `after` are shared hooks. They need `scripts: [targets]` or `all: true`.
- Order: `before`, `pre:<name>`, target, `post:<name>`, `after`. A failure stops the rest.
- `dpk get` is the exception: `pre:get`, `dart pub get`, `before`, `post:get`, `after`. Code generation in `before` therefore runs with packages resolved.
- `run_hooks_from: build` makes a script also run `build`'s hooks, outside its own.
- Nested `dpk` calls skip hooks that already ran higher up, so hooks never loop or repeat.

## Workspaces

- dpk finds the workspace root from the root pubspec's `workspace` list. The root package can have any name.
- `workspace:` globs in `dpk.yaml` select members; `dpk get` writes them to the root pubspec. Only packages with `resolution: workspace` match.
- A workspace package's own `dpk.yaml` may hold only `version` and `scripts`. Its scripts override the root's.

Run across packages:

```yaml
scripts:
  test:
    command: dart test
    run_in_packages: [packages/*, app]   # names or path globs, "." is the root
```

```bash
dpk run test                                  # every selected package, in parallel
dpk run --filter app --filter 'packages/core' test
dpk run -j 2 --fail-fast --dependency-order test
dpk exec -- dart format .                     # any command, every workspace package
dpk exec --filter app 'dart analyze && dart test'
```

Run options go between `run` and the script name. A `run_in_packages` or `--filter` that matches nothing is an error. The exit code is that of the first failed package.

## Cleaning

`dpk clean` removes `.dart_tool/` and `build/` in the root and every workspace package, and runs `flutter clean` in Flutter packages when `flutter` is on `PATH`. `--lockfile` also removes `pubspec.lock`, `--cache` removes the project cache, `--dry-run` lists the paths, and `--filter` narrows the packages.

## Catalog

The root `dpk.yaml` `catalog` is applied by `dpk get`:

- `environment`: merged key by key into every pubspec.
- `dependencies`: rewrites dependencies and dev dependencies that packages already have; never adds new ones. Values are written as given (constraints or `git:`/`path:`/`sdk:` maps). Managed entries get `# Configured via catalog`.
- `version`, `publish_to`, `homepage`, `repository`, `issue_tracker`, `documentation`, `funding`, `platforms`, `resolution`: set on workspace packages. `topics` are added.
- Metadata URLs expand `DPK_PACKAGE_PATH`, `DPK_PACKAGE_NAME`, and `DPK_PACKAGE_VERSION` (also as `$NAME` or `${NAME}`).

Change a managed dependency in the catalog, then run `dpk get`. Editing the pubspec alone is overwritten by the next `dpk get`. `dpk catalog outdated` and `dpk catalog upgrade [--major-versions]` keep the catalog current.

`sort_pubspec: true` sorts pubspecs on `dpk get`, keeping comments and formatting.

## Patching dependencies

Patching needs `mode: project`. Recommend global mode (the default) unless the user patches dependencies.

1. `dpk get` downloads packages into the project cache (`pub_packages/`) and records a git baseline.
2. Edit files in `pub_packages/hosted/pub.dev/<package>-<version>/` (git dependencies: `pub_packages/git/<package>-<commit>/`).
3. `dpk patch generate [package...]` writes `patches/hosted/<package>-<version>.patch`. Commit `patches/`.
4. Every `dpk get`, `add`, `remove`, `upgrade`, and `downgrade` applies the patches.

- `dpk patch list` shows each patch as applied, not applied, stale, missing, or conflicting.
- A stale patch means the lockfile uses another version: edit the new version and generate again, or `dpk patch remove <package>`.
- `dpk patch apply --force` resets a package whose edits conflict with its patch. `dpk patch init --force` discards every edit in the cache. Ask before either.
- `pub_packages/` belongs in `.gitignore` and in `analyzer: exclude:`; `dpk doctor` warns when it is missing.

## Releasing

- `dpk release version --dry-run` shows new versions and changelog entries computed from Conventional Commits since each package's last tag (`<package>-v<version>`, or `v<version>` standalone).
- `feat` raises minor, `fix`/`perf`/`revert` raise patch, `!` or `BREAKING CHANGE:` raises major. Below 1.0.0, breaking raises minor and `feat` raises patch.
- `dpk release version` updates pubspecs, dependent constraints, and `CHANGELOG.md`, runs the `version` hooks, then commits and creates annotated tags. A `post:version` hook (for example `dpk run build` to regenerate version files) runs before the commit, and its changes are committed too. It needs a clean tree and confirmation (`--yes` in scripts). The user pushes with `git push --follow-tags`.
- `dpk release publish` publishes unpublished versions, dependencies first, skipping `publish_to: none`, and creates a missing release tag for each published version (`--no-tag` skips it). Publishing is irreversible: always run `--dry-run` first and get the user's go-ahead.

## Config errors

dpk validates `dpk.yaml` on every run and reports `file:line:column: key: problem`, with a suggestion for typos. Fix the named key. Deprecated keys (`runInPackages`, `runHooksFrom`, `sortPubspec`) still work with a warning, and `dpk get` renames them to snake_case.

## Working rules

- Use the project's scripts (`dpk run`) instead of retyping their commands, and read `dpk run` before inventing new ones.
- After editing `dpk.yaml` or a catalog, run `dpk get`, then `dpk get --check` to confirm a clean state.
- Never edit files in `pub_packages/` without generating patches afterwards. A fresh clone loses unsaved edits.
- Ask before `--force`, `release version`, and `release publish`.
