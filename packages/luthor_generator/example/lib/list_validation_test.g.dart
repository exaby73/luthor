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

// ignore: constant_identifier_names
const ListValidationTestSchemaKeys = (
  nullableStrings: "nullableStrings",
  nullableInts: "nullableInts",
  customObjects: "customObjects",
  nullableCustomObjects: "nullableCustomObjects",
  optionalNullableStrings: "optionalNullableStrings",
);

Validator $ListValidationTestSchema = l.withName('ListValidationTest').schema({
  ListValidationTestSchemaKeys.nullableStrings: l
      .list(validators: [l.string()])
      .required(),
  ListValidationTestSchemaKeys.nullableInts: l
      .list(validators: [l.int()])
      .required(),
  ListValidationTestSchemaKeys.customObjects: l
      .list(validators: [$AnotherSampleSchema.required()])
      .required(),
  ListValidationTestSchemaKeys.nullableCustomObjects: l
      .list(validators: [$AnotherSampleSchema])
      .required(),
  ListValidationTestSchemaKeys.optionalNullableStrings: l.list(
    validators: [l.string()],
  ),
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

// ignore: constant_identifier_names
const ListValidationTestErrorKeys = (
  nullableStrings: "nullableStrings",
  nullableInts: "nullableInts",
  customObjects: "customObjects",
  nullableCustomObjects: "nullableCustomObjects",
  optionalNullableStrings: "optionalNullableStrings",
);
