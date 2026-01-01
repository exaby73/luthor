// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SimpleModel _$SimpleModelFromJson(Map<String, dynamic> json) => _SimpleModel(
  name: json['name'] as String,
  age: (json['age'] as num).toInt(),
  isActive: json['isActive'] as bool,
  score: (json['score'] as num).toDouble(),
  optionalField: json['optionalField'] as String?,
);

Map<String, dynamic> _$SimpleModelToJson(_SimpleModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'isActive': instance.isActive,
      'score': instance.score,
      'optionalField': instance.optionalField,
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const SimpleModelSchemaKeys = (
  name: "name",
  age: "age",
  isActive: "isActive",
  score: "score",
  optionalField: "optionalField",
);

Validator $SimpleModelSchema = l.withName('SimpleModel').schema({
  SimpleModelSchemaKeys.name: l.string().required(),
  SimpleModelSchemaKeys.age: l.int().required(),
  SimpleModelSchemaKeys.isActive: l.boolean().required(),
  SimpleModelSchemaKeys.score: l.double().required(),
  SimpleModelSchemaKeys.optionalField: l.string(),
});

SchemaValidationResult<SimpleModel> $SimpleModelValidate(
  Map<String, dynamic> json,
) => $SimpleModelSchema.validateSchema(json, fromJson: SimpleModel.fromJson);

extension SimpleModelValidationExtension on SimpleModel {
  SchemaValidationResult<SimpleModel> validateSelf() =>
      $SimpleModelValidate(toJson());
}

// ignore: constant_identifier_names
const SimpleModelErrorKeys = (
  name: "name",
  age: "age",
  isActive: "isActive",
  score: "score",
  optionalField: "optionalField",
);
