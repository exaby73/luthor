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

Terminology follows `GLOSSARY.md` at the repository root. Example outputs are taken from running the code against the packages in this repository; keep them that way when editing.
