// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'another_sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnotherSampleImpl _$$AnotherSampleImplFromJson(Map<String, dynamic> json) =>
    _$AnotherSampleImpl(
      id: json['id'] as int,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$AnotherSampleImplToJson(_$AnotherSampleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

Validator $AnotherSampleSchema = l.schema({
  'id': l.int().required(),
  'name': l.string(),
});

SchemaValidationResult<AnotherSample> _$AnotherSampleValidate(
        Map<String, dynamic> json) =>
    $AnotherSampleSchema.validateSchema(json, fromJson: AnotherSample.fromJson);

extension AnotherSampleValidationExtension on AnotherSample {
  SchemaValidationResult<AnotherSample> validateSelf() =>
      _$AnotherSampleValidate(toJson());
}
