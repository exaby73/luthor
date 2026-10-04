part of '../validator.dart';

/// The data of the schema that contains a field, passed to a
/// [SchemaCustomValidator].
///
/// It is a read-only view of the sibling fields as they appear in the input,
/// with keys converted to strings. [root] holds the data of the outermost
/// schema, so a field inside a nested schema or a list can reach any field.
final class SchemaData extends UnmodifiableMapView<String, Object?> {
  SchemaData._(super.map, {required this.root});

  static final _empty = SchemaData._(const {}, root: const {});

  /// The data of the outermost schema being validated.
  final Map<String, Object?> root;
}

final class _Context {
  const _Context._({
    required this.path,
    required this.fieldName,
    required this.schema,
    required this.depth,
    required this.maxDepth,
    required this.messageBuilder,
  });

  factory _Context.root(String? fieldName) {
    return _Context._(
      path: const [],
      fieldName: fieldName,
      schema: null,
      depth: 0,
      maxDepth: l.maxDepth,
      messageBuilder: l.messageBuilder,
    );
  }

  final List<Object> path;
  final String? fieldName;
  final SchemaData? schema;
  final int depth;
  final int maxDepth;
  final MessageBuilder? messageBuilder;

  _Context child(Object segment, {String? fieldName, SchemaData? schema}) {
    return _Context._(
      path: List.unmodifiable([...path, segment]),
      fieldName: fieldName ?? this.fieldName,
      schema: schema ?? this.schema,
      depth: depth + 1,
      maxDepth: maxDepth,
      messageBuilder: messageBuilder,
    );
  }

  _Context nested({String? fieldName}) {
    return _Context._(
      path: path,
      fieldName: fieldName ?? this.fieldName,
      schema: schema,
      depth: depth + 1,
      maxDepth: maxDepth,
      messageBuilder: messageBuilder,
    );
  }

  ValidationIssue issue(
    IssueCode code,
    String Function(String field) describe, {
    Map<String, Object?> params = const {},
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    final issue = ValidationIssue(
      code: code,
      message: describe(fieldName ?? 'value'),
      path: path,
      params: params,
      fieldName: fieldName,
    );
    if (message != null) return issue.withMessage(message);
    final builder = messageBuilder ?? this.messageBuilder;
    return builder == null ? issue : issue.withMessage(builder(issue));
  }

  ValidationIssue tooDeep() {
    return issue(
      IssueCode.tooDeep,
      (field) => '$field is nested deeper than $maxDepth levels',
      params: {'maxDepth': maxDepth},
    );
  }
}
