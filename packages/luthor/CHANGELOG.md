# 1.0.0 (WIP)

- **BREAKING**: Require Dart 3.11 or later (Flutter 3.41 or later).
- **CHORE**: Drop the unused `meta` dependency, so `luthor` has no runtime dependencies.

## Validators

- **BREAKING**: `l` is now a `ValidatorFactory`, and type methods exist only on `l`, so `l.string().int()` no longer compiles. `l.custom()`, `l.customWithSchema()`, `l.required()` and `l.withName()` are removed from the factory: start from a type, such as `l.any().custom(...)`.
- **BREAKING**: Rename `l.number()` to `l.num()` and `l.boolean()` to `l.bool()`.
- **BREAKING**: Validators are generic over their output type. `l.string()` validates to `String?`, and `.required()` narrows it to `String`, so success data is typed without code generation. The typed classes are `StringValidator`, `NumberValidator` (with the `IntValidator`, `DoubleValidator` and `NumValidator` typedefs), `BoolValidator`, `AnyValidator`, `NullValidator`, `FileValidator`, `ListValidator`, `MapValidator`, `SchemaValidator`, `UnionValidator` and `OneOfValidator`. The public `Validator(initialValidations:)` constructor is removed.
- **BREAKING**: Every modifier returns the validator's own type, so modifiers chain in any order: `l.string().required().min(3)` compiles.
- **BREAKING**: `withName()` returns a new validator instead of renaming the receiver.
- **BREAKING**: `custom()` and `customWithSchema()` functions receive the typed value, such as a `String`, and are not called for `null`. Their typedefs are `CustomValidator<T>` and `SchemaCustomValidator<T>`.
- **BREAKING**: `customWithSchema()` functions receive `SchemaData`, a read-only map of the sibling fields with a `root` getter for the outermost schema. Inside a list, they receive the data of the schema that holds the list. Outside a schema, they receive empty data instead of passing automatically.
- **BREAKING**: `l.list(validators: [...])` becomes `l.list(element)`, with a single element validator. Use `l.list(l.any())` for any elements and `l.list(l.union([...]))` for elements that may match one of several validators.
- **BREAKING**: `regex()` takes a `RegExp` instead of a `String`, so flags such as `caseSensitive` apply and an invalid pattern fails when the validator is built.
- **BREAKING**: Schemas strip unknown keys from success data by default. `.passthrough()` keeps them and `.strict()` reports an `unrecognizedKey` issue for each one.
- **BREAKING**: Validation stops after a failed type check, so `l.int().min(1).validate('5')` reports one error instead of three.
- **BREAKING**: `l.nullValue()` has no `.required()`, since a required value can never be `null`.
- **BREAKING**: Stop exporting the `Validation` class, the concrete `*Validation` classes and internal members (`validations`, `schemaValidation`, `hasRequiredValidation`, `setSchemaDataForValidations`, `validateValueWithFieldName`, `validateSchemaWithFieldName` and the `validatingSchemas` parameters). `forwardRef()` returns a public `ValidatorReference<O>`.
- **FEAT**: Add `l.union([...])`, which accepts a value that passes any of its options (closes #24, #25 and #26).
- **FEAT**: Add `l.oneOf([...])`, which accepts only a fixed list of values, such as the serialized values of an enum.
- **FEAT**: Add `.finite()` to number validators. `NaN` and infinity are doubles, so they pass `l.double()` and `l.num()` unless `.finite()` is present.
- **FEAT**: Add an `accept:` predicate to `l.file()` for package types such as `XFile`.
- **FEAT**: Add `message` and `messageBuilder` to `l.schema()` for the "must be a map" error.
- **FEAT**: `ValidationFailure.toString()` shows object-level errors, whose error path is `''`, under `(root)`, so they no longer print as `{: [message]}`. `errors` and `getError('')` are unchanged.
- **FEAT**: Add `l.maxDepth` (default 512). Input nested deeper fails with a `tooDeep` issue.

## Results and messages

- **BREAKING**: Replace `SingleValidationResult` and `SchemaValidationResult`, and their `Success` and `Error` variants, with one sealed `ValidationResult<T>`: `ValidationSuccess<T>(data)` or `ValidationFailure<T>(input, issues)`.
- **BREAKING**: Rename `validateValue(value)` to `validate(input)`. It accepts any input and never throws.
- **BREAKING**: `validateSchema(input, fromJson:)` requires `fromJson` and accepts any input. Without `fromJson`, use `validate`, whose data is typed as `Map<String, Object?>`. A `fromJson` that throws now produces a `fromJsonFailed` issue instead of an exception, and `null` input produces a `required` issue.
- **BREAKING**: Errors are `ValidationIssue`s, each with an `IssueCode` code, a path, a message, params and a field name. The error map (`errors`) is derived from them and is flat, keyed by error path such as `'address.city'` or `'items.1.id'`. The `[DEFAULT]`, `keys` and `values` keys and the `"a.b: msg"` strings are gone.
- **BREAKING**: Errors from `.custom()` on a schema are object-level errors at the schema's own path (`''` at the root), so they no longer collide with field errors.
- **BREAKING**: List element errors are reported at the element's index. Map value errors are reported at the key's path, and map key errors are `invalidKey` issues at the map's path.
- **BREAKING**: `getError(path)` returns the first error at exactly that path, and `null` when there is none. It never throws.
- **BREAKING**: Replace `messageFn: String? Function()` with `messageBuilder: String Function(ValidationIssue issue)` on every method. The issue carries the default message, code, path, field name and params. `message:` stays as a plain-string shorthand.
- **BREAKING**: Default messages change in a few places: "must be a Map" is now "must be a map", the regex message names the pattern, and the list message no longer says "or does not match the validations".
- **FEAT**: Add `l.messageBuilder`, one global hook that builds every message without a per-validation `message` or `messageBuilder`, for example for i18n.
- **FEAT**: Add `messages`, `errors`, `getError()` and `getErrors()` to every result, so they can be read without matching on the result first.

## Annotations

- **BREAKING**: Merge `HasMinDouble`, `HasMinNumber`, `HasMaxDouble` and `HasMaxNumber` into `HasMin` and `HasMax`, which take a `num`. On a `String` field the value is the length; on a number field it is the value.
- **BREAKING**: Replace the `messageFn` parameter of every annotation with `messageBuilder`. It must be a top-level or static function, since annotation arguments are constants.
- **BREAKING**: `WithCustomValidator` takes a `bool Function(Never value)` and `WithSchemaCustomValidator` a `bool Function(Never value, SchemaData data)`, so typed functions such as `bool isEven(int value)` can be used.
- **BREAKING**: Annotation classes are `final`.
- **FEAT**: Add the `isIp` constant.
- **FEAT**: Add `caseSensitive`, `multiLine`, `unicode` and `dotAll` to `MatchRegex`, and `accept` to `IsFile`.
- **DEPRECATE**: Deprecate `LuthorForwardRef` and `@luthorForwardRef`. `luthor_generator` wraps every nested schema reference in `forwardRef()`, so the annotation has no effect. Remove it.

## Fixes

- **FIX**: Validate every level of recursive schemas built with `forwardRef()` or mutual references, instead of skipping nested levels.
- **FIX**: Keep a parent's errors when a schema recurses through a list; validations no longer store state between calls.
- **FIX**: Return a `tooDeep` issue for deeply nested input instead of throwing a `StackOverflowError`.
- **FIX**: Report errors for each list element instead of one generic message, and use the field name in list messages.
- **FIX**: Stop object-level schema errors from colliding with field errors or throwing a cast error.
- **FIX**: Match IP addresses against the whole string, and accept `::1` and `::`.
- **FIX**: Make error shapes independent of a map's runtime type arguments, so `Map<dynamic, dynamic>` input behaves like `Map<String, Object?>`.
- **FIX**: Stop `customWithSchema()` from reusing data from an earlier validation.
- **FIX**: Use the field name in the "must be a map" message of nested schemas.
- **FIX**: Pick "a" or "an" by the type name in the message for a map key or value that fails its type argument, so `l.map<String, int>()` reports `value must be an int` instead of `value must be a int`.
- **FIX**: Distinguish map key errors from value errors, and keep entry errors instead of replacing them with a `.custom()` error. Custom checks on schemas, lists, maps and unions now run only when every child passed.
- **FIX**: Honour the message builder in `ip()`.
- **FIX**: Anchor the `cuid()` pattern at the start of the string.
- **FIX**: Reject impossible dates and times in `dateTime()`, such as `2023-02-30` and `25:00`, and strings outside the ISO 8601 extended format.
- **FIX**: Require a scheme in `uri()`, and compare allowed schemes case-insensitively.
- **FIX**: Detect emoji with Unicode properties, so punctuation, currency and arrows fail and `❤️` and `1️⃣` pass.
- **FIX**: Detect files structurally in `l.file()`, so files pass in minified web builds and classes named like `UserProfile` fail.
- **FIX**: Throw an `ArgumentError` for negative lengths in `min()`, `max()` and `length()`, also in release builds.
- **FIX**: Compile the built-in patterns once instead of on every validation.
- **FIX**: Correct wrong documentation comments.

## Migrating from 0.x

| 0.x | 1.0 |
| --- | --- |
| `l.number()` | `l.num()` |
| `l.boolean()` | `l.bool()` |
| `v.validateValue(x)` | `v.validate(x)` |
| `schema.validateSchema(map)` | `schema.validate(map)` |
| `schema.validateSchema<User>(map, fromJson: User.fromJson)` | `schema.validateSchema(map, fromJson: User.fromJson)` |
| `SingleValidationResult<T>`, `SchemaValidationResult<T>` | `ValidationResult<T>` |
| `SingleValidationSuccess(data:)`, `SchemaValidationSuccess(data:)` | `ValidationSuccess(data)` |
| `SingleValidationError(errors:)` | `ValidationFailure(messages:)` |
| `SchemaValidationError(errors:)` | `ValidationFailure(errors:)` |
| `(result as SchemaValidationError).getError('a.b')` | `result.getError('a.b')` |
| `errors['[DEFAULT]']` | `result.getErrors('')` |
| `l.list(validators: [v])` | `l.list(v)` |
| `l.list(validators: [a, b])` | `l.list(l.union([a, b]))` |
| `l.list()` | `l.list(l.any())` |
| `l.custom(f)`, `l.required()` | `l.any().custom(f)`, `l.any().required()` |
| `l.withName('x').string()` | `l.string().withName('x')` |
| `l.string().regex(r'^\d+$')` | `l.string().regex(RegExp(r'^\d+$'))` |
| `messageFn: () => 'text'` | `messageBuilder: (issue) => 'text'` |
| `custom((Object? value) => ...)` | `custom((value) => ...)`, where `value` has the validator's type |
| `Validator v = l.string()` | `StringValidator v = l.string()` |
| `@HasMinDouble(1.5)`, `@HasMinNumber(1)` | `@HasMin(1.5)`, `@HasMin(1)` |
| `@HasMaxDouble(1.5)`, `@HasMaxNumber(1)` | `@HasMax(1.5)`, `@HasMax(1)` |
| `@IsEmail(messageFn: f)` | `@IsEmail(messageBuilder: f)`, where `f` takes a `ValidationIssue` |
| `@MatchRegex(r'...')` | unchanged; the generator builds the `RegExp` |

# 0.18.0

- **FIX**: Keep all string and number modifier chains immutable so reusable validators are not mutated by later `.email()`, `.uuid()`, `.min()`, `.max()`, and related calls.
- **FIX**: Preserve `withName()` across typed validators and single-value validation so generated default messages use the configured field name.
- **FIX**: Treat `l.file()` as optional for null values unless `.required()` is also present, matching other single-value validators.
- **FIX**: Avoid printing caught custom-validator exceptions while still treating thrown validators as validation failures.
- **FIX**: Return flattened errors for field-named map key/value validation failures instead of throwing when structured map errors are produced.

# 0.17.0

- **FEAT**: Add support for validating files with `l.file()` validator.

# 0.16.0

- **FEAT**: Update version to match luthor_generator.

# 0.15.0

- **FEAT**: Update version to match luthor_generator.

# 0.14.0

- **FEAT**: Add support for validating map keys and values using `keyValidator` and `valueValidator` parameters in `l.map()`. Map validation errors are structured as `{'keys': {'key1': ['error', 'messages']}, 'values': {'key1': ['error', 'messages']}}`, preventing collisions when maps contain keys named `'keys'` or `'values'`.
- **FEAT**: Add support for `forwardRef()` function to handle self-referential validators. This prevents stack overflow errors when defining schemas that reference themselves (e.g., a `Node` class with `List<Node>? children`). The `forwardRef()` function defers validator resolution until validation time, allowing recursive schema definitions.
- **FEAT**: Add `ValidatorReference` interface to unify `Validator` and `ForwardRef` types, enabling both to be used interchangeably in validation contexts.
- **FEAT**: Add `@luthorForwardRef` annotation to mark a field as using a forward reference, to be used in code generation.
- **FEAT**: Add `@IsUuid`/`@isUuid`, `@IsCuid`/`@isCuid`, `@IsCuid2`/`@isCuid2`, and `@IsEmoji`/`@isEmoji` annotations for string validation. These annotations can be used with code generation to validate UUID, CUID, CUID2, and emoji strings respectively.

# 0.13.0

- **FEAT**: Add `messageFn` parameter to all validation methods and annotations, allowing dynamic error message generation through top-level functions.

## 0.12.0

- **FEAT**: Update dependencies.

## 0.11.0

- **FEAT**: Add schema-aware custom validation with `customWithSchema()` method for cross-field validation scenarios like password confirmation.
- **FEAT**: Add `WithSchemaCustomValidator` annotation for code generation support of cross-field validation.

## 0.10.0

- **FEAT**: Add support for generating type safe error keys in luthor_generator.

## 0.9.0

- **BREAKING**: Validators are now immutable - chaining methods like `.required()` returns new instances instead of mutating the original validator. This fixes issues where reusing validators would have unexpected side effects.
- **FIX**: Fix schema validation to properly skip validation for missing optional fields.

## 0.6.1

> Note: This release has breaking changes.

- **FIX**: failedMessage not set is value is not a Map for SchemaValidation ([#108](https://github.com/exaby73/luthor/issues/108)).

## 0.6.0

> Note: This release has breaking changes.

- **BREAKING** **FEAT**(luthor_generator): Add support for Freezed 3.0 ([#106](https://github.com/exaby73/luthor/issues/106)).

## 0.5.3

- **FEAT**: Add URL validator support ([#103](https://github.com/exaby73/luthor/issues/103)).

## 0.5.2+1

- **FEAT**: Export validations.

## 0.5.2

- **FEAT**: Add support for generic map validator ([#99](https://github.com/exaby73/luthor/issues/99)).

## 0.5.1

- **FEAT**: Add name support ([#98](https://github.com/exaby73/luthor/issues/98)).

## 0.5.0

> Note: This release has breaking changes.

- **BREAKING** **FIX**: Rename bool to boolean ([#97](https://github.com/exaby73/luthor/issues/97)).

## 0.4.4

- **FEAT**: Updated dependencies.

## 0.4.3

- **FEAT**: Add ip string validator ([#92](https://github.com/exaby73/luthor/issues/92)).

## 0.4.2+1

- **FIX**(luthor): String validator return types for email and dateTime ([#84](https://github.com/exaby73/luthor/issues/84)).

## 0.4.2

- **FEAT**(luthor_generator): remove validate method ([#78](https://github.com/exaby73/luthor/issues/78)).

## 0.4.1

- **FEAT**: deprecate luthor_annotation ([#77](https://github.com/exaby73/luthor/issues/77)).
- **FEAT**: Deprecate luthor_annoation and add annotations to luthor package.

## 0.4.0

- **FEAT**: Deprecate luthor_annoation and add annotations to luthor package.

## 0.3.2

- **FEAT**: getErrors method ([#74](https://github.com/exaby73/luthor/issues/74)).

## 0.3.1+1

## 0.3.1

- **FIX**: email and emoji regex ([#67](https://github.com/exaby73/luthor/issues/67)).
- **FEAT**: override toString for validation results ([#66](https://github.com/exaby73/luthor/issues/66)).

## 0.3.0

- **FEAT**(luthor,luthor_annotation,luthor_generator): add startsWith, endsWith and contains string validations ([#63](https://github.com/exaby73/luthor/issues/63)).
- **FEAT**: custom validators ([#61](https://github.com/exaby73/luthor/issues/61)).
- **FEAT**(luthor): consolidated int and double validator to num.
- **FEAT**(luthor): added min and max validators for int, double and num.
- **FEAT**: update analyzer.

## 0.2.2

- **FIX**: redundant calls fromJson in SchemaValidationError.
- **FIX**(luthor): SchemaValidation null error due to covariant.
- **FIX**(luthor): l.list() does not validate inner values correctly.
- **FEAT**(luthor): add fromJson argument to validateSchema.

## 0.2.1

- **FIX**: redundant calls fromJson in SchemaValidationError.
- **FIX**(luthor): SchemaValidation null error due to covariant.
- **FIX**(luthor): l.list() does not validate inner values correctly.
- **FEAT**(luthor): add fromJson argument to validateSchema.

# 0.2.0

- Upgrade minimum Dart SDK version to 3.0.0
- `validate` and `validateSchema` now return sealed classes instead of Freezed unions
- Add `fromJson` argument to `validateSchema` to allow for custom JSON deserialization
- Fix a bug where `l.list()` does not validated inner values correctly ([#33](https://github.com/exaby73/luthor/issues/33))
- Fix a bug where nested schemas throw a null error when the data is empty ([#41](https://github.com/exaby73/luthor/issues/41))

# 0.1.6

- Added better documentation and examples

# 0.1.5

- Fixed a bug where errors from previous validations are persisted

# 0.1.3

- Fixes with previous release

# 0.1.1

- Add support for validating emojis with `l.string().emoji()`
- Add support for validating uuids with `l.string().uuid()`
- Add support for validating cuids with `l.string().cuid()` and `l.string().cuid2()`
- Add support for validating regexs with `l.string().regex()` and `l.string().cuid2()`
- Add better errors

# 0.1.0

- (Breaking change) Migrate `ValidationResult` to freezed's union type for better type safety

# 0.0.2

- Add string validation for Uris
- Add list validation

# 0.0.1+2

- Export `Validator` and `StringValidator` classes

# 0.0.1+1

- Add more examples to README.md

# 0.0.1

- Initial release
