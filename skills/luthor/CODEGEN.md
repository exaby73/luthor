# Code generation with luthor_generator

`luthor_generator` reads a model class annotated with `@luthor` and generates its schema, its keys, and validate functions. This file is the reference for setting it up, annotating models, and fixing generation errors. The runtime API the generated code uses is in [SKILL.md](SKILL.md).

## Setup

1. Add the packages. With `json_serializable`:

   ```bash
   dart pub add luthor json_annotation
   dart pub add dev:build_runner dev:luthor_generator dev:json_serializable
   ```

   In a Flutter app, use `flutter pub add`. For `freezed` or `dart_mappable`, add their packages as well (see [Serializers](#serializers)).
2. Annotate the model with `@luthor` and add a `part` directive for the `.g.dart` file. No `build.yaml` is needed: the builder applies itself, and writes a `.g.dart` file even without `json_serializable`.
3. Run `dart run build_runner build`, or `dart run build_runner watch` while editing.

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'user.g.dart';

@luthor
@JsonSerializable(explicitToJson: true)
class User {
  const User({
    @isEmail required this.email,
    @HasMin(8) required this.password,
    this.nickname,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String email;
  final String password;
  final String? nickname;
  final Address address;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Address {
  const Address({required this.city});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  final String city;

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
```

## What gets generated

For a model `User`:

| Name | What it is |
| --- | --- |
| `$UserSchema` | The generated schema: a `final SchemaValidator`, named `User` with `withName`. |
| `UserSchemaKeys` | A `const` record of field keys as they appear in the input map, such as `UserSchemaKeys.email`. Use it when building input maps or schemas by hand. |
| `UserErrorKeys` | A `const` record of error paths for `getError`. A nested model field is a record: `UserErrorKeys.address.$key` is the field's own error path (`address`), and `UserErrorKeys.address.city` is `address.city`. |
| `$UserValidate(Object? json)` | Validates any input, such as decoded JSON, and converts it with `fromJson` (or `UserMapper.fromMap` for `dart_mappable`). Returns `ValidationResult<User>`. |
| `user.validateSelf()` | An extension method that validates an existing instance. Generated only when the class has a `toJson` (including the one `freezed` writes) or is a `dart_mappable` class. |

```dart
final result = $UserValidate(json);
switch (result) {
  case ValidationSuccess(:final data):
    print(data.email);
  case ValidationFailure():
    print(result.getError(UserErrorKeys.email));
    print(result.getError(UserErrorKeys.address.city));
}
```

Validate input with `$UserValidate`. `$UserSchema` is not required at the top level, so `$UserSchema.validate(null)` succeeds, while `$UserValidate(null)` reports `User is required`.

A list of models gets one `ErrorKeys` entry for the list. Build element paths from it: `'${OrderErrorKeys.items}.0.name'`.

A class without `@luthor` that a model's field uses, such as `Address` above, gets a private schema (`_$AddressSchema`) in the model's library, with no public keys or validate function. Annotate it with `@luthor` to get them.

Recursive and mutually recursive models work as they are: nested schemas are always wrapped in `forwardRef`. `@luthorForwardRef` is deprecated: it is accepted and has no effect.

## Fields

A model needs a `fromJson` factory, constructor or static method, or a `@MappableClass` annotation. The schema follows the constructor the serializer uses: the one named in `@JsonSerializable(constructor: ...)`, the `@MappableConstructor`, the unnamed constructor, or else the first public constructor with parameters.

- A non-nullable field without a default is `.required()`. A nullable field, or one with a constructor default, a `freezed` `@Default` or a `@JsonKey(defaultValue: ...)`, is optional.
- A field with `@JsonKey(includeFromJson: false)` is left out.
- Keys follow the serializer: `@JsonKey(name: ...)` and `@JsonSerializable(fieldRename: ...)`, or `@MappableField(key: ...)` and `@MappableClass(caseStyle: ...)`. Global options in another builder's `build.yaml`, such as `json_serializable`'s `field_rename`, are not read: put them on the class.
- For `@JsonSerializable` classes, public settable fields outside the constructor are schema fields too, since `json_serializable` assigns them after the constructor.

| Dart type | Validator |
| --- | --- |
| `String`, `int`, `double`, `num`, `bool` | `l.string()`, `l.int()`, `l.double()`, `l.num()`, `l.bool()` |
| `DateTime` | `l.string().dateTime()` |
| `Uri` | `l.string()` |
| An enum | `l.oneOf([...])` of the serialized values, honouring `@JsonValue`, `@JsonEnum(fieldRename:, valueField:)`, `@MappableEnum` and `@MappableValue` |
| `List`, `Set`, `Iterable` | `l.list(element)` |
| `Map` | `l.map()` with key and value validators |
| `dynamic`, `Object`, `Object?` | `l.any()` |
| `File` (`dart:io`), `XFile` (`cross_file`) | `l.file()` |
| A class with `@luthor`, a `fromJson` or `@MappableClass` | its schema |

- A `json_serializable` enum field with `@JsonKey(unknownEnumValue: ...)` generates `l.string()` instead of `l.oneOf([...])`, because `json_serializable` maps an unknown value to the fallback instead of throwing. On a list of an enum, each element gets `l.string()`. An enum with integer serialized values gets `l.int()`. `.required()` follows the usual rules.
- A `double` field rejects JSON integers such as `1`. Type the field as `num` when the backend may send whole numbers.
- `Map` keys of type `int`, `double`, `num` and `BigInt` are validated as strings that parse to that type, since JSON object keys are strings. `String`, `DateTime`, `Uri` and enum keys work too.
- A field with a `JsonConverter` or a `@JsonKey(fromJson: ...)` function is validated as `l.any()`, and only `@WithCustomValidator` and `@WithSchemaCustomValidator` apply to it. Give a type luthor can't validate, such as `Duration`, a converter.

### Unknown keys

A generated schema strips unknown keys before `fromJson` runs, so `fromJson` sees only the schema's fields. A hand-written `fromJson` must read only the keys of its constructor parameters, or a key it reads arrives as `null`.

The generator switches to `.passthrough()` when the serializer may read keys it can't name: a `@JsonKey(readValue: ...)` field (validated as an optional `l.any()`), a private field with `@JsonKey(includeFromJson: true)`, or a `@MappableClass(hook: ...)`.

## Annotations

Put validation annotations on the constructor parameter or on the field. They apply in the order they are written, so `@HasMin(8) @HasMax(200)` generates `.min(8).max(200)`. Custom validator annotations always come after the others.

| Annotation | Generates | Field types |
| --- | --- | --- |
| `@isEmail`, `@IsEmail(...)` | `.email()` | `String` |
| `@isDateTime` | `.dateTime()` (automatic on `DateTime` fields) | `String` |
| `@isUri`, `@IsUri(allowedSchemes: [...])` | `.uri()` | `String` |
| `@isUrl`, `@IsUrl(allowedSchemes: [...])` | `.url()` | `String` |
| `@isUuid`, `@isCuid`, `@isCuid2`, `@isEmoji` | `.uuid()`, `.cuid()`, `.cuid2()`, `.emoji()` | `String` |
| `@isIp`, `@IsIp(version: IpVersion.v4)` | `.ip()` | `String` |
| `@HasLength(10)` | `.length(10)` | `String` |
| `@HasMin(n)`, `@HasMax(n)` | `.min(n)`, `.max(n)`: the length of a `String`, the value of a number | `String`, `int` (`n` must be an `int`), `double`, `num` |
| `@MatchRegex(r'^\d+$', caseSensitive: false)` | `.regex(RegExp(...))`, with its flags | `String` |
| `@StartsWith('x')`, `@EndsWith('x')`, `@Contains('x')` | `.startsWith()`, `.endsWith()`, `.contains()` | `String` |
| `@isFile`, `@IsFile(accept: ...)` | replaces the type with `l.file()` | any, including package classes such as `MultipartFile` |
| `@WithCustomValidator(fn)` | `.custom(fn)` | any except `Null` |
| `@WithSchemaCustomValidator(fn)` | `.customWithSchema(fn)` | any except `Null` |

Every annotation takes `message:` and `messageBuilder:`. Functions passed to annotations, including `fn`, `accept` and `messageBuilder`, must be public top-level or static functions, since annotation arguments are constants:

```dart
bool isEven(int value) => value.isEven;

bool passwordsMatch(String value, SchemaData data) =>
    value == data['password'];

String tooShort(ValidationIssue issue) =>
    'Use at least ${issue.params['min']} characters';
```

List elements take no annotations yet ([#71](https://github.com/exaby73/luthor/issues/71)): `@IsEmail` on a `List<String>` fails generation. Validate elements with `@WithCustomValidator` on the list.

## Serializers

### json_serializable

The setup above. `luthor_generator` and `json_serializable` share the `.g.dart` file.

### freezed

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@luthor
@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    @HasMin(2) required String name,
    @Default(0) int age,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
```

Put `@JsonSerializable(fieldRename: ...)` on the factory constructor. `freezed` unions (more than one redirecting factory) are not supported.

Pick the `freezed` release for the SDK. `luthor_generator` supports analyzer 10 to 14, so it resolves with either:

| SDK | `freezed` | Notes |
| --- | --- | --- |
| Dart 3.13 or later | `^4.0.0` | |
| Dart 3.11 and 3.12 (Flutter 3.41 and 3.44) | `^3.2.5` | Resolves analyzer 10. `dart_mappable_builder` 4.9.1 and later need analyzer 13, so a project using both pins `dart_mappable_builder` below 4.9.1. |

`freezed_annotation: ^3.1.0` works with both.

### dart_mappable

```bash
dart pub add luthor dart_mappable
dart pub add dev:build_runner dev:luthor_generator dev:dart_mappable_builder
```

```dart
import 'package:dart_mappable/dart_mappable.dart';
import 'package:luthor/luthor.dart';

part 'login.g.dart';
part 'login.mapper.dart';

@luthor
@MappableClass()
class Login with LoginMappable {
  const Login({@isEmail required this.email, @HasMin(8) required this.password});

  final String email;
  final String password;
}
```

`$LoginValidate` converts with `LoginMapper.fromMap`, and `validateSelf()` validates `toMap()`.

### Plain classes

A class with a hand-written `fromJson` works as a model. Add a `toJson` to get `validateSelf()`.

## Generation errors

The generator fails with an `InvalidGenerationSourceError` that names the class or field. Find the message here:

| Message starts with | Meaning and fix |
| --- | --- |
| `Luthor can only be applied to classes.` | `@luthor` is on something other than a class. Move it to the class. |
| `Luthor can only be applied to classes with a fromJson constructor or static method, or a @MappableClass annotation.` | Add a `fromJson` factory or `@MappableClass()`. |
| `` `X` is generic. `` | Generic models are not supported. Write a concrete class per type argument. |
| `` `X` is a union of ... `` | A `freezed` union. Annotate a separate class per variant, or validate the union by hand with `l.union`. |
| `` `X` names the constructor `c` in @JsonSerializable, but it has no such constructor. `` | Fix the `constructor:` name. |
| `` `X` has no public constructor that luthor can read fields from. `` | Add an unnamed public constructor, or name one with `@JsonSerializable(constructor: '...')`. |
| `@A cannot be used on field ...: it applies to ... fields` | The annotation doesn't fit the field's type, such as `@IsEmail` on an `int` or on a `List<String>`. Move it, or use `@WithCustomValidator`. |
| `@HasMin on field ... needs an int` | `@HasMin` and `@HasMax` on `int` and `String` fields take an `int`. |
| `` Luthor cannot validate field `f` of `X`: its type `T` ... `` | A record, function, type parameter, generic class, or SDK type without a validator (such as `Duration` or `BigInt`): give the field a `JsonConverter` or `@JsonKey(fromJson: ...)`. For a class of your own, annotate it with `@luthor` or give it a `fromJson`. |
| `` ...its map key type `T` is not supported. `` | Use a `String`, `int`, `double`, `num`, `BigInt`, `DateTime`, `Uri` or enum key. |
| `` The function `f` used on ... is not visible from ... `` | Make `f` a public top-level or static function, and import its library in the model's library. |
| `Luthor cannot write the annotation value ...` | Use a literal, a `const` value, an enum constant, or a top-level or static function as the annotation argument. |
| `` `E` sets JsonEnum.valueField to `v`, but that is not a field of ... `` | Fix `valueField` to name a field of the enum. |
