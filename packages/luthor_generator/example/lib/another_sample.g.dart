// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'another_sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnotherSampleImpl _$$AnotherSampleImplFromJson(Map<String, dynamic> json) =>
    _$AnotherSampleImpl(
      id: (json['id'] as num).toInt(),
      name: json['full_name'] as String?,
      email: json['email'] as String,
      ip: json['ip'] as String?,
      password: json['password'] as String,
      type: json['type'] as String? ?? 'user',
    );

Map<String, dynamic> _$$AnotherSampleImplToJson(_$AnotherSampleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.name,
      'email': instance.email,
      'ip': instance.ip,
      'password': instance.password,
      'type': instance.type,
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

Validator $AnotherSampleSchema = l.schema({
  'id': l.int().required(),
  'full_name': l.string(),
  'email': l.string().email(message: 'Invalid email').required(),
  'ip': l.string().ip(version: IpVersion.v4),
  'password': l.string().min(8).required(),
  'type': l.string(),
});

SchemaValidationResult<AnotherSample> $AnotherSampleValidate(
        Map<String, dynamic> json) =>
    $AnotherSampleSchema.validateSchema(json, fromJson: AnotherSample.fromJson);

extension AnotherSampleValidationExtension on AnotherSample {
  SchemaValidationResult<AnotherSample> validateSelf() =>
      $AnotherSampleValidate(toJson());
}
