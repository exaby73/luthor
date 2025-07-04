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

- **CHORE**: Export validations

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

## 0.3.2+1

- **CHORE**: update docs.

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
