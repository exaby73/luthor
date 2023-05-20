// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'another_sample.dart';

// **************************************************************************
// LuthorGenerator
// **************************************************************************

Validator $AnotherSampleSchema = l.schema({
  'id': l.int().required(),
  'name': l.string(),
});

SchemaValidationResult<AnotherSample> _$validate(Map<String, dynamic> json) =>
    $AnotherSampleSchema.validateSchema(json, fromJson: AnotherSample.fromJson);
