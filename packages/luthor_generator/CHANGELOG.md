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
