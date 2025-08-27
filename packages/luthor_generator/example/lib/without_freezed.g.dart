// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'without_freezed.dart';

// **************************************************************************
// LuthorGenerator
// **************************************************************************

Validator $WithoutFreezedSchema = l.withName('WithoutFreezed').schema({
  'name': l.string().email().required(),
  'age': l.int().required(),
});

SchemaValidationResult<WithoutFreezed> $WithoutFreezedValidate(
  Map<String, dynamic> json,
) => $WithoutFreezedSchema.validateSchema(
  json,
  fromJson: WithoutFreezed.fromJson,
);

extension WithoutFreezedValidationExtension on WithoutFreezed {
  SchemaValidationResult<WithoutFreezed> validateSelf() =>
      $WithoutFreezedValidate(toJson());
}

// ignore: constant_identifier_names
const WithoutFreezedErrorKeys = (name: "name", age: "age");

Validator $WithDartMappableSchema = l.withName('WithDartMappable').schema({
  'email': l.string().email().required(),
  'password': l.string().min(8).required(),
});

SchemaValidationResult<WithDartMappable> $WithDartMappableValidate(
  Map<String, dynamic> json,
) => $WithDartMappableSchema.validateSchema(
  json,
  fromJson: WithDartMappableMapper.fromMap,
);

extension WithDartMappableValidationExtension on WithDartMappable {
  SchemaValidationResult<WithDartMappable> validateSelf() =>
      $WithDartMappableValidate(toMap());
}

// ignore: constant_identifier_names
const WithDartMappableErrorKeys = (email: "email", password: "password");
