// ignore: constant_identifier_names
const NodeSchemaKeys = (value: "value", children: "children", parent: "parent");

final SchemaValidator $NodeSchema = l
    .schema({
      NodeSchemaKeys.value: l.string().required(),
      NodeSchemaKeys.children: l.list(forwardRef(() => $NodeSchema.required())),
      NodeSchemaKeys.parent: forwardRef(() => $NodeSchema),
    })
    .withName("Node");

ValidationResult<Node> $NodeValidate(Object? json) =>
    $NodeSchema.validateSchema(json, fromJson: Node.fromJson);

extension NodeValidationExtension on Node {
  ValidationResult<Node> validateSelf() =>
      $NodeValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const NodeErrorKeys = (value: "value", children: "children", parent: "parent");
