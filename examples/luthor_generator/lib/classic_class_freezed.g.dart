// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classic_class_freezed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassicClassFreezed _$ClassicClassFreezedFromJson(Map<String, dynamic> json) =>
    ClassicClassFreezed(
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$ClassicClassFreezedToJson(
  ClassicClassFreezed instance,
) => <String, dynamic>{'name': instance.name, 'age': instance.age};

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const ClassicClassFreezedSchemaKeys = (name: "name", age: "age");

final SchemaValidator $ClassicClassFreezedSchema = l
    .schema({
      ClassicClassFreezedSchemaKeys.name: l.string().min(3).required(),
      ClassicClassFreezedSchemaKeys.age: l.int().required(),
    })
    .withName("ClassicClassFreezed");

ValidationResult<ClassicClassFreezed> $ClassicClassFreezedValidate(
  Object? json,
) => $ClassicClassFreezedSchema.validateSchema(
  json,
  fromJson: ClassicClassFreezed.fromJson,
);

extension ClassicClassFreezedValidationExtension on ClassicClassFreezed {
  ValidationResult<ClassicClassFreezed> validateSelf() =>
      $ClassicClassFreezedValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const ClassicClassFreezedErrorKeys = (name: "name", age: "age");

Map<String, Object?> _$luthorJsonMap(Map<Object?, Object?> map) => {
  for (final entry in map.entries)
    entry.key.toString(): _$luthorJsonValue(entry.value),
};

Object? _$luthorJsonValue(Object? value) {
  if (value == null || value is String || value is num || value is bool) {
    return value;
  }
  if (value is Map) return _$luthorJsonMap(value);
  if (value is Iterable) {
    return [for (final item in value) _$luthorJsonValue(item)];
  }
  try {
    // ignore: avoid_dynamic_calls
    return _$luthorJsonValue((value as dynamic).toJson());
    // ignore: avoid_catching_errors
  } on NoSuchMethodError {
    return value;
  }
}
