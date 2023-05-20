// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Sample _$$_SampleFromJson(Map<String, dynamic> json) => _$_Sample(
      anyValue: json['anyValue'],
      boolValue: json['boolValue'] as bool,
      doubleValue: (json['doubleValue'] as num).toDouble(),
      intValue: json['intValue'] as int,
      listValue:
          (json['listValue'] as List<dynamic>).map((e) => e as String).toList(),
      numValue: json['numValue'] as num,
      stringValue: json['stringValue'] as String,
      email: json['email'] as String,
      date: json['date'] as String,
      exactly10Characters: json['exactly10Characters'] as String?,
      minAndMax: json['minAndMax'] as String,
      httpsLink: json['httpsLink'] as String?,
      luthorPath: json['luthorPath'] as String,
      anotherSample:
          AnotherSample.fromJson(json['anotherSample'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SampleToJson(_$_Sample instance) => <String, dynamic>{
      'anyValue': instance.anyValue,
      'boolValue': instance.boolValue,
      'doubleValue': instance.doubleValue,
      'intValue': instance.intValue,
      'listValue': instance.listValue,
      'numValue': instance.numValue,
      'stringValue': instance.stringValue,
      'email': instance.email,
      'date': instance.date,
      'exactly10Characters': instance.exactly10Characters,
      'minAndMax': instance.minAndMax,
      'httpsLink': instance.httpsLink,
      'luthorPath': instance.luthorPath,
      'anotherSample': instance.anotherSample,
    };

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
