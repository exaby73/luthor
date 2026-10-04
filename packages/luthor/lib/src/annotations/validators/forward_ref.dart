/// Marks a field whose schema must be referenced with `forwardRef()`.
///
/// `luthor_generator` wraps the schema reference of the annotated field in
/// `forwardRef()`, for self-referential or circular models. The generator
/// also detects direct self-references without it.
///
/// ```dart
/// @luthor
/// class Node {
///   final String value;
///   @luthorForwardRef
///   final List<Node>? children;
///
///   Node({required this.value, this.children});
///
///   factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
/// }
/// ```
final class LuthorForwardRef {
  /// Creates the annotation.
  const LuthorForwardRef();
}

/// A [LuthorForwardRef] annotation.
const luthorForwardRef = LuthorForwardRef();
