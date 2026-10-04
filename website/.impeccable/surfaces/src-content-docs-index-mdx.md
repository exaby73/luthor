---
version: 1
slug: "src-content-docs-index-mdx"
primary_target: "src/content/docs/index.mdx"
related_targets: ["src/styles/theme.css","astro.config.mjs"]
---

# Surface brief: Luthor docs (Starlight site, all routes)

Scope: the whole docs site at https://luthor.ex3.dev. Visitor mode: Read. The landing page is the one Persuade-leaning route but stays inside the Read world.

Audience and job: Dart and Flutter developers validating runtime input, many coming from Zod. Job: install, write a first validator and schema, adopt the generator, then look up one modifier at a time. Content: real API from packages/luthor/lib and packages/luthor_generator/lib. Constraints: Starlight stays, both themes, phone width, `^1.0.0`, Dart 3.11 / Flutter 3.41, analyzer 13 and 14.

## Direction contract

THESIS: Validation docs are a test report. Every example states an input and prints its verdict the way `dart test` does, with `+n -n` counters and the matcher's Expected / Actual / Which lines, so the result type is never abstract. Refused: the stock dark docs hero with two pill buttons and a tagline.

OWN-WORLD: Report paper. Light: cool near-white sheet, iron ink, hairlines at exactly 1px. Dark: graphite-blue panel, bone ink, same hairlines. Color is rationed by role: pass green is the only accent and marks links, the current page, and passed rows; fail red appears only on failed rows and error text; amber only for pending or caution. One sans with unambiguous glyphs (Atkinson Hyperlegible Next) for prose, its mono sibling for code and counters. No cards, no gradients, no glow. States are marks, not fills: a 2px rule for the current sidebar item, a bracket on focus.

STORY: A developer lands, sees a schema validated against three inputs with the verdict printed, copies `dart pub add luthor`, follows four numbered steps (install, first validator, first schema, generate), and later returns to a reference page that states the signature, parameters, default message, and the matching annotation.

FIRST VIEWPORT: Desktop two columns. Left: wordmark line, headline "Validation for Dart that returns a result instead of throwing", one sentence, the install command as a copyable line, two text links (Start, API reference). Right: the report figure, a schema of three fields run against three inputs, rows revealing in sequence with the counter ticking `+2 -1`. Below the fold: the four-step path, then the result-type explanation, then the full validator and modifier index as a dense ruled table.

FORM: Grounded candidate 6 of 7, the `dart test` report. Seed key eef31a93. Raises from declined challengers: color rationed by role (Bauhaus workshop); every rule at 1px and states as printed marks (centre-rail reference setting); current markers as line form, not hue (emission-line rail); the hand-written / generated switch persisted and placed in the same spot on every page (cutting bench); one left axis aligning headings, code, verdict blocks (deep dive). Competitive alternate kept: brick instructions, donating line-level highlighting of what each tutorial step adds.

FINISH: unreviewed and undocumented is unfinished; this build ends with the finish review, the verdict, DESIGN.md, and every shipping raster carrying its provenance.
