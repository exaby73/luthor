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

final SchemaValidator $NodeSchema = l
    .schema({
      NodeSchemaKeys.value: l.string().required(),
      NodeSchemaKeys.children: l.list(forwardRef(() => $NodeSchema.required())),
    })
    .withName("Node");

ValidationResult<Node> $NodeValidate(Object? json) =>
    $NodeSchema.validateSchema(json, fromJson: Node.fromJson);

extension NodeValidationExtension on Node {
  ValidationResult<Node> validateSelf() =>
      $NodeValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const NodeErrorKeys = (value: "value", children: "children");

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
