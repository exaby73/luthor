# luthor_generator

`luthor_generator` is a package allowing you to generate luthor schemas with
code generation. It is a companion to
the [`luthor`](https://pub.dev/packages/luthor) package, and works with
`json_serializable`, `freezed`, `dart_mappable` and hand-written `fromJson`
factories.

## Features

- **Schema Generation** - Automatically generate validation schemas from annotated classes
- **Type-safe SchemaKeys** - Generated constants for defining schemas with compile-time safety
- **Type-safe ErrorKeys** - Generated constants for accessing validation errors with dot-notation support
- **Cross-field Validation** - Support for `@WithSchemaCustomValidator` to validate fields against other fields

## Generated Code

For each class annotated with `@luthor`, luthor_generator creates:

- `$ClassNameSchema` - The validation schema, a `final` top-level variable
- `ClassNameSchemaKeys` - Type-safe keys for schema field access
- `ClassNameErrorKeys` - Type-safe keys for error handling. A nested model
  field is a record whose `$key` is the field's own key, for example
  `UserErrorKeys.address.$key` and `UserErrorKeys.address.street`
- `$ClassNameValidate()` - Validates a JSON map and converts it with `fromJson`
  (or `ClassNameMapper.fromMap` for `dart_mappable`)
- `validateSelf()` - An extension method that validates an instance. It is
  generated only when the class has a `toJson` method (including the one
  `freezed` generates) or is a `dart_mappable` class

A model needs a `fromJson` factory, constructor or static method, or a
`@MappableClass` annotation. The schema follows the constructor the
serializer uses: the one named in `@JsonSerializable(constructor: ...)`, the
`@MappableConstructor`, the unnamed constructor, or else the first public
constructor with parameters.

Classes used by a model's fields but not annotated with `@luthor` get a
private schema (`_$ClassNameSchema`) in the library that uses them. Nested
schemas are always referenced lazily, so recursive and mutually recursive
models work without `@luthorForwardRef`, which is still accepted but has no
effect.

No `build.yaml` is needed. The builder applies `source_gen`'s combining
builder itself, so you only need a `part 'file.g.dart';` directive, even when
you don't use `json_serializable`.

## Field keys and annotations

Validation annotations can sit on the constructor parameter or on the field,
including fields reached through `super.` parameters. Schema keys follow the
serializer:

- `@JsonKey(name: ...)` and `@JsonSerializable(fieldRename: ...)`, on the
  class or, for `freezed`, on the factory constructor
- `@MappableField(key: ...)` and `@MappableClass(caseStyle: ...)`

Fields excluded with `@JsonKey(includeFromJson: false)` are left out of the
schema. Fields with a constructor default, a `freezed` `@Default` or a
`@JsonKey(defaultValue: ...)` are optional.

Global options in another builder's `build.yaml`, such as
`json_serializable`'s `field_rename`, are not read. Put them on the class.

An annotation on a field type it doesn't apply to, such as `@IsEmail` on an
`int` or `@HasLength` on a `List`, fails generation. Validation annotations
are applied in the order they are written.

## Supported field types

| Dart type | Validator |
| --- | --- |
| `String`, `int`, `double`, `num`, `bool` | `l.string()`, `l.int()`, `l.double()`, `l.number()`, `l.boolean()` |
| `DateTime` | `l.string().dateTime()` |
| `Uri` | `l.string()` |
| Enums | The serialized values, honouring `@JsonValue`, `@JsonEnum(fieldRename:, valueField:)`, `@MappableEnum` and `@MappableValue` |
| `List`, `Set`, `Iterable` | `l.list()` with an element validator |
| `Map` | `l.map()` with key and value validators |
| `dynamic`, `Object`, `Object?` | `l.any()` |
| `File` (`dart:io`), `XFile` (`cross_file`) | `l.file()` |
| A class with `@luthor`, a `fromJson` or `@MappableClass` | Its schema |

JSON object keys are always strings, so `Map` keys of type `int`, `double`,
`num` and `BigInt` are validated as strings that parse to that type. `DateTime`,
`Uri`, enum and `String` keys are also supported.

A `double` field generates `l.double()`, which rejects JSON integers. If your
backend may send `1` instead of `1.0`, type the field as `num`.

A field with a `JsonConverter` (on the field, on the class, or in
`@JsonSerializable(converters: ...)`) or a `@JsonKey(fromJson: ...)` function
is validated as `l.any()`, because luthor cannot know the shape of the raw
JSON value. Only `@WithCustomValidator` and `@WithSchemaCustomValidator`
apply to such fields.

## Not supported yet

These fail generation with an error that names the class or field:

- `freezed` unions (classes with more than one redirecting factory)
- Generic models, and fields whose type is a generic class or a type parameter
- Records, function types and types without a luthor validator, such as
  `Duration` or `BigInt` values (give these a `JsonConverter`)
- Validators for list elements ([#71](https://github.com/exaby73/luthor/issues/71))

See the [documentation][docs] for more information.

[docs]: https://luthor.ex3.dev
