# How Luthor fits together

Luthor has two packages. `packages/luthor` is the runtime. You build a validator from `l`, validate a value, and get a typed result or a list of issues. `packages/luthor_generator` is a `source_gen` builder that writes those validators for annotated models. It imports the runtime only for its annotation classes, and writes every runtime name as a string. For the words used here, see [`GLOSSARY.md`](../GLOSSARY.md).

## The runtime

All validator code is one library, `lib/src/validator.dart`, with its parts in `lib/src/validator/`. Keeping it one library lets every validator class reach the private `_Spec`, `_Check`, and `_Context` types while users see only the public classes.

### Every validator starts from `l`

`l` is the only instance of `ValidatorFactory` (`validator/factory.dart`). Its methods start each validator, usually with a type check: `l.string()`, `l.int()`, `l.list(element)`, `l.schema(fields)`, `l.union(options)`, `l.oneOf(values)`, and the rest. Type methods exist only on `l`, so a chain such as `l.string().int()` does not compile.

`l` also holds the two global settings, `messageBuilder` and `maxDepth`. They are mutable fields, read once at the start of each `validate` call, so changing them affects the next validation and never one already running.

### Validators are immutable and self-typed

`Validator<O>` (`validator.dart`) is the base class. `O` is the output type: `l.string()` is a `StringValidator<String?>`, and `.required()` returns a `StringValidator<String>`. Success data is typed without code generation.

A validator holds a `_Spec`: its name, its type check, its optional required check, and an ordered list of checks. A modifier never changes the receiver. It copies the spec with one more check and wraps it in a new validator of the same class, so a validator is safe to share and reuse.

The `_Modifiers<T, O, Self>` mixin gives every validator class `withName()`, `custom()`, and `customWithSchema()`, each returning `Self`. Each class implements `_copy` to rebuild itself from a spec, and its own modifiers, such as `StringValidator.email()`, return the same class. That is why modifiers chain in any order and `l.string().required().min(3)` keeps its type. Only `required()` changes the type, so each class declares its own `required()` to narrow `O`. `NullValidator` has no `required()`, since a required value can never be `null`.

### Validations are stateless and read a context

A validation is a `_Check` (`validator/check.dart`): an issue code, a test function, a default message, params, and the per-validation `message` and `messageBuilder`. The test receives the value and a `_Context` (`validator/context.dart`). A `_Check` keeps no state between calls. An older version stored schema data on validations, which broke recursive schemas and leaked data between validations.

`_Context` carries everything that depends on where the value sits: the path, the field name, the enclosing schema's data, the depth, and the snapshot of the global settings. `validate` builds a root context, and each child gets a new one from `child()` (one path segment deeper) or `nested()` (same path, used for union options and map keys).

`Validator._run` checks a value in a fixed order:

1. A `null` value passes, or fails with a `required` issue. Nothing else runs.
2. The type check runs. If it fails, validation stops with that one issue.
3. Schemas, lists, maps, and unions validate their children in `_convert`, which also builds the output. If any child failed, validation stops there.
4. Every check runs, in the order the modifiers were added, and each failing check adds an issue.

Step 3 is why `.custom()` on a schema, list, map, or union runs only when every child passed, so the function receives well-typed data.

### Issues are the source of truth

A failed validation produces `ValidationIssue`s (`validation_issue.dart`), each with an `IssueCode`, a path, a message, params, and a field name. `ValidationResult` (`validation_result.dart`) is sealed, with two subclasses. `ValidationSuccess` holds the output, and `ValidationFailure` holds the input and the issues. `messages`, `errors`, `getError()`, and `getErrors()` are computed from the issues, and they exist on the base class, so you can read them without matching on the result first.

The message is built when the issue is created, in `_Context.issue`. A per-validation `message` wins. Otherwise a per-validation `messageBuilder` runs, then `l.messageBuilder`, and the default English message is the fallback. A builder receives the issue with the default message already set, so it can fall back to `issue.message`.

`IssueCode` is an extension type over `String`, not an enum, so a minor release can add a code. A user's `switch` on a code needs a default case.

### Error paths are flat

An issue's path is a list of schema keys, map keys, and list indices. `errorPath` joins it with dots, and the error map is keyed by that string: `address.city`, `items.1.id`. There is no nested error tree, so one lookup with `getError('items.1.id')` finds an error at any depth. The cost is that a key that contains a dot reads like two segments.

Two rules keep paths from colliding:

- `.custom()` on a schema reports an object-level error at the schema's own path. At the root, that path is `''`, and field errors never use it.
- A map key that fails its key validator becomes one `invalidKey` issue at the map's path, with the key validator's issues in `params['issues']`. Value errors sit at the key's path, so key and value errors never share a path.

### Unknown keys are stripped by default

`SchemaValidator._convert` (`validator/schema_validator.dart`) builds its output from the declared fields only. A key the schema does not declare, including any non-string key, is an unknown key. By default it is dropped from the output. `.passthrough()` copies it unvalidated, with the key converted by `toString()`. `.strict()` reports an `unrecognizedKey` issue at the key's path.

Stripping matters for the generator. `validateSchema` passes the stripped map to `fromJson`, so any key a serializer reads must be a schema field, or the schema must pass unknown keys through. The generator handles both cases (see [Field keys follow the serializer](#field-keys-follow-the-serializer)).

A missing field is skipped before any of its validations run, unless its validator is required ([ADR 0002](adr/0002-validators-are-optional-by-default.md)). A field that is present with a `null` value runs `_run`, passes, and appears in the output as `null`.

### Forward references and the max-depth guard

Schemas, lists, maps, and unions hold their children as `ValidatorReference<O>`, an interface with one method, `resolve()`. Every `Validator` resolves to itself. `forwardRef(() => schema)` returns a reference that calls the closure on every `resolve()`. Containers call `resolve()` inside `_convert`, at validation time, so a schema can refer to itself or to a schema declared later.

Recursion then follows the input, and finite input ends. Deep input is the remaining risk, because a recursive schema walks deeply nested input one stack frame per level. Each `child()` and `nested()` context adds one to the depth, and a schema, list, map, or union whose depth exceeds `l.maxDepth` (512 by default) stops with a `tooDeep` issue instead of descending. The guard fails closed. Data past the limit is reported, never accepted.

### Schema custom validators get `SchemaData`

When a schema validates its fields, it builds a `SchemaData` from its input: a read-only view of every key in the input, converted to strings, with the raw input values. Its `root` getter returns the outermost schema's data. The schema passes it to each field through `child(schema: data)`.

Lists, maps, and unions create child contexts without new data, so their children keep the enclosing schema's data. That is how a `customWithSchema()` on a list element sees the fields of the schema that holds the list. Outside any schema, the function receives empty `SchemaData`. A schema's own `customWithSchema()` runs in its parent's context, so it receives the parent schema's data.

The values are the input, not the validated output. A sibling field that failed validation still appears in `SchemaData` with its raw value.

## The generator

`lib/builder.dart` exposes `luthorBuilder`, a `SharedPartBuilder` that writes `.luthor.g.part` files. `build.yaml` applies `source_gen:combining_builder`, which merges those parts into the library's `.g.dart`. The generated schema shares that file with `json_serializable`'s output, and a project without `json_serializable` still gets one.

### One plan per library

`LuthorGenerator.generate` (`lib/src/luthor_generator.dart`) runs once per library. It finds the `@luthor` classes, rejects any that are not classes or have neither a `fromJson` nor a `@MappableClass`, and builds one `LibraryPlan` (`library_plan.dart`) for the library. The plan holds everything that depends on the library being generated:

- `LibraryReferences` (`references.dart`) answers how a name is visible here: directly, through an import prefix, or not at all, following `show` and `hide` combinators and re-exports.
- `ModelReader` (`model.dart`) reads a class into a `Model` and caches it.
- `ConstantSource` (`constant_source.dart`) writes annotation values, such as numbers, strings, enum constants, and function references, back as Dart source, with the prefix this library needs.
- The auto-generated schema names this library has handed out.

`LibraryEmitter` (`library_emitter.dart`) writes each model, then emits the auto-generated schemas. Emitting one can discover more, so it loops until none are pending. It writes the JSON helpers last, once.

### One function maps types to validators

`FieldValidators._forType` (`field_validators.dart`) is the only place that turns a Dart type into a validator. It handles a field, a list element, and a map value the same way, recursing into type arguments. Map keys go through `_forKey` instead, because JSON object keys are always strings. An `int` key becomes `l.string()` with a `custom` check that the key parses, and an enum key becomes `l.oneOf` with the serialized values as strings.

The result is a `ValidatorExpr` (`validator_expr.dart`): a base (`TypeEntry`, `AllowedValues`, `ListOf`, `MapOf`, or `SchemaRef`), a list of modifiers, and a required flag. A type is required when it is non-nullable and is neither `dynamic` nor `Null`. A field is required when its type is required and it has no default: no constructor default, no freezed `@Default`, and no `@JsonKey(defaultValue:)`. Next to the expression, `_forType` returns a `FieldKind`, which the annotation rules check against.

Two type choices are worth knowing. `DateTime` maps to `l.string().dateTime()`, since JSON carries it as a string. An enum maps to `l.oneOf` with its serialized values, which `enum_values.dart` reads the way the serializer writes them: the constant names after any `@JsonEnum` or `@MappableEnum` renaming, or the values from `@JsonValue`, `@JsonEnum(valueField:)`, and `@MappableValue`.

### Annotations go through a rule table, and runtime names through one module

`annotation_rules.dart` holds `annotationRules`, one `AnnotationRule` per annotation. A rule names the annotation class, the method to emit, the field kinds it applies to, the annotation fields to pass as positional and named arguments, and its effect:

- A `modifier` (most rules) appends `.method(args)` in the order the annotations are written.
- A `refinement` (`@WithCustomValidator` and `@WithSchemaCustomValidator`) appends after every modifier.
- An `entry` (`@IsFile`) replaces the base validator, so a field becomes `l.file(accept: ...)`.

`FieldValidators.forField` applies the rules. An annotation on a field kind outside its `appliesTo` fails generation, and so does a fractional `@HasMin` or `@HasMax` on an `int` or `String` field (`integralFor`). `message` and `messageBuilder` are passed for every rule, so a rule never lists them. `.required()` comes last.

`runtime_api.dart` renders every expression to source. Every `luthor` name the generator writes is in that file: `l.schema`, the type methods, `.passthrough()`, `.withName()`, `forwardRef`, `SchemaValidator`, `ValidationResult`, and `validateSchema`. A runtime rename is a one-file change on the generator side. Many generator tests compile the generated code against the real runtime, so they catch a name the file missed.

### The serializer's constructor defines the fields

A schema must describe what `fromJson` reads, and `fromJson` calls a constructor. `ModelReader._selectConstructor` picks the same constructor the serializer uses, in this order:

1. The constructor named in `@JsonSerializable(constructor: ...)`. A name that matches no constructor fails generation.
2. Among public constructors other than `fromJson`, the one with `@MappableConstructor`.
3. The unnamed constructor.
4. The first public constructor with parameters.

Each constructor parameter becomes a field. Annotations are read from the parameter, from the field it initializes, and through `super.` parameters from the superclass's fields. For a `@JsonSerializable` class, public fields with a setter that the constructor does not set also become fields, because `json_serializable` assigns them after construction. A field with `@JsonKey(includeFromJson: false)` or `@JsonKey(ignore: true)` is left out.

A freezed union, which has more than one redirecting factory, fails generation, because one schema describes one constructor.

### Field keys follow the serializer

A field's key is the map key the serializer reads. An explicit `@JsonKey(name:)` or `@MappableField(key:)` wins. Otherwise `field_naming.dart` applies the class's rename rule: `fieldRename` from the `@JsonSerializable` on the selected constructor (where freezed puts it) or on the class, or `caseStyle` from `@MappableClass`. `field_naming.dart` reimplements both serializers' rules, so it must stay in step with them. The key appears in the schema, in `<Model>SchemaKeys`, and in the paths of `<Model>ErrorKeys`.

Some serializers read keys that are not fields, and stripping would remove them before `fromJson` runs. The model gets `.passthrough()` when a field uses `@JsonKey(readValue: ...)`, when a private field has `@JsonKey(includeFromJson: true)`, or when the class has `@MappableClass(hook: ...)`. A `readValue` field is validated as an optional `l.any()`, since its value may come from anywhere in the map. A field with a `JsonConverter` or `@JsonKey(fromJson: ...)` is also `l.any()`, because its JSON shape is whatever the converter accepts.

### Classes without `@luthor` get private schemas

When a field's type is a class, `LibraryPlan.schemaReference` decides what to reference. A `@luthor` class whose public `$<Model>Schema` is visible in this library, directly or through an import, is referenced by that name, with its import prefix. Any other serializable class, including a `@luthor` class hidden by a `show` or `hide` combinator, gets an auto-generated schema named `_$<Class>Schema`, with a number added when the name is taken.

Auto-generated schemas are private and emitted once per library. Two libraries that nest the same class can then be imported together without a name clash. The cost is duplication. Each library carries its own copy, and none of them gets `SchemaKeys`, `ErrorKeys`, a validate function, or `validateSelf()`. Annotating the class with `@luthor` gives it one public schema and that API.

### Every nested schema goes through `forwardRef`

`SchemaRef` always renders as `forwardRef(() => $AddressSchema.required())`. Generated schemas are top-level `final` variables, which Dart initializes lazily on first read. A schema whose initializer reads itself, directly or through another schema, overflows the stack the first time it is read. The generator could detect cycles instead, but a cycle can run through models in other libraries. Wrapping every reference costs one closure call per nested value and removes the question, so `@luthorForwardRef` is still accepted but has no effect.

The closure is also why each schema is declared as `final SchemaValidator $XSchema`. Inferring the type would go through the closure, back to the variable itself.

### `validateSelf` normalizes `toJson` output

`validateSelf()` validates an existing instance by turning it back into a map. It is generated only when the model can produce one: a `toJson` on the class or a supertype, a `toJson` that freezed will generate for a class with `fromJson` (unless `@Freezed(toJson: false)` or `@JsonSerializable(createToJson: false)` turns it off), or a `dart_mappable` `toMap()`.

`toJson()` output is not always what the schema expects. With `json_serializable`'s `explicitToJson: false`, nested models stay objects, and the schema expects maps. For `json_serializable` and freezed models, `validateSelf()` passes `toJson()` through the generated `_$luthorJsonMap` helper first. The helper converts keys to strings and iterables to lists, and calls `toJson()` on nested objects. The emitter writes the helper once per library, and only when a model there uses it. `dart_mappable` models pass `toMap()` directly.

### Generation errors name the class and field

Input the generator cannot handle fails with an `InvalidGenerationSourceError` that carries the element, so `build_runner` points at the class or field. The message names the model, the field, and the type, with advice for that kind of type. Generation fails for these cases, among others:

- generic models and fields of generic types
- freezed unions
- records, functions, SDK types without a validator, and classes that are not models
- map key types that a JSON key cannot hold
- an annotation on a field kind it does not apply to
- an annotation value that cannot be written as source, such as a function not visible from the library

For several of these, the 0.x generator emitted code that silently skipped validation or did not compile, and it threw an `UnsupportedError` with no location for unsupported types. An error at build time that points at the field is cheaper to fix.

## The workspace and CI

The repository is a pub workspace managed by dpk. `dpk.yaml` lists the members (`packages/luthor`, `packages/luthor/example`, and `packages/luthor_generator`) and holds the catalog that `dpk get` writes into their pubspecs. CI runs `dpk get --check` to fail on a pubspec that drifted from the catalog.

`examples/luthor_generator` is not a member. It uses freezed 4, which needs Dart 3.13, and a workspace resolves one version of each package for every member. Keeping it in would mean raising the packages' SDK floor or pinning the whole workspace to analyzer 10. So it resolves on its own, with path dependencies on both packages, and it sits outside `packages/luthor_generator` because pub resolves a member's `example/` folder even when the workspace does not list it. [ADR 0001](adr/0001-generator-example-lives-outside-the-workspace.md) records the decision and when to undo it. Its generated files are committed. The `example` CI job regenerates them on Dart 3.13.4 and fails when `git status` shows a change.

`luthor_generator` supports analyzer 10 to 14. The workspace resolves analyzer 14, so local runs only prove the newest version. The `test-generator` CI job runs the generator's analysis and tests three times: analyzer 10.0.0 and 13.0.0 on Dart 3.11.5, and the latest 14.x on Dart 3.13.4. Each run pins the root `analyzer` dependency with `dart pub add` after `dpk get`, then checks the version pub resolved. Code in `luthor_generator` must compile against every analyzer in the range, so an API added after 10.0.0 fails the floor run.

The `flutter-3.41-smoke` job runs `.github/fixtures/flutter_smoke/run.sh` on Flutter 3.41.9. The script creates a fresh Flutter app outside the repository, adds both packages by path next to `json_serializable`, generates code for a model, checks that `$UserSchema` exists, and analyzes the app. It is the only check that runs with the `meta` version Flutter pins, the constraint that sets the analyzer floor.

## Adding things

### A modifier

Add the method to the validator class it belongs to. String and number modifiers call the class's `_with` helper with an issue code, a test, a default message, and params. A modifier every validator should have goes in `_Modifiers`. Return the class's own type so chaining keeps working, and throw `ArgumentError` for an argument that can never be valid, as `min()` does for a negative length.

Add an `IssueCode` when no existing code fits, and document the params it sets. Then test the modifier in `packages/luthor/test`, update `skills/luthor/SKILL.md` and the docs under `website/src/content/docs`, and decide whether it needs an annotation.

### A type

Add a method to `ValidatorFactory` that starts the validator with `_typeCheck`. Add a `final class` that extends `Validator<O>` with `_Modifiers<T, O, Self>`, implements `_copy`, and declares a `required()` that narrows `O`. A type that holds child validators also overrides `_nests` to return `true`, so the depth guard applies, and `_convert` to validate the children. Create each child context with `child()` when the child has its own path segment, and `nested()` when it does not. Put the class in a part of `validator.dart`, adding the `part` directive for a new file. `lib/luthor.dart` already exports that library.

For the generator to use the type, add an `EntryType` in `runtime_api.dart` and a `FieldKind` in `annotation_rules.dart`, map the Dart type in `_forType` (and in `_forKey` if it can be a map key), and add the new kind to the rule sets of the annotations that apply to it.

### An annotation

An annotation goes through four places, in this order:

1. **The runtime annotation.** Add a `final class` with a `const` constructor in `packages/luthor/lib/src/annotations/validators/`, with `message` and `messageBuilder` fields, and export it from `lib/luthor.dart`. When the annotation takes no required arguments, also add a `const` instance, as `isEmail` is for `IsEmail`.
2. **The rule.** Add an `AnnotationRule` to `annotationRules`. `positional` and `named` list annotation field names, read from the constant by name. A `named` entry is also written as the argument name, so it must match the modifier's parameter. An `entry` rule's method must name both an `EntryType` and a `FieldKind`.
3. **The generator test.** Cover the emitted code and its placement errors in `packages/luthor_generator/test`, using `generateSharedPart`, `generationErrors`, and `expectGeneratedCodeCompiles` from `test/utils/generator_test_utils.dart`.
4. **The example.** Use the annotation in a model under `examples/luthor_generator/lib`, run `dpk run build`, and commit the generated files.

Then update `skills/luthor/SKILL.md` and the website's generator docs in the same change.
