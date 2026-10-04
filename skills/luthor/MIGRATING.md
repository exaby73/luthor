# Migrating from luthor 0.x to 1.0

1.0 renames most of the API and changes some behaviour without a compile error. Work through the steps in order; the migration is done when the analyzer is clean and every behaviour change below is checked.

## Steps

1. Raise the SDK to Dart 3.11 (Flutter 3.41) or later, and set `luthor` and `luthor_generator` to `^1.0.0`. On Dart 3.11 with `freezed`, use `freezed: ^3.2.5`; on Dart 3.13 or later, `freezed: ^4.0.0` (see [CODEGEN.md](CODEGEN.md)).
2. Delete any `build.yaml` entries added only for `luthor_generator`: the builder applies itself.
3. Run `dart run build_runner build --delete-conflicting-outputs` to regenerate models.
4. Run `dart analyze` and fix every error with the [renames table](#renames).
5. Check every [behaviour change](#behaviour-changes) against the project's code and tests.

## Renames

| 0.x | 1.0 |
| --- | --- |
| `l.number()` | `l.num()` |
| `l.boolean()` | `l.bool()` |
| `v.validateValue(x)` | `v.validate(x)` |
| `schema.validateSchema(map)` | `schema.validate(map)` |
| `schema.validateSchema<User>(map, fromJson: User.fromJson)` | `schema.validateSchema(map, fromJson: User.fromJson)` |
| `SingleValidationResult<T>`, `SchemaValidationResult<T>` | `ValidationResult<T>` |
| `SingleValidationSuccess(data:)`, `SchemaValidationSuccess(data:)` | `ValidationSuccess(data)`, matched as `ValidationSuccess(:final data)` |
| `SingleValidationError(errors:)` | `ValidationFailure(messages:)` |
| `SchemaValidationError(errors:)` | `ValidationFailure(errors:)` |
| `(result as SchemaValidationError).getError('a.b')` | `result.getError('a.b')` |
| `errors['[DEFAULT]']` | `result.getErrors('')` |
| `l.list(validators: [v])` | `l.list(v)` |
| `l.list(validators: [a, b])` | `l.list(l.union([a, b]))` |
| `l.list()` | `l.list(l.any())` |
| `l.custom(f)`, `l.required()` | `l.any().custom(f)`, `l.any().required()` |
| `l.withName('x').string()` | `l.string().withName('x')` |
| `l.string().int()` (chaining a second type) | one type per validator, or `l.union([...])` |
| `l.string().regex(r'^\d+$')` | `l.string().regex(RegExp(r'^\d+$'))` |
| `messageFn: () => 'text'` | `messageBuilder: (issue) => 'text'` |
| `custom((Object? value) => ...)` | `custom((value) => ...)`, where `value` has the validator's type |
| `Validator v = l.string()` | `StringValidator v = l.string()`, or let it infer |
| `@HasMinDouble(1.5)`, `@HasMinNumber(1)` | `@HasMin(1.5)`, `@HasMin(1)` |
| `@HasMaxDouble(1.5)`, `@HasMaxNumber(1)` | `@HasMax(1.5)`, `@HasMax(1)` |
| `@IsEmail(messageFn: f)` | `@IsEmail(messageBuilder: f)`, where `f` takes a `ValidationIssue` |

## Behaviour changes

These compile, so search for each one:

- **Unknown keys are stripped.** Schemas leave undeclared keys out of the output, and generated schemas strip them before `fromJson`. Code that read extra keys from the output, or a hand-written `fromJson` that reads keys outside its constructor parameters, now sees `null`. Add `.passthrough()` to keep them, or `.strict()` to reject them.
- **Error maps are flat.** `errors` is keyed by error path (`address.city`, `items.1.id`). The `[DEFAULT]`, `keys` and `values` entries and the `"a.b: message"` strings are gone. Replace code that parsed them with `getError(path)` or `issues`.
- **`getError(path)` matches exactly and never throws.** It returns `null` when no error is at that path, including parent paths of nested errors.
- **Object-level errors** from `.custom()` on a schema are at the schema's path (`''` at the root), apart from field errors.
- **List and map errors** are at the element's index (`tags.1`) and the map key's path (`scores.alice`). A failed map key is an `invalidKey` issue at the map's path.
- **Validation stops after a failed type check.** `l.int().min(1).validate('5')` reports one issue, not three. Tests that counted messages change.
- **Custom functions receive typed values** and are never called with `null`. Remove `null` checks and casts inside them.
- **`customWithSchema` receives `SchemaData`**, a read-only map of the sibling fields with `root` for the outermost schema. Outside a schema it receives empty data, and runs instead of passing automatically.
- **`validateSchema` always needs `fromJson`**, reports a `required` issue for `null` input, and turns a throwing `fromJson` into a `fromJsonFailed` issue instead of an exception.
- **`withName()` returns a new validator** instead of renaming the receiver. Assign its result.
- **Default messages changed slightly**: "must be a Map" is "must be a map", and the regex message names the pattern. Update tests that compare message text.

Generated code changes too:

- Enum fields validate against their serialized values with `l.oneOf`.
- Classes without `@luthor` used by a model get a private `_$XSchema` and no public `SchemaKeys`, `ErrorKeys`, `$XValidate` or `validateSelf()`. Annotate them with `@luthor` where code used those.
- `validateSelf()` exists only for classes with a `toJson` or a `dart_mappable` mapper.
- A nested model field's record in `ErrorKeys` gains `$key`, the field's own error path, such as `UserErrorKeys.address.$key`.
- `freezed` unions, generic models, unsupported field types, and annotations on the wrong field type now fail generation with an error naming the class and field (see [CODEGEN.md](CODEGEN.md#generation-errors)).
- `@luthorForwardRef` has no effect and can be removed.
