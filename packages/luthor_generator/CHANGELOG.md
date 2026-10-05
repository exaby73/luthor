# 1.0.0

- **BREAKING**: Require Dart 3.11 or later (Flutter 3.41 or later).
- **FEAT**: Support `analyzer` 10 to 14 (`>=10.0.0 <15.0.0`), so every Flutter release from 3.41 to current is supported. Flutter 3.41 pins `meta` 1.17.0, which resolves analyzer 10.0.x; newer SDKs resolve analyzer 13 or 14.
- **FEAT**: Require `source_gen` `^4.2.0` and `build` `^4.0.4`. Both ranges resolve with every analyzer from 10 to 14.
- **FEAT**: Depend on `luthor` `^1.0.0` instead of exactly `1.0.0`, so a `luthor` patch or minor release does not need a matching `luthor_generator` release.
- **BREAKING**: Generate code for the `luthor` 1.0 API. Schemas are declared as `final SchemaValidator $XSchema = l.schema({...}).withName('X');`, with the explicit type because `forwardRef` makes inference circular. Lists use `l.list(element)`, `num` and `bool` fields use `l.num()` and `l.bool()`, and `$XValidate` and `validateSelf()` return `ValidationResult<X>`. `$XValidate` accepts any input (`Object?`), such as decoded JSON.
- **BREAKING**: Enum fields generate `l.oneOf([...])` with their serialized values, and enum map keys `l.oneOf()` with the values as strings. Map keys of type `int`, `double`, `num` and `BigInt` generate `l.string().custom((key) => int.tryParse(key) != null)` (or the matching parser), and a key that fails is an invalid key of the map.
- **BREAKING**: `@MatchRegex` generates `.regex(RegExp(r'...'))` with its `caseSensitive`, `multiLine`, `unicode` and `dotAll` flags when they are not the default. `@IsFile(accept: ...)` generates `l.file(accept: ...)`. Annotations pass `messageBuilder:` instead of `messageFn:`.
- **BREAKING**: `@HasMin` and `@HasMax` replace the `Double` and `Number` variants. A fractional value on an `int` or `String` field fails generation.
- **BREAKING**: Generated schemas strip unknown keys before `fromJson` runs, like every `luthor` 1.0 schema. Public settable fields that `json_serializable` assigns after the constructor are now schema fields, so their keys survive. Models whose serializer may read keys that are not fields (a `@JsonKey(readValue: ...)` field, a private field with `@JsonKey(includeFromJson: true)`, or a `@MappableClass(hook: ...)`) get `.passthrough()`, and a `readValue` field is validated as an optional `l.any()`.
- **BREAKING**: `@WithCustomValidator` and `@WithSchemaCustomValidator` on a `Null` field fail generation, since `l.nullValue()` has no `custom()`.
- **BREAKING**: Generated `$XSchema` variables are `final`.
- **BREAKING**: Auto-generated schemas, for classes that a model uses but that have no `@luthor`, are now private (`_$XSchema`) and emitted once per library. They no longer get public `SchemaKeys`, `ErrorKeys`, `$XValidate` or `validateSelf()`. Two libraries that nest the same class no longer clash when imported together. Annotate a class with `@luthor` to get its public API.
- **BREAKING**: Generation fails with a clear error for `freezed` unions (more than one redirecting factory; union dispatch is not supported yet), for generic models and fields of generic types, and for annotations placed on a field type they don't apply to, such as `@IsEmail` on an `int` or `@HasLength` on a `List`. These used to generate code that silently skipped validation or did not compile.
- **BREAKING**: Unsupported field types fail with an `InvalidGenerationSourceError` that names the class, the field and the type, with advice for the kind of type, instead of an `UnsupportedError` without a location.
- **BREAKING**: `validateSelf()` is generated only for models with a `toJson` method (including the one `freezed` generates) or a `dart_mappable` `toMap`. `@JsonSerializable(createToJson: false)` and `@Freezed(toJson: false)` are respected.
- **BREAKING**: Fields with a `JsonConverter` or a `@JsonKey(fromJson: ...)` function are validated as `l.any()`.
- **BREAKING**: Nested schema references are always wrapped in `forwardRef`. `@luthorForwardRef` is still accepted but has no effect, and is deprecated.
- **BREAKING**: Validation annotations are emitted in the order they are written, so `@HasMin(8) @HasMax(200)` generates `.min(8).max(200)`.
- **BREAKING**: The generator's internal libraries moved under `lib/src`. Only `package:luthor_generator/builder.dart` and `package:luthor_generator/luthor_generator.dart`, which exports it, are public.
- **BREAKING**: `luthor_generator` no longer depends on `json_annotation`, `freezed_annotation`, `dart_mappable` or `collection`. Serializer annotations are matched by name and package.
- **FIX**: Apply `source_gen:combining_builder`, so projects without `json_serializable` get a `.g.dart` file.
- **FIX**: Build the schema from the constructor the serializer uses: the one named in `@JsonSerializable(constructor: ...)`, the `@MappableConstructor`, the unnamed constructor, or the first public constructor with parameters. A private or `fromJson` constructor declared first no longer produces an empty or wrong schema.
- **FIX**: Read annotations from fields, including fields reached through `super.` parameters, as well as constructor parameters.
- **FIX**: Apply `@JsonSerializable(fieldRename: ...)` on the class or the `freezed` factory (#49), `@JsonKey(name: ...)` on fields, `@MappableField(key: ...)` and `@MappableClass(caseStyle: ...)` to schema keys and error keys.
- **FIX**: Treat fields with a constructor default or `@JsonKey(defaultValue: ...)` as optional, and leave fields with `@JsonKey(includeFromJson: false)` out of the schema.
- **FIX**: Validate enums against their serialized values (names, `@JsonValue`, `@JsonEnum(fieldRename:, valueField:)`, `@MappableEnum`, `@MappableValue`), including in lists and as map keys.
- **FIX**: An enum field with `@JsonKey(unknownEnumValue: ...)`, or a list of such enums, generates `l.string()` (`l.int()` for integer-valued enums) instead of `l.oneOf([...])`, since `json_serializable` maps unknown values to the fallback.
- **FIX**: Support `Set` and `Iterable` like `List`, `Uri` as a string, and `Object`/`Object?` as `l.any()`.
- **FIX**: Add `.dateTime()` to nullable `DateTime` fields and to `DateTime` values inside collections, and give nested maps their key and value validators, so invalid input is a validation error instead of an exception from `fromJson`.
- **FIX**: Validate `Map` keys of type `int`, `double`, `num` and `BigInt` as strings that parse to that type, since JSON object keys are always strings.
- **FIX**: Keep import prefixes on nested schemas and custom validator functions, and qualify static methods declared in extensions. A nested `@luthor` schema hidden by a `show`/`hide` combinator gets a private schema instead.
- **FIX**: Recursion through nested collections (`List<List<Node>>`, `Map<String, List<Node>>`) and mutual recursion between models no longer overflow the stack.
- **FIX**: `validateSelf()` converts nested objects with their `toJson()` before validating, so it works when `json_serializable`'s `explicitToJson` is `false`.
- **FIX**: Nested model fields in `ErrorKeys` get a `$key` entry for the field's own error. Every `ErrorKeys` entry is the flat error path that `getError` looks up, such as `home.street`.
- **FIX**: Accept `fromJson` generative constructors and static methods, not only factories.
- **FIX**: Keep the `message` and `messageBuilder` of `@IsFile`, emit `double.infinity`, `double.negativeInfinity` and `double.nan` in annotation values, escape `$` in class names passed to `withName`, and stop marking `Null` fields as required.
- **FIX**: `@IsFile` generates `l.file()` whatever the field's declared type, so a field typed as a package class such as `MultipartFile`, or a list of one, no longer fails generation as "not a luthor model".
- **FIX**: Detect `DateTime`, `Uri`, `File` and serializer annotations by library instead of by display name, so same-named types from other packages are not mistaken for them.

# 0.18.0

- **FIX**: Escape generated Dart string literals for messages, regexes, JSON keys, and other annotation values so quotes, backslashes, and dollar signs produce valid generated code.

# 0.17.0

- **FEAT**: Add code generation support for `l.file()` validator using the `@IsFile` annotation.

# 0.16.0

- **FEAT**: Update `analyzer` dependency to `^9.0.0`.

# 0.15.0

- **FEAT**: Update `build` dependency to `^4.0.0`.
- **FEAT**: Update `analyzer` dependency to `^8.0.0`.
- **FEAT**: Update `source_gen` dependency to `^4.0.0`.

# 0.14.0

- **FEAT**: Add code generation support for `Map<K, V>` types with automatic key and value validator generation. When a field is typed as `Map<String, Comment>`, the generator automatically creates validators for both the key type (`String`) and value type (`Comment`).
- **FEAT**: Add automatic `forwardRef` detection for self-referential types. The generator now automatically wraps schema references with `forwardRef()` when:

  - The field type directly matches the enclosing class (e.g., `Comment? parent`)
  - The field type is a generic containing the enclosing class (e.g., `List<Comment>? replies`, `Map<String, Comment>? mentions`)

  This prevents stack overflow errors during schema construction for recursive data structures.

- **FEAT**: Add `@luthorForwardRef` annotation support for explicit forward references. Use this annotation when you have cross-class circular references (e.g., `User` has `List<Comment>` and `Comment` has `User`) where automatic detection isn't possible, requiring explicit annotation on the constructor parameter.
- **FEAT**: Add nullable type support for map key and value validators. Nullable types in `Map<K?, V?>` correctly omit `.required()` validation when appropriate.
- **FEAT**: Add code generation support for `@IsUuid`/`@isUuid`, `@IsCuid`/`@isCuid`, `@IsCuid2`/`@isCuid2`, and `@IsEmoji`/`@isEmoji` annotations. The generator now automatically generates `.uuid()`, `.cuid()`, `.cuid2()`, and `.emoji()` validation calls respectively when these annotations are used on string fields.

# 0.13.1

- **FEAT**: Functions passed to annotations now resolve with full qualified names.
  Before, if you had a function like this:

```dart
@WithCustomValidator(MyClass.customValidator)
```

The generated code would look like this:

```dart
.custom(customValidator)
```

This causes an analysis error because the function is not found. This version fixes this by resolving the function name to the full qualified name. Now, the generated code will look like this:

```dart
.custom(MyClass.customValidator)
```

# 0.13.0

- **FEAT**: Add `messageFn` support to all validation annotations, enabling dynamic error message generation in generated schemas through top-level function references.

## 0.12.0

- **FEAT**: Update dependencies.

## 0.11.0

- **FEAT**: Add generation of type-safe `SchemaKeys` constants for schema field access with compile-time safety.
- **FEAT**: Add support for `@WithSchemaCustomValidator` annotation to enable cross-field validation in generated schemas.
- **FEAT**: Enhanced `ErrorKeys` generation with improved nested field support and dot-notation access.
- **FEAT**: Automatic JsonKey integration - SchemaKeys and ErrorKeys respect `@JsonKey` annotations for proper field mapping.

## 0.10.0

- **FEAT**: Add support for generating type safe error keys.

## 0.9.0

- **FIX**: Fix nullable DateTime handling in auto-generated schemas. Nullable DateTime fields now properly validate without requiring @luthor annotation.

## 0.8.0

- **FEAT**: Add auto-generation support for classes without @luthor annotation. Compatible classes (with fromJson constructor or @MappableClass annotation and named parameters) are now automatically discovered and schemas are generated for them when referenced in @luthor classes.

## 0.7.2

- **FIX**: Add support for nullable types and custom types in list validations. Lists can now contain nullable primitives (e.g., `List<String?>`) and custom objects with `@luthor` annotations (e.g., `List<MyClass>`).

## 0.7.1

> Note: This release has breaking changes.

- **FIX**: failedMessage not set is value is not a Map for SchemaValidation ([#108](https://github.com/exaby73/luthor/issues/108)).

## 0.7.0

> Note: This release has breaking changes.

- **BREAKING** **FEAT**(luthor_generator): Add support for Freezed 3.0 ([#106](https://github.com/exaby73/luthor/issues/106)).

## 0.6.4

- **FEAT**: Add URL validator support ([#103](https://github.com/exaby73/luthor/issues/103)).

## 0.6.3

- **FIX**: Nullable ? in generated code.

## 0.6.2

- **FEAT**: Add support for generic map validator ([#99](https://github.com/exaby73/luthor/issues/99)).

## 0.6.1

- **FEAT**: Add name support ([#98](https://github.com/exaby73/luthor/issues/98)).

## 0.6.0

> Note: This release has breaking changes.

- **BREAKING** **FIX**: Rename bool to boolean ([#97](https://github.com/exaby73/luthor/issues/97)).

## 0.5.1

- **FEAT**: Updated dependencies.

## 0.5.0

- **FEAT**(luthor_generator): Add support for dart_mappable classes ([#94](https://github.com/exaby73/luthor/issues/94)).

## 0.4.6

- **FEAT**: Add ip string validator ([#92](https://github.com/exaby73/luthor/issues/92)).

## 0.4.5

- **FEAT**(luthor_generator): Support of freezed's Default ([#87](https://github.com/exaby73/luthor/issues/87)).

## 0.4.4+2

- **FIX**(luthor_generator): Improper check for fromJson ([#88](https://github.com/exaby73/luthor/issues/88)).

## 0.4.4+1

- Update a dependency to the latest release.

## 0.4.4

- **FEAT**: Support non-freezed classes by ignoring previous requirement for factory ctors ([#82](https://github.com/exaby73/luthor/issues/82)).

## 0.4.3

- **FIX**(luthor_generator): invalid identifier.
- **FEAT**(luthor_generator): remove validate method ([#78](https://github.com/exaby73/luthor/issues/78)).
- **FEAT**(luthor_generator): remove need for validate method.

## 0.4.2

- **FEAT**(luthor_generator): remove need for validate method.
- **FEAT**: deprecate luthor_annotation ([#77](https://github.com/exaby73/luthor/issues/77)).

## 0.4.1

- **FEAT**: getErrors method ([#74](https://github.com/exaby73/luthor/issues/74)).

## 0.4.0+1

## 0.4.0

- **FEAT**(luthor,luthor_annotation,luthor_generator): add startsWith, endsWith and contains string validations ([#63](https://github.com/exaby73/luthor/issues/63)).
- **FEAT**: custom validators ([#61](https://github.com/exaby73/luthor/issues/61)).
- **FEAT**(luthor_generator): added generation for min and max validator for int, double and num.

## 0.3.2

- **FEAT**: update analyzer.

## 0.3.1

- **FEAT**(luthor_generator): add support for DateTime.

## 0.3.0

- **FEAT**(luthor_generator): validate method generates unique methods allowing multiple luthor classes in one file.

## 0.2.4

- **FIX**: dependencies.
- **FIX**(luthor): SchemaValidation null error due to covariant.
- **FEAT**(luthor_generator): Add support for JsonKey.name.
- **FEAT**(luthor_generator): luthor classes now require a validate method instead of exposing the raw schema.
- **FEAT**(luthor): add fromJson argument to validateSchema.

## 0.2.3

- **FIX**: dependencies.
- **FIX**(luthor): SchemaValidation null error due to covariant.
- **FEAT**(luthor_generator): luthor classes now require a validate method instead of exposing the raw schema.
- **FEAT**(luthor): add fromJson argument to validateSchema.

## 0.2.2

- Update `luthor_annotation` dependency to `^0.2.1`

## 0.2.0

- Minimum Dart SDK version is now 3.0.0
- Luthor classes now require a validate method to be defined instead of exposing a `schema` variable. The schema is still globally accessible via `$<name_of_class>Schema`
- `luthor_generator` will validate the new `validate` method. If it doesn't match, it will give you the code to copy/paste in your class in the error message.

## 0.1.1+2

- Update `luthor_annotation` version in pubspec.yaml

## 0.1.1+1

- Change collect to `^1.17.0` to make it compatible with Flutter 3.7

## 0.1.1

- Update README example

## 0.1.0

- [Breaking change] `schema` field is required on class with `@luthor` annotation
- Add support for nested schemas

## 0.0.1

- Initial version.
