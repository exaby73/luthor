# Product

<!-- impeccable:product-schema 1 -->

All facts below were inferred from the redesign brief, the package sources under `packages/luthor/lib` and `packages/luthor_generator/lib`, and the existing docs content. No interview took place. Treat each entry as a hypothesis the maintainer can correct.

## Platform

web

## Users

Dart and Flutter developers who validate runtime input: HTTP request bodies on a Dart server, form state in a Flutter app, JSON from a third party, uploaded files. Many arrive knowing Zod from TypeScript and want the same chainable, typed experience in Dart. A second audience already uses `freezed` or `dart_mappable` models and wants validation generated from those classes instead of written twice.

## Product Purpose

Luthor is a pure Dart validation library. `l.string().email().required()` builds an immutable validator with a typed output; `validate` and `validateSchema` return one sealed `ValidationResult` instead of throwing, with every issue carrying a code, a path and a message. `luthor_generator` reads `@luthor` classes and emits a schema, a `$ClassValidate` function, a `validateSelf()` extension, and typed `SchemaKeys` and `ErrorKeys` records. Success is a developer going from `dart pub add luthor` to a validated, typed model in one sitting, and reaching for the generator without reading the source.

## Positioning

Zod's chainable schema style, in Dart, with a code generator that turns existing `freezed` or `dart_mappable` classes into validators and typed error keys. Values are optional by default; `.required()` is explicit. Errors are data (maps and lists keyed by field path), not exceptions.

## Operating Context

Read inside an editor or terminal session while writing Dart. Pages are opened from pub.dev, from search, or from the GitHub README. Readers copy code blocks constantly, switch between hand-written and generated code paths, and look up one modifier at a time (for example "does `uri` take allowed schemes").

## Capabilities and Constraints

- Release 1.0.0. Requires Dart 3.11 or Flutter 3.41 or later. `luthor` has no dependencies. `luthor_generator` supports analyzer 10 through 14.
- Install snippets use `^1.0.0`.
- Public API lives in `packages/luthor/lib`; generator behaviour in `packages/luthor_generator/lib`. Docs must not describe API that is not there.
- Types on `l`: `any`, `bool`, `int`, `double`, `num`, `string`, `file`, `nullValue`, `list`, `map`, `schema`, `union`, `oneOf`. Shared modifiers: `required`, `withName`, `custom`, `customWithSchema`; schema modifiers `passthrough` and `strict`; `forwardRef()` for recursive schemas; global `l.messageBuilder` and `l.maxDepth`.
- String modifiers: `min`, `max`, `length`, `contains`, `startsWith`, `endsWith`, `dateTime`, `email`, `emoji`, `regex`, `uri`, `url`, `uuid`, `cuid`, `cuid2`, `ip`.
- Number modifiers: `min`, `max`, `finite` on `int`, `double`, `num`.
- Every validation accepts `message` and `messageBuilder`.
- Generator annotations mirror the modifiers (`@IsEmail`, `@HasMin`, `@MatchRegex`, `@IsFile`, `@WithCustomValidator`, `@WithSchemaCustomValidator`, and so on). `@luthorForwardRef` is deprecated.
- Docs site: Astro 7 + Starlight 0.42, npm, no Tailwind. Deployed at https://luthor.ex3.dev. Starlight stays the framework.

## Brand Commitments

- Name: Luthor. Existing mark is a bare "L" glyph (`public/favicon.svg`).
- Author: Nabeel Parkar (ex3.dev). GitHub: exaby73/luthor.
- No other binding visual constraints were given; the previous dark-only pink-accent theme is evidence of what the subject is, not an instruction to keep.

## Evidence on Hand

- Real API and generator source in the monorepo.
- Real changelog in `packages/luthor/CHANGELOG.md`.
- No testimonials, adoption numbers, or benchmarks. Do not invent any.

## Product Principles

- Show the result type, never just "it validates". Every example ends in a `switch` or a printed error.
- Hand-written and generated paths are the same schema; the docs show both side by side rather than hiding one.
- Reference pages are dry and complete: signature, parameters, default message, generator annotation.
- A newcomer path exists in the sidebar order: install, first validator, first schema, generate, then look things up.

## Accessibility & Inclusion

Keyboard-navigable docs, WCAG AA contrast in both themes, readable at phone width, respects `prefers-reduced-motion`.
