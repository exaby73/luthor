// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// LuthorGenerator
// **************************************************************************

Validator _$SampleSchema = l.schema({
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
  'anotherSample': AnotherSample.schema.required(),
});
