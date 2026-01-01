// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListModel _$ListModelFromJson(Map<String, dynamic> json) => _ListModel(
  stringList: (json['stringList'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  intList: (json['intList'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  optionalList: (json['optionalList'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ListModelToJson(_ListModel instance) =>
    <String, dynamic>{
      'stringList': instance.stringList,
      'intList': instance.intList,
      'optionalList': instance.optionalList,
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const ListModelSchemaKeys = (
  stringList: "stringList",
  intList: "intList",
  optionalList: "optionalList",
);

Validator $ListModelSchema = l.withName('ListModel').schema({
  ListModelSchemaKeys.stringList: l
      .list(validators: [l.string().required()])
      .required(),
  ListModelSchemaKeys.intList: l
      .list(validators: [l.int().required()])
      .required(),
  ListModelSchemaKeys.optionalList: l.list(validators: [l.string().required()]),
});

SchemaValidationResult<ListModel> $ListModelValidate(
  Map<String, dynamic> json,
) => $ListModelSchema.validateSchema(json, fromJson: ListModel.fromJson);

extension ListModelValidationExtension on ListModel {
  SchemaValidationResult<ListModel> validateSelf() =>
      $ListModelValidate(toJson());
}

// ignore: constant_identifier_names
const ListModelErrorKeys = (
  stringList: "stringList",
  intList: "intList",
  optionalList: "optionalList",
);
