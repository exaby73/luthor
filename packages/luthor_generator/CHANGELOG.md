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
