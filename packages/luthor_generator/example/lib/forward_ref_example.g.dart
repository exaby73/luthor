// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forward_ref_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Node _$NodeFromJson(Map<String, dynamic> json) => _Node(
  value: json['value'] as String,
  children: (json['children'] as List<dynamic>?)
      ?.map((e) => Node.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NodeToJson(_Node instance) => <String, dynamic>{
  'value': instance.value,
  'children': instance.children,
};

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const NodeSchemaKeys = (value: "value", children: "children");

Validator $NodeSchema = l.withName('Node').schema({
  NodeSchemaKeys.value: l.string().required(),
  NodeSchemaKeys.children: l.list(
    validators: [forwardRef(() => $NodeSchema.required())],
  ),
});

SchemaValidationResult<Node> $NodeValidate(Map<String, dynamic> json) =>
    $NodeSchema.validateSchema(json, fromJson: Node.fromJson);

extension NodeValidationExtension on Node {
  SchemaValidationResult<Node> validateSelf() => $NodeValidate(toJson());
}

// ignore: constant_identifier_names
const NodeErrorKeys = (value: "value", children: "children");
