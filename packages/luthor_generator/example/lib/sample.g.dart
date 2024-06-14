// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SampleImpl _$$SampleImplFromJson(Map<String, dynamic> json) => _$SampleImpl(
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
      dateTime: DateTime.parse(json['dateTime'] as String),
      exactly10Characters: json['exactly10Characters'] as String?,
      minAndMaxString: json['minAndMaxString'] as String,
      startsWithFoo: json['startsWithFoo'] as String,
      endsWithBar: json['endsWithBar'] as String,
      containsBaz: json['containsBaz'] as String,
      minAndMaxInt: json['minAndMaxInt'] as int,
      minAndMaxDouble: (json['minAndMaxDouble'] as num).toDouble(),
      minAndMaxNumber: json['minAndMaxNumber'] as num,
      httpsLink: json['httpsLink'] as String?,
      luthorPath: json['luthorPath'] as String,
      anotherSample:
          AnotherSample.fromJson(json['anotherSample'] as Map<String, dynamic>),
      foo: json['jsonKeyName'] as String,
      custom: json['custom'] as String,
      numbers: (json['numbers'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$SampleImplToJson(_$SampleImpl instance) =>
    <String, dynamic>{
      'anyValue': instance.anyValue,
      'boolValue': instance.boolValue,
      'doubleValue': instance.doubleValue,
      'intValue': instance.intValue,
      'listValue': instance.listValue,
      'numValue': instance.numValue,
      'stringValue': instance.stringValue,
      'email': instance.email,
      'date': instance.date,
      'dateTime': instance.dateTime.toIso8601String(),
      'exactly10Characters': instance.exactly10Characters,
      'minAndMaxString': instance.minAndMaxString,
      'startsWithFoo': instance.startsWithFoo,
      'endsWithBar': instance.endsWithBar,
      'containsBaz': instance.containsBaz,
      'minAndMaxInt': instance.minAndMaxInt,
      'minAndMaxDouble': instance.minAndMaxDouble,
      'minAndMaxNumber': instance.minAndMaxNumber,
      'httpsLink': instance.httpsLink,
      'luthorPath': instance.luthorPath,
      'anotherSample': instance.anotherSample,
      'jsonKeyName': instance.foo,
      'custom': instance.custom,
      'numbers': instance.numbers,
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
  'dateTime': l.string().dateTime().required(),
  'exactly10Characters': l.string().length(10),
  'minAndMaxString': l.string().max(200).min(8).required(),
  'startsWithFoo': l.string().startsWith(r"foo").required(),
  'endsWithBar': l.string().endsWith(r"bar").required(),
  'containsBaz': l.string().contains(r"baz").required(),
  'minAndMaxInt': l.int().max(4).min(2).required(),
  'minAndMaxDouble': l.double().max(4.0).min(2.0).required(),
  'minAndMaxNumber': l.number().max(3.0).min(2).required(),
  'httpsLink': l.string().uri(allowedSchemes: ['https']),
  'luthorPath':
      l.string().regex(r"^https:\/\/pub\.dev\/packages\/luthor").required(),
  'anotherSample': $AnotherSampleSchema.required(),
  'jsonKeyName': l.string().required(),
  'custom': l.string().custom(customValidatorFn).required(),
  'numbers': l.list(validators: [l.int()]).required(),
});

SchemaValidationResult<Sample> _$SampleValidate(Map<String, dynamic> json) =>
    $SampleSchema.validateSchema(json, fromJson: Sample.fromJson);

extension SampleValidationExtension on Sample {
  SchemaValidationResult<Sample> validateSelf() => _$SampleValidate(toJson());
}
