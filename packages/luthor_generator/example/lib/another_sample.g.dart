// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'another_sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnotherSample _$AnotherSampleFromJson(Map<String, dynamic> json) =>
    _AnotherSample(
      id: (json['id'] as num).toInt(),
      name: json['full_name'] as String?,
      email: json['email'] as String,
      ip: json['ip'] as String?,
      password: json['password'] as String,
      type: json['type'] as String? ?? 'user',
      url: json['url'] as String?,
      sample: Sample.fromJson(json['sample'] as Map<String, dynamic>),
      optionalSample: json['optionalSample'] == null
          ? null
          : Sample.fromJson(json['optionalSample'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnotherSampleToJson(_AnotherSample instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.name,
      'email': instance.email,
      'ip': instance.ip,
      'password': instance.password,
      'type': instance.type,
      'url': instance.url,
      'sample': instance.sample,
      'optionalSample': instance.optionalSample,
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

Validator $AnotherSampleSchema = l.withName('AnotherSample').schema({
  'id': l.int().required(),
  'full_name': l.string(),
  'email': l.string().email(message: 'Invalid email').required(),
  'ip': l.string().ip(version: IpVersion.v4),
  'password': l.string().min(8).required(),
  'type': l.string(),
  'url': l.string().url(allowedSchemes: ['http', 'https']),
  'sample': $SampleSchema.required(),
  'optionalSample': $SampleSchema,
});

SchemaValidationResult<AnotherSample> $AnotherSampleValidate(
  Map<String, dynamic> json,
) =>
    $AnotherSampleSchema.validateSchema(json, fromJson: AnotherSample.fromJson);

extension AnotherSampleValidationExtension on AnotherSample {
  SchemaValidationResult<AnotherSample> validateSelf() =>
      $AnotherSampleValidate(toJson());
}

// ignore: constant_identifier_names
const AnotherSampleErrorKeys = (
  id: "id",
  name: "full_name",
  email: "email",
  ip: "ip",
  password: "password",
  type: "type",
  url: "url",
  sample: (
    anyValue: "sample.anyValue",
    boolValue: "sample.boolValue",
    doubleValue: "sample.doubleValue",
    intValue: "sample.intValue",
    listValue: "sample.listValue",
    numValue: "sample.numValue",
    stringValue: "sample.stringValue",
    email: "sample.email",
    date: "sample.date",
    dateTime: "sample.dateTime",
    exactly10Characters: "sample.exactly10Characters",
    minAndMaxString: "sample.minAndMaxString",
    startsWithFoo: "sample.startsWithFoo",
    endsWithBar: "sample.endsWithBar",
    containsBaz: "sample.containsBaz",
    minAndMaxInt: "sample.minAndMaxInt",
    minAndMaxDouble: "sample.minAndMaxDouble",
    minAndMaxNumber: "sample.minAndMaxNumber",
    httpsLink: "sample.httpsLink",
    aUrl: "sample.aUrl",
    luthorPath: "sample.luthorPath",
    anotherSample: (
      id: "sample.anotherSample.id",
      name: "sample.anotherSample.full_name",
      email: "sample.anotherSample.email",
      ip: "sample.anotherSample.ip",
      password: "sample.anotherSample.password",
      type: "sample.anotherSample.type",
      url: "sample.anotherSample.url",
      sample: "sample.anotherSample.sample",
      optionalSample: "sample.anotherSample.optionalSample",
    ),
    foo: "sample.jsonKeyName",
    custom: "sample.custom",
    numbers: "sample.numbers",
    hello: "sample.hello",
  ),
  optionalSample: (
    anyValue: "optionalSample.anyValue",
    boolValue: "optionalSample.boolValue",
    doubleValue: "optionalSample.doubleValue",
    intValue: "optionalSample.intValue",
    listValue: "optionalSample.listValue",
    numValue: "optionalSample.numValue",
    stringValue: "optionalSample.stringValue",
    email: "optionalSample.email",
    date: "optionalSample.date",
    dateTime: "optionalSample.dateTime",
    exactly10Characters: "optionalSample.exactly10Characters",
    minAndMaxString: "optionalSample.minAndMaxString",
    startsWithFoo: "optionalSample.startsWithFoo",
    endsWithBar: "optionalSample.endsWithBar",
    containsBaz: "optionalSample.containsBaz",
    minAndMaxInt: "optionalSample.minAndMaxInt",
    minAndMaxDouble: "optionalSample.minAndMaxDouble",
    minAndMaxNumber: "optionalSample.minAndMaxNumber",
    httpsLink: "optionalSample.httpsLink",
    aUrl: "optionalSample.aUrl",
    luthorPath: "optionalSample.luthorPath",
    anotherSample: (
      id: "optionalSample.anotherSample.id",
      name: "optionalSample.anotherSample.full_name",
      email: "optionalSample.anotherSample.email",
      ip: "optionalSample.anotherSample.ip",
      password: "optionalSample.anotherSample.password",
      type: "optionalSample.anotherSample.type",
      url: "optionalSample.anotherSample.url",
      sample: "optionalSample.anotherSample.sample",
      optionalSample: "optionalSample.anotherSample.optionalSample",
    ),
    foo: "optionalSample.jsonKeyName",
    custom: "optionalSample.custom",
    numbers: "optionalSample.numbers",
    hello: "optionalSample.hello",
  ),
);
