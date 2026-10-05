---
name: luthor
description: Use Luthor, the Zod-inspired Dart and Flutter validation library, to build validators and schemas from `l`, read validation results and issues, write custom and translated error messages, validate Flutter forms, generate schemas from models with luthor_generator, and migrate from 0.x. Use when a pubspec depends on luthor or luthor_generator, or the user mentions Luthor.
---

# Luthor

Luthor validates Dart values with validators built from `l`, a fluent API modelled on Zod. `luthor_generator` builds schemas from annotated models. This guide covers the 1.0 API, for writing validation code in a user's app.

## Read the project first

1. Read the `luthor` and `luthor_generator` versions in `pubspec.yaml`. Luthor 1.0 needs Dart 3.11 (Flutter 3.41). Below 1.0, read [MIGRATING.md](MIGRATING.md) before editing.
2. Search for `@luthor` and `part '*.g.dart'`. If models are annotated, their schemas come from the generator: read [CODEGEN.md](CODEGEN.md), edit the model, and regenerate.
3. Search for `l.messageBuilder =`. A global message builder rewrites every default message, so new validators inherit it.

## Validators

Every validator starts from `l`, the validator factory, with a type:

| Type | Accepts | Output with `.required()` |
| --- | --- | --- |
| `l.string()` | `String` | `String` |
| `l.int()`, `l.double()`, `l.num()` | `int`, `double`, any `num` | `int`, `double`, `num` |
| `l.bool()` | `bool` | `bool` |
| `l.any()` | anything | `Object` |
| `l.nullValue()` | only `null` | (no `.required()`) |
| `l.file(accept: ...)` | `File`, `TypedData`, `List<int>`, `Stream<List<int>>`, and values `accept` approves, such as `XFile` | `Object` |
| `l.list(element)` | a `List` whose elements pass `element` | `List<E>` |
| `l.map(keyValidator: ..., valueValidator: ...)` | a `Map` | `Map<K, V>` |
| `l.schema({...})` | a `Map` with named fields | `Map<String, Object?>` |
| `l.union([...])` | a value that passes any option | `Object` |
| `l.oneOf([...])` | one of fixed allowed values, compared with `==` | `T` |

Types mirror Dart types, not JSON types: `l.int()` rejects `1.0` and `'5'`, and `l.double()` rejects `1` on the VM. Use `l.num()` for JSON numbers that may arrive whole. Luthor never coerces, so parse strings into numbers before validating them as numbers.

Modifiers add validations:

- Strings: `min`, `max`, `length` (in UTF-16 code units), `email`, `dateTime` (ISO 8601), `uri(allowedSchemes:)`, `url(allowedSchemes:)`, `emoji`, `uuid`, `cuid`, `cuid2`, `ip(version: IpVersion.v4)`, `regex(RegExp(...))`, `startsWith`, `endsWith`, `contains`. `regex` matches anywhere, so anchor with `^` and `$` to match the whole string.
- Numbers: `min`, `max`, and `finite`, which rejects `NaN` and infinity (they pass `l.double()` and `l.num()` otherwise).
- Every type: `withName(name)`, and except `l.nullValue()`, `required()`, `custom(fn)` and `customWithSchema(fn)`.
- Schemas: `passthrough()`, `strict()`.

Lists and maps have no length modifiers: use `.custom((list) => list.isNotEmpty)`.

Every modifier returns a new validator of the same type, so modifiers chain in any order and a shared chain can be extended safely:

```dart
final username = l.string().min(3).max(20);
final requiredUsername = username.required(); // username is unchanged
final sameThing = l.string().required().min(3).max(20);
```

`custom(fn)` receives the typed value (a `String` for `l.string()`), and fails the value when `fn` returns `false` or throws.

### Optional by default

A validator is optional by default: `null`, and a missing schema field, pass and skip every other validation. `.required()` rejects them and narrows the output type, wherever it sits in the chain:

```dart
final StringValidator<String?> nickname = l.string().min(2);
final StringValidator<String> email = l.string().email().required();
final IntValidator<int> age = l.int().required().min(18);
```

- `.required()` accepts `''`, `0` and `[]`. Add `.min(1)` to require a non-empty string.
- Element validators are separate from the list: `l.list(l.int())` validates to `List<int?>`, `l.list(l.int().required())` to `List<int>`.
- A schema without `.required()` accepts `null` input: `schema.validate(null)` succeeds with `null` data.

## Validating and reading results

`validate(input)` accepts any `Object?`, never throws, and returns a sealed `ValidationResult<O>`, where `O` is the validator's output type:

```dart
switch (l.int().required().min(18).validate(input)) {
  case ValidationSuccess(:final data):
    print(data + 1); // data is an int
  case ValidationFailure(:final issues):
    print(issues);
}
```

Every result also has `isValid`, `issues`, `messages`, `errors`, `getError(path)` and `getErrors(path)`, which are empty or `null` on success, so code can read errors without matching first. `ValidationFailure.input` holds the raw input.

A value that fails its type check reports only that issue. A value that passes it runs every other validation, and reports each failure in chain order.

To validate and convert in one step, call `validateSchema` on a schema. It returns a `ValidationResult<T>` of the converted model:

```dart
final ValidationResult<User> result = userSchema.validateSchema(
  json,
  fromJson: User.fromJson,
);
```

`fromJson` runs only on valid data and receives the output map, without unknown keys. `null` input reports a `required` issue, and a `fromJson` that throws reports a `fromJsonFailed` issue.

## Issues and error paths

A failed result holds `ValidationIssue`s, the source of every error view. Each issue has a `code` (an `IssueCode`, such as `IssueCode.tooShort`), a `message`, `params` (such as `{'min': 8}`), a `fieldName`, a `path` (a `List<Object>`), and an `errorPath`, the path joined with dots.

Error paths are flat strings:

| Error path | Locates |
| --- | --- |
| `email` | a schema field |
| `address.city` | a field of a nested schema |
| `tags.1` | a list element, by index |
| `scores.alice` | a map value, by key |
| `''` | the validated value itself |

The empty path also holds object-level errors from `.custom()` on a root schema. A map key that fails its key validator reports an `invalidKey` issue at the map's own path. A nested schema's object-level errors are at the schema's field path, such as `address`.

- `errors` is the error map: messages grouped by error path, as `Map<String, List<String>>`.
- `getError(path)` returns the first message at exactly that path, or `null`. Paths match exactly: `getError('address')` ignores errors at `address.city`.
- `getErrors(path)` returns every message at exactly that path.
- `toString()` on a failure prints the error map with the empty path shown as `(root)`, such as `ValidationFailure(errors: {(root): [form is invalid]})`. Use `''` with `errors` and `getError`.

```dart
final result = l.schema({
  'name': l.string().required(),
  'address': l.schema({'city': l.string().required()}).required(),
}).validate({'address': <String, Object?>{}});

result.getError('name'); // name is required
result.getError('address.city'); // city is required
result.getError('address'); // null
```

To collect a subtree, filter `issues` by `issue.path.first` or `issue.errorPath.startsWith('address.')`.

Default messages name the field: its schema key inside a schema (`confirmPassword is required`), the `withName()` name when validated directly, or else `value`. For user-facing or translated text, read [MESSAGES.md](MESSAGES.md).

## Schemas

`l.schema({...})` maps field keys to validators and accepts any `Map`. The output is a new `Map<String, Object?>` holding the validated value of each field present in the input.

Unknown keys, keys the schema doesn't declare, follow the schema's mode:

- Strip (default): left out of the output.
- `.passthrough()`: copied to the output unvalidated.
- `.strict()`: reported as an `unrecognizedKey` issue at the key's path.

```dart
final address = l.schema({
  'street': l.string().required(),
  'city': l.string(),
});

final user = l.schema({
  'email': l.string().email().required(),
  'address': address.required(), // errors at address.street
  'previous': l.list(address.required()), // errors at previous.0.street
}).strict();
```

Define schemas as top-level `final` values and compose them. A nested schema needs `.required()` to reject a missing object, like any other field.

Two hooks see more than one field:

- `.custom(fn)` on a schema receives the validated output map, runs only when every field passed, and reports an object-level error at the schema's path.
- `.customWithSchema(fn)` on a field receives the field's value and a `SchemaData` of its sibling fields, and reports at the field's path.

Read [RECIPES.md](RECIPES.md) before writing either: both have rules about when they run.

## Further reading

- [CODEGEN.md](CODEGEN.md): read before adding or changing a `@luthor` model, running `build_runner`, or fixing a generation error, and for the `freezed` version to pair with the SDK.
- [MESSAGES.md](MESSAGES.md): read before changing error text: per-validation messages, a global message builder, field labels, and translation by issue code.
- [RECIPES.md](RECIPES.md): read for Flutter form fields, cross-field rules (password confirmation, date ranges, conditionally required fields), recursive schemas with `forwardRef`, and enums.
- [MIGRATING.md](MIGRATING.md): read when the project uses luthor 0.x, or code calls `validateValue`, `l.number()`, `l.boolean()`, `messageFn` or `SchemaValidationResult`.

## Working rules

- Mark every non-nullable value `.required()`, and add `.min(1)` where empty strings must fail.
- Look errors up with `getError` and an exact error path. With generated models, use the generated `ErrorKeys` instead of string literals.
- Switch on `issue.code` with a `_` default case: `IssueCode` is an open set, and minor releases add codes.
- Type schema variables that refer to themselves explicitly (`final SchemaValidator node = ...`), since `forwardRef` makes inference circular.
- After editing a model, run `dart run build_runner build`. Generated `.g.dart` files are rewritten on every build.
