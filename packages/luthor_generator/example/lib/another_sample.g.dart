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
      password: json['password'] as String,
    );

Map<String, dynamic> _$$AnotherSampleImplToJson(_$AnotherSampleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.name,
      'email': instance.email,
      'password': instance.password,
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

Validator $AnotherSampleSchema = l.schema({
  'id': l.int().required(),
  'full_name': l.string(),
  'email': l.string().email(message: 'Invalid email').required(),
  'password': l.string().min(8).required(),
});

SchemaValidationResult<AnotherSample> $AnotherSampleValidate(
        Map<String, dynamic> json) =>
    $AnotherSampleSchema.validateSchema(json, fromJson: AnotherSample.fromJson);

extension AnotherSampleValidationExtension on AnotherSample {
  SchemaValidationResult<AnotherSample> validateSelf() =>
      $AnotherSampleValidate(toJson());
}
