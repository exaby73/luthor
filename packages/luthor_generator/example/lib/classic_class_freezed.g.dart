// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classic_class_freezed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassicClassFreezed _$ClassicClassFreezedFromJson(Map<String, dynamic> json) =>
    ClassicClassFreezed(
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$ClassicClassFreezedToJson(
  ClassicClassFreezed instance,
) => <String, dynamic>{'name': instance.name, 'age': instance.age};

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const ClassicClassFreezedSchemaKeys = (name: "name", age: "age");

Validator $ClassicClassFreezedSchema = l
    .withName('ClassicClassFreezed')
    .schema({
      ClassicClassFreezedSchemaKeys.name: l.string().min(3).required(),
      ClassicClassFreezedSchemaKeys.age: l.int().required(),
    });

SchemaValidationResult<ClassicClassFreezed> $ClassicClassFreezedValidate(
  Map<String, dynamic> json,
) => $ClassicClassFreezedSchema.validateSchema(
  json,
  fromJson: ClassicClassFreezed.fromJson,
);

extension ClassicClassFreezedValidationExtension on ClassicClassFreezed {
  SchemaValidationResult<ClassicClassFreezed> validateSelf() =>
      $ClassicClassFreezedValidate(toJson());
}

// ignore: constant_identifier_names
const ClassicClassFreezedErrorKeys = (name: "name", age: "age");
