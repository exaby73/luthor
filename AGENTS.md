# AGENTS.md

Luthor is a Zod-inspired Dart validation library (`packages/luthor`) with a `source_gen` generator that builds schemas from annotated models (`packages/luthor_generator`). Read `GLOSSARY.md` before you name a domain concept. Read `docs/architecture.md` before you change how validators, results, or the generator fit together.

## Rules

- Add dependencies through the catalog in `dpk.yaml`, then run `dpk get`. `.agents/skills/dpk/SKILL.md` describes exactly what the catalog rewrites.
- Cover every behaviour change with Given/When/Then tests written with the `gwt-tester` skill. Fix bugs test-first with the `tdd` skill.
- Write commit messages and PR titles with the `git-committer` skill. PR titles must pass `.github/workflows/title_validation.yaml`: a conventional type and a subject that starts with an uppercase letter.
- Give public API `///` dartdoc. Write inline `//` comments by the `no-comments` skill.
- To read a dependency's source, use the `pub-package-explorer` skill.

## Gotchas

- The workspace runs on the supported floor, Dart 3.11.5 (Flutter 3.41.9). `examples/luthor_generator` resolves outside the workspace on Dart 3.13 with freezed 4 ([ADR 0001](docs/adr/0001-generator-example-lives-outside-the-workspace.md)). Run code generation there with `dpk run build`.
- The example's generated files are committed, and CI fails when they drift. After any change to generator output, run `dpk run build` and commit the result.
- `luthor_generator` supports analyzer 10 to 14, because Flutter 3.41 pins `meta` 1.17.0, which only analyzer 10.0.x accepts. The workspace resolves analyzer 14, so an analyzer API added after 10.0.0 passes locally and fails CI. To test a floor locally (CI tests `10.0.0` and `13.0.0`), run this from the repo root:

  ```sh
  dpk get
  dart pub add analyzer:10.0.0
  dpk run --filter luthor_generator analyze
  dpk run --filter luthor_generator test
  git checkout pubspec.yaml pubspec.lock && dpk get
  ```

  Pin with `dart pub add`, because a `dependency_overrides` pin leaves `build` and `dart_style` on releases that need a newer analyzer. Run the tests before any `dpk get`, because `dpk get` restores the catalog constraint. It keeps the floor version in `pubspec.lock`, so the last line restores the committed lock too.
- `packages/luthor_generator/lib/src/runtime_api.dart` holds every `luthor` runtime name the generator emits, and `annotation_rules.dart` maps every annotation to the modifier it emits. When you add or rename runtime API or an annotation, update those files, add a generator test, and regenerate the example with `dpk run build`.
- Validators are optional by default: `null` and missing values pass until `.required()` is added ([ADR 0002](docs/adr/0002-validators-are-optional-by-default.md)).
- `skills/luthor/SKILL.md` is the user-facing agent skill and must match the public API. Update it in the same change as any public API change.
- `.claude/worktrees/` holds gitignored scratch worktrees with stale copies of the code. Keep searches and edits to the main tree.

## Agent skills

### Issue tracker

Issues live in GitHub Issues for `exaby73/luthor`, managed with `gh`. See `docs/agents/issue-tracker.md`.

### Triage labels

`in triage` marks issues that need triage. The other four are the defaults: `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: `GLOSSARY.md` and `docs/adr/` at the repo root. See `docs/agents/domain.md`.
