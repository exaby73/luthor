// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nested_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NestedModel _$NestedModelFromJson(Map<String, dynamic> json) => _NestedModel(
  id: json['id'] as String,
  user: SimpleModel.fromJson(json['user'] as Map<String, dynamic>),
  optionalUser: json['optionalUser'] == null
      ? null
      : SimpleModel.fromJson(json['optionalUser'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NestedModelToJson(_NestedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'optionalUser': instance.optionalUser,
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const NestedModelSchemaKeys = (
  id: "id",
  user: "user",
  optionalUser: "optionalUser",
);

Validator $NestedModelSchema = l.withName('NestedModel').schema({
  NestedModelSchemaKeys.id: l.string().required(),
  NestedModelSchemaKeys.user: $SimpleModelSchema.required(),
  NestedModelSchemaKeys.optionalUser: $SimpleModelSchema,
});

SchemaValidationResult<NestedModel> $NestedModelValidate(
  Map<String, dynamic> json,
) => $NestedModelSchema.validateSchema(json, fromJson: NestedModel.fromJson);

extension NestedModelValidationExtension on NestedModel {
  SchemaValidationResult<NestedModel> validateSelf() =>
      $NestedModelValidate(toJson());
}

// ignore: constant_identifier_names
const NestedModelErrorKeys = (
  id: "id",
  user: (
    name: "user.name",
    age: "user.age",
    isActive: "user.isActive",
    score: "user.score",
    optionalField: "user.optionalField",
  ),
  optionalUser: (
    name: "optionalUser.name",
    age: "optionalUser.age",
    isActive: "optionalUser.isActive",
    score: "optionalUser.score",
    optionalField: "optionalUser.optionalField",
  ),
);
