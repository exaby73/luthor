// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// LuthorGenerator
// **************************************************************************

Validator $SampleSchema = l.schema({
  'anyValue': l.any(),
  'boolValue': l.bool().required(),
  'doubleValue': l.double().required(),
  'intValue': l.int().required(),
  'listValue': l.list(validators: [l.string()]).required(),
  'numValue': l.number().required(),
  'stringValue': l.string().required(),
  'email': l.string().email().required(),
  'date': l.string().dateTime().required(),
  'exactly10Characters': l.string().length(10),
  'minAndMax': l.string().max(200).min(8).required(),
  'httpsLink': l.string().uri(allowedSchemes: ['https']),
  'luthorPath':
      l.string().regex(r"^https:\/\/pub\.dev\/packages\/luthor").required(),
  'anotherSample': $AnotherSampleSchema.required(),
});

SchemaValidationResult<Sample> _$validate(Map<String, dynamic> json) =>
    $SampleSchema.validateSchema(json, fromJson: Sample.fromJson);
