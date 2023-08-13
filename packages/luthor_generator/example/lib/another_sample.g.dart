// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'another_sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnotherSample _$$_AnotherSampleFromJson(Map<String, dynamic> json) =>
    _$_AnotherSample(
      id: json['id'] as int,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$_AnotherSampleToJson(_$_AnotherSample instance) =>
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
