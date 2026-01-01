// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_validator_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomValidatorModel _$CustomValidatorModelFromJson(
  Map<String, dynamic> json,
) => _CustomValidatorModel(
  customField: json['customField'] as String,
  matchField: json['matchField'] as String,
  confirmField: json['confirmField'] as String,
);

Map<String, dynamic> _$CustomValidatorModelToJson(
  _CustomValidatorModel instance,
) => <String, dynamic>{
  'customField': instance.customField,
  'matchField': instance.matchField,
  'confirmField': instance.confirmField,
};

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const CustomValidatorModelSchemaKeys = (
  customField: "customField",
  matchField: "matchField",
  confirmField: "confirmField",
);

Validator $CustomValidatorModelSchema = l
    .withName('CustomValidatorModel')
    .schema({
      CustomValidatorModelSchemaKeys.customField: l
          .string()
          .custom(customValidatorFn, messageFn: customErrorMessage)
          .required(),
      CustomValidatorModelSchemaKeys.matchField: l.string().required(),
      CustomValidatorModelSchemaKeys.confirmField: l
          .string()
          .customWithSchema(schemaValidatorFn, message: 'Fields must match')
          .required(),
    });

SchemaValidationResult<CustomValidatorModel> $CustomValidatorModelValidate(
  Map<String, dynamic> json,
) => $CustomValidatorModelSchema.validateSchema(
  json,
  fromJson: CustomValidatorModel.fromJson,
);

extension CustomValidatorModelValidationExtension on CustomValidatorModel {
  SchemaValidationResult<CustomValidatorModel> validateSelf() =>
      $CustomValidatorModelValidate(toJson());
}

// ignore: constant_identifier_names
const CustomValidatorModelErrorKeys = (
  customField: "customField",
  matchField: "matchField",
  confirmField: "confirmField",
);
