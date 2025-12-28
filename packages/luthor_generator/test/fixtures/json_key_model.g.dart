// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_key_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JsonKeyModel _$JsonKeyModelFromJson(Map<String, dynamic> json) =>
    _JsonKeyModel(
      userName: json['user_name'] as String,
      userEmail: json['user_email'] as String,
      normalField: json['normalField'] as String,
    );

Map<String, dynamic> _$JsonKeyModelToJson(_JsonKeyModel instance) =>
    <String, dynamic>{
      'user_name': instance.userName,
      'user_email': instance.userEmail,
      'normalField': instance.normalField,
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const JsonKeyModelSchemaKeys = (
  userName: "user_name",
  userEmail: "user_email",
  normalField: "normalField",
);

Validator $JsonKeyModelSchema = l.withName('JsonKeyModel').schema({
  JsonKeyModelSchemaKeys.userName: l.string().required(),
  JsonKeyModelSchemaKeys.userEmail: l.string().email().required(),
  JsonKeyModelSchemaKeys.normalField: l.string().required(),
});

SchemaValidationResult<JsonKeyModel> $JsonKeyModelValidate(
  Map<String, dynamic> json,
) => $JsonKeyModelSchema.validateSchema(json, fromJson: JsonKeyModel.fromJson);

extension JsonKeyModelValidationExtension on JsonKeyModel {
  SchemaValidationResult<JsonKeyModel> validateSelf() =>
      $JsonKeyModelValidate(toJson());
}

// ignore: constant_identifier_names
const JsonKeyModelErrorKeys = (
  userName: "user_name",
  userEmail: "user_email",
  normalField: "normalField",
);
