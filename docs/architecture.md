# How Luthor fits together

Luthor has two packages. `packages/luthor` is the runtime, and `packages/luthor_generator` is a `source_gen` builder that writes validators for annotated models. The generator imports the runtime only for its annotation classes and writes every runtime name as a string. For the words used here, see [`GLOSSARY.md`](../GLOSSARY.md).

## The runtime

All validator code is one library, `lib/src/validator.dart`, with its parts in `lib/src/validator/`. One library lets every validator class reach the private `_Spec`, `_Check`, and `_Context` types while users see only the public classes.

### Validators are immutable and self-typed

Type methods exist only on `l`, so `l.string().int()` does not compile. A modifier never changes its receiver. It copies the `_Spec` with one more `_Check` into a new validator of the same class, through `_copy`, so a validator is safe to share. Only `required()` changes the output type `O`, so each class declares its own.

`l.messageBuilder` and `l.maxDepth` are mutable, but `validate` copies them into the root context once. Changing them affects the next validation, never one already running.

### Validations are stateless and read a context

A `_Check` keeps no state between calls. Its test receives the value and a `_Context`, which carries everything that depends on where the value sits: the path, the field name, the enclosing schema's data, the depth, and the snapshot of the global settings. An older version stored schema data on validations, which broke recursive schemas and leaked data between validations. A child gets a new context from `child()`, one path segment deeper, or from `nested()`, at the same path.

`Validator._run` checks a value in a fixed order:

1. A `null` value passes, or fails with a `required` issue. Nothing else runs.
2. The type check runs. If it fails, validation stops with that one issue.
3. Schemas, lists, maps, and unions validate their children in `_convert`, which also builds the output. If any child failed, validation stops there.
4. Every check runs, in the order the modifiers were added.

Step 3 is why `.custom()` on a schema, list, map, or union runs only when every child passed, so the function receives well-typed data.

### Issues are the source of truth

A failed validation produces `ValidationIssue`s. Every error view on `ValidationResult` is computed from them, on the sealed base class, so you can read errors without matching on the result first.

`_Context.issue` builds the message when it creates the issue, so a message builder receives the issue with the default English message already set and can fall back to `issue.message`.

`IssueCode` is an extension type over `String`, not an enum, so a minor release can add a code. A user's `switch` on a code needs a default case.

### Error paths are flat

An issue's path is a list of schema keys, map keys, and list indices. The error map is keyed by the dot-joined path, such as `items.1.id`, so one `getError` lookup finds an error at any depth. The cost is that a key containing a dot reads like two segments.

Two rules keep paths from colliding:

- `.custom()` on a schema reports an object-level error at the schema's own path. At the root that path is `''`, which no field error uses.
- A map key that fails its key validator becomes one `invalidKey` issue at the map's path, with the key validator's issues in `params['issues']`. Value errors sit at the key's path, so key and value errors never share a path.

### Unknown keys are stripped by default

`SchemaValidator._convert` builds its output from the declared fields only. An unknown key, including any non-string key, is dropped by default, copied unvalidated by `.passthrough()`, and reported as `unrecognizedKey` by `.strict()`.

Stripping matters for the generator. `validateSchema` passes the stripped map to `fromJson`, so any key a serializer reads must be a schema field, or the schema must pass unknown keys through (see [The serializer defines the fields and their keys](#the-serializer-defines-the-fields-and-their-keys)).

A missing field is skipped before any of its validations run, unless its validator is required ([ADR 0002](adr/0002-validators-are-optional-by-default.md)).

### Forward references and the max-depth guard

Schemas, lists, maps, and unions hold their children as `ValidatorReference`s and call `resolve()` inside `_convert`, at validation time. `forwardRef(() => schema)` calls its closure on each `resolve()`, so a schema can refer to itself or to a schema declared later.

Recursion then follows the input, so the remaining risk is deep input, which costs one stack frame per level. Each `child()` and `nested()` context adds one to the depth, and a container whose depth exceeds `l.maxDepth` stops with a `tooDeep` issue instead of descending. The guard fails closed, so data past the limit is reported, never accepted.

### Schema custom validators see raw input

A schema custom validator receives `SchemaData` holding the raw sibling input, not validated values. A sibling that failed validation still appears with its raw value. Each schema passes its `SchemaData` to its fields through `child(schema: data)`. Lists, maps, and unions pass the enclosing data down unchanged, so a `customWithSchema()` on a list element sees the fields of the schema that holds the list. A schema's own `customWithSchema()` runs in its parent's context and receives the parent's data. Outside any schema, the data is empty.

## The generator

### One plan per library

`LuthorGenerator.generate` runs once per library and builds one `LibraryPlan` for everything that depends on that library: which names are visible and through which import prefix (`LibraryReferences`), the models read so far (`ModelReader`), annotation values written back as source with the right prefix (`ConstantSource`), and the auto-generated schema names handed out. `LibraryEmitter` writes each model, then emits auto-generated schemas in a loop, because emitting one can discover more.

### One function maps types to validators

`FieldValidators._forType` (`field_validators.dart`) is the only place that turns a Dart type into a validator. It handles a field, a list element, and a map value alike. Map keys go through `_forKey` instead, because JSON object keys are always strings. `_forType` also returns the `FieldKind` that the annotation rules check against. An enum maps to `l.oneOf` with the values the serializer writes, which `enum_values.dart` reads.

### Annotations go through a rule table, and runtime names through one module

`annotationRules` in `annotation_rules.dart` holds one `AnnotationRule` per annotation: the method to emit, the field kinds it applies to, the arguments to pass, and its effect. A `modifier` appends in the order the annotations are written, a `refinement` (the custom validators) appends after every modifier, and an `entry` (`@IsFile`) replaces the base validator without mapping the declared type. An annotation on a field kind outside its `appliesTo` fails generation.

`runtime_api.dart` renders every expression to source and holds every `luthor` name the generator writes, so a runtime rename is a one-file change on the generator side. Generator tests that compile the output against the real runtime catch a name the file missed.

### The serializer defines the fields and their keys

A schema must describe what `fromJson` reads. `ModelReader._selectConstructor` picks the constructor the serializer calls, and each of its parameters becomes a field. For a `@JsonSerializable` class, settable public fields the constructor does not set also become fields, because `json_serializable` assigns them after construction.

A field's key is the map key the serializer reads. `field_naming.dart` reimplements the `fieldRename` and `caseStyle` rules of both serializers, so it must stay in step with them.

Some serializers read keys that are not fields, which stripping would remove before `fromJson` runs. The model gets `.passthrough()` when a field uses `@JsonKey(readValue:)`, when a private field has `@JsonKey(includeFromJson: true)`, or when the class has `@MappableClass(hook:)`. A field whose JSON shape a converter decides is validated as `l.any()`.

### Nested classes get public or private schemas

`LibraryPlan.schemaReference` uses a `@luthor` class's public `$<Model>Schema` when that name is visible in the library. Any other serializable class gets a private `_$<Class>Schema`, emitted once per library. Private copies let two libraries that nest the same class be imported together without a name clash. The cost is duplication, and the copies get no `SchemaKeys`, `ErrorKeys`, validate function, or `validateSelf()`. Annotating the class with `@luthor` gives it one public schema.

### Every nested schema goes through `forwardRef`

Generated schemas are lazily initialized top-level `final` variables, so a schema whose initializer reads itself, directly or through another schema, overflows the stack. The generator could detect cycles, but a cycle can run through models in other libraries. Wrapping every `SchemaRef` in `forwardRef` costs one closure call per nested value and removes the question, which is why `@luthorForwardRef` is deprecated. Each schema declares its type, `final SchemaValidator $XSchema`, because inferring it would go through the closure back to the variable itself.

### `validateSelf` normalizes `toJson` output

With `explicitToJson: false`, `toJson()` leaves nested models as objects where the schema expects maps, so `validateSelf()` passes `json_serializable` and freezed output through the generated `_$luthorJsonMap` helper first.

### Unsupported input fails at build time

Input the generator cannot handle throws an `InvalidGenerationSourceError` that carries the element, so `build_runner` points at the field. The 0.x generator emitted code that skipped validation or did not compile instead.

## The workspace and CI

`examples/luthor_generator` resolves outside the pub workspace, for the reasons in [ADR 0001](adr/0001-generator-example-lives-outside-the-workspace.md). `AGENTS.md` covers the analyzer range and how to test its floors. The `flutter-3.41-smoke` job is the only check that runs with the `meta` version Flutter pins, the constraint that sets the analyzer floor.

## Adding things

Every public API change also updates `skills/luthor/SKILL.md` and the docs under `website/src/content/docs`.

### A modifier

- Add the method to its validator class, returning that class. String and number modifiers go through the class's `_with` helper. A modifier every validator needs goes in `_Modifiers`.
- Add an `IssueCode` in `validation_issue.dart` when no code fits, and document its params.
- Test it, and decide whether it needs an annotation.

### A type

- Add a method to `ValidatorFactory` (`validator/factory.dart`) that starts with `_typeCheck`.
- Add a `final class` in a part of `validator.dart` that mixes in `_Modifiers`, implements `_copy`, and declares a narrowing `required()`.
- If it holds children, override `_nests` to return `true` and validate them in `_convert`, with `child()` for a child that has its own path segment and `nested()` otherwise.
- For the generator, add an `EntryType` in `runtime_api.dart` and a `FieldKind` in `annotation_rules.dart`, map the Dart type in `_forType` (and `_forKey` if it can be a map key), and add the kind to the rules that apply to it.

### An annotation

- Add the annotation class in `packages/luthor/lib/src/annotations/validators/` with `message` and `messageBuilder` fields, export it from `lib/luthor.dart`, and add a `const` instance when it takes no required arguments.
- Add an `AnnotationRule` to `annotationRules`. A `named` entry is also the emitted argument name, so it must match the modifier's parameter.
- Test the emitted code and placement errors in `packages/luthor_generator/test` with the helpers in `test/utils/generator_test_utils.dart`.
- Use it in a model under `examples/luthor_generator/lib`, run `dpk run build`, and commit the generated files.
