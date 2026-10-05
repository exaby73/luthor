# Luthor documentation

The documentation site for [`luthor`](https://pub.dev/packages/luthor) and [`luthor_generator`](https://pub.dev/packages/luthor_generator), published at https://luthor.ex3.dev.

Built with [Astro](https://astro.build) and [Starlight](https://starlight.astro.build). Package manager: npm. Node 24.16 or later (see `.tool-versions` at the repository root).

```sh
npm install
npm run dev      # local server
npm run build    # astro check + astro build, output in dist/
npm run preview  # serve dist/
```

Pages live in `src/content/docs/`. The sidebar order and the redirects from old URLs are in `astro.config.mjs`. Design tokens are in `src/styles/theme.css`.

Terminology follows `GLOSSARY.md` at the repository root.

## Example outputs are generated

Every `<Verdict>` figure, `<Output>` block and `<Generated>` excerpt on the site comes from a run against the packages in this repository, not from hand-typed text. To regenerate after changing `luthor`, `luthor_generator` or an example:

```sh
scripts/run.sh
```

It runs `scripts/verdicts` (the runtime examples, Dart 3.11) into `src/data/verdicts.json`, and `scripts/generated` (the code-generation models, Dart 3.13 because of `freezed` 4) through `build_runner` into `src/data/generated.json` and `src/data/generated/*.g.dart`. Set `DART311` and `DART313` to the two SDK binaries if yours are not under `~/.asdf`. A page that references an id that is not in the data fails the build.

`scripts/check_snippets.py` extracts every Dart block from the pages and analyzes it against the same packages.

## Deploy

`Dockerfile` builds the site with Node 24 and serves `dist/` with nginx, using `nginx.conf`. That config serves `404.html` for unknown paths and redirects paths without a trailing slash. Build it with the `website/` directory as the context:

```sh
docker build -t luthor-docs website
docker run -p 8080:80 luthor-docs
```

Production builds have no `.git` directory, so pages show no "last updated" date there.
