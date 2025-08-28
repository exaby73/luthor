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
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const AnotherSampleSchemaKeys = (
  id: "id",
  name: "full_name",
  email: "email",
  ip: "ip",
  password: "password",
  type: "type",
  url: "url",
);

Validator $AnotherSampleSchema = l.withName('AnotherSample').schema({
  AnotherSampleSchemaKeys.id: l.int().required(),
  AnotherSampleSchemaKeys.name: l.string(),
  AnotherSampleSchemaKeys.email: l
      .string()
      .email(message: 'Invalid email')
      .required(),
  AnotherSampleSchemaKeys.ip: l.string().ip(version: IpVersion.v4),
  AnotherSampleSchemaKeys.password: l.string().min(8).required(),
  AnotherSampleSchemaKeys.type: l.string(),
  AnotherSampleSchemaKeys.url: l.string().url(
    allowedSchemes: ['http', 'https'],
  ),
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
);
