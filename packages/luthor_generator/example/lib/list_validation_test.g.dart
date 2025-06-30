// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_validation_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListValidationTest _$ListValidationTestFromJson(Map<String, dynamic> json) =>
    _ListValidationTest(
      nullableStrings: (json['nullableStrings'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      nullableInts: (json['nullableInts'] as List<dynamic>)
          .map((e) => (e as num?)?.toInt())
          .toList(),
      customObjects: (json['customObjects'] as List<dynamic>)
          .map((e) => AnotherSample.fromJson(e as Map<String, dynamic>))
          .toList(),
      nullableCustomObjects: (json['nullableCustomObjects'] as List<dynamic>)
          .map(
            (e) => e == null
                ? null
                : AnotherSample.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      optionalNullableStrings:
          (json['optionalNullableStrings'] as List<dynamic>?)
              ?.map((e) => e as String?)
              .toList(),
    );

Map<String, dynamic> _$ListValidationTestToJson(_ListValidationTest instance) =>
    <String, dynamic>{
      'nullableStrings': instance.nullableStrings,
      'nullableInts': instance.nullableInts,
      'customObjects': instance.customObjects,
      'nullableCustomObjects': instance.nullableCustomObjects,
      'optionalNullableStrings': instance.optionalNullableStrings,
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

Validator $ListValidationTestSchema = l.withName('ListValidationTest').schema({
  'nullableStrings': l.list(validators: [l.string()]).required(),
  'nullableInts': l.list(validators: [l.int()]).required(),
  'customObjects': l
      .list(validators: [$AnotherSampleSchema.required()])
      .required(),
  'nullableCustomObjects': l
      .list(validators: [$AnotherSampleSchema])
      .required(),
  'optionalNullableStrings': l.list(validators: [l.string()]),
});

SchemaValidationResult<ListValidationTest> $ListValidationTestValidate(
  Map<String, dynamic> json,
) => $ListValidationTestSchema.validateSchema(
  json,
  fromJson: ListValidationTest.fromJson,
);

extension ListValidationTestValidationExtension on ListValidationTest {
  SchemaValidationResult<ListValidationTest> validateSelf() =>
      $ListValidationTestValidate(toJson());
}
