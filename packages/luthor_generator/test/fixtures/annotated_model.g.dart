// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotated_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnnotatedModel _$AnnotatedModelFromJson(Map<String, dynamic> json) =>
    _AnnotatedModel(
      email: json['email'] as String,
      password: json['password'] as String,
      age: (json['age'] as num).toInt(),
      score: (json['score'] as num).toDouble(),
      website: json['website'] as String?,
      domain: json['domain'] as String?,
      testField: json['testField'] as String?,
      uuid: json['uuid'] as String,
    );

Map<String, dynamic> _$AnnotatedModelToJson(_AnnotatedModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'age': instance.age,
      'score': instance.score,
      'website': instance.website,
      'domain': instance.domain,
      'testField': instance.testField,
      'uuid': instance.uuid,
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const AnnotatedModelSchemaKeys = (
  email: "email",
  password: "password",
  age: "age",
  score: "score",
  website: "website",
  domain: "domain",
  testField: "testField",
  uuid: "uuid",
);

Validator $AnnotatedModelSchema = l.withName('AnnotatedModel').schema({
  AnnotatedModelSchemaKeys.email: l.string().email().required(),
  AnnotatedModelSchemaKeys.password: l.string().max(100).min(8).required(),
  AnnotatedModelSchemaKeys.age: l.int().max(120).min(18).required(),
  AnnotatedModelSchemaKeys.score: l.double().max(100.0).min(0.0).required(),
  AnnotatedModelSchemaKeys.website: l.string().startsWith("https://"),
  AnnotatedModelSchemaKeys.domain: l.string().endsWith(".com"),
  AnnotatedModelSchemaKeys.testField: l.string().contains("test"),
  AnnotatedModelSchemaKeys.uuid: l.string().uuid().required(),
});

SchemaValidationResult<AnnotatedModel> $AnnotatedModelValidate(
  Map<String, dynamic> json,
) => $AnnotatedModelSchema.validateSchema(
  json,
  fromJson: AnnotatedModel.fromJson,
);

extension AnnotatedModelValidationExtension on AnnotatedModel {
  SchemaValidationResult<AnnotatedModel> validateSelf() =>
      $AnnotatedModelValidate(toJson());
}

// ignore: constant_identifier_names
const AnnotatedModelErrorKeys = (
  email: "email",
  password: "password",
  age: "age",
  score: "score",
  website: "website",
  domain: "domain",
  testField: "testField",
  uuid: "uuid",
);
