// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'without_freezed.dart';

// **************************************************************************
// LuthorGenerator
// **************************************************************************

Validator $WithoutFreezedSchema = l.schema({
  'name': l.string().email().required(),
  'age': l.int().required(),
});

SchemaValidationResult<WithoutFreezed> $WithoutFreezedValidate(
        Map<String, dynamic> json) =>
    $WithoutFreezedSchema.validateSchema(json,
        fromJson: WithoutFreezed.fromJson);

extension WithoutFreezedValidationExtension on WithoutFreezed {
  SchemaValidationResult<WithoutFreezed> validateSelf() =>
      $WithoutFreezedValidate(toJson());
}
