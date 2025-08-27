// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'without_freezed.dart';

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const WithoutFreezedSchemaKeys = (name: "name", age: "age");

Validator $WithoutFreezedSchema = l.withName('WithoutFreezed').schema({
  WithoutFreezedSchemaKeys.name: l.string().email().required(),
  WithoutFreezedSchemaKeys.age: l.int().required(),
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

// ignore: constant_identifier_names
const WithDartMappableSchemaKeys = (email: "email", password: "password");

Validator $WithDartMappableSchema = l.withName('WithDartMappable').schema({
  WithDartMappableSchemaKeys.email: l.string().email().required(),
  WithDartMappableSchemaKeys.password: l.string().min(8).required(),
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
