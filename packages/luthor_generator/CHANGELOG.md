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
