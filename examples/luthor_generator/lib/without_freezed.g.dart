// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'without_freezed.dart';

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const WithoutFreezedSchemaKeys = (name: "name", age: "age");

final SchemaValidator $WithoutFreezedSchema = l
    .schema({
      WithoutFreezedSchemaKeys.name: l.string().email().required(),
      WithoutFreezedSchemaKeys.age: l.int().required(),
    })
    .withName("WithoutFreezed");

ValidationResult<WithoutFreezed> $WithoutFreezedValidate(Object? json) =>
    $WithoutFreezedSchema.validateSchema(
      json,
      fromJson: WithoutFreezed.fromJson,
    );

extension WithoutFreezedValidationExtension on WithoutFreezed {
  ValidationResult<WithoutFreezed> validateSelf() =>
      $WithoutFreezedValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const WithoutFreezedErrorKeys = (name: "name", age: "age");

// ignore: constant_identifier_names
const WithDartMappableSchemaKeys = (email: "email", password: "password");

final SchemaValidator $WithDartMappableSchema = l
    .schema({
      WithDartMappableSchemaKeys.email: l.string().email().required(),
      WithDartMappableSchemaKeys.password: l.string().min(8).required(),
    })
    .withName("WithDartMappable");

ValidationResult<WithDartMappable> $WithDartMappableValidate(Object? json) =>
    $WithDartMappableSchema.validateSchema(
      json,
      fromJson: WithDartMappableMapper.fromMap,
    );

extension WithDartMappableValidationExtension on WithDartMappable {
  ValidationResult<WithDartMappable> validateSelf() =>
      $WithDartMappableValidate(toMap());
}

// ignore: constant_identifier_names
const WithDartMappableErrorKeys = (email: "email", password: "password");

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
