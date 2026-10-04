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

final SchemaValidator $ListValidationTestSchema = l
    .schema({
      ListValidationTestSchemaKeys.nullableStrings: l
          .list(l.string())
          .required(),
      ListValidationTestSchemaKeys.nullableInts: l.list(l.int()).required(),
      ListValidationTestSchemaKeys.customObjects: l
          .list(forwardRef(() => $AnotherSampleSchema.required()))
          .required(),
      ListValidationTestSchemaKeys.nullableCustomObjects: l
          .list(forwardRef(() => $AnotherSampleSchema))
          .required(),
      ListValidationTestSchemaKeys.optionalNullableStrings: l.list(l.string()),
    })
    .withName("ListValidationTest");

ValidationResult<ListValidationTest> $ListValidationTestValidate(
  Object? json,
) => $ListValidationTestSchema.validateSchema(
  json,
  fromJson: ListValidationTest.fromJson,
);

extension ListValidationTestValidationExtension on ListValidationTest {
  ValidationResult<ListValidationTest> validateSelf() =>
      $ListValidationTestValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const ListValidationTestErrorKeys = (
  nullableStrings: "nullableStrings",
  nullableInts: "nullableInts",
  customObjects: "customObjects",
  nullableCustomObjects: "nullableCustomObjects",
  optionalNullableStrings: "optionalNullableStrings",
);

Map<String, Object?> _$luthorJsonMap(Map<Object?, Object?> map) => {
  for (final entry in map.entries)
    entry.key.toString(): _$luthorJsonValue(entry.value),
};

Object? _$luthorJsonValue(Object? value) {
  if (value == null || value is String || value is num || value is bool) {
    return value;
  }
  if (value is Map) return _$luthorJsonMap(value);
  if (value is Iterable) {
    return [for (final item in value) _$luthorJsonValue(item)];
  }
  try {
    // ignore: avoid_dynamic_calls
    return _$luthorJsonValue((value as dynamic).toJson());
    // ignore: avoid_catching_errors
  } on NoSuchMethodError {
    return value;
  }
}
