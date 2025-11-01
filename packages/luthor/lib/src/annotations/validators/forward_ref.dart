/// Annotation to mark a field as using a forward reference.
/// When used with @luthor_generator, this tells the code generator
/// to wrap the schema reference with `forwardRef()` to handle
/// self-referential or circular schema dependencies.
///
/// Example:
/// ```dart
/// @luthor
/// class Node {
///   final String value;
///   @luthorForwardRef()
///   final List<Node>? children;
///
///   Node({required this.value, this.children});
///
///   factory Node.fromJson(Map<String, dynamic> json) => Node(
///     value: json['value'] as String,
///     children: (json['children'] as List<dynamic>?)
///         ?.map((e) => Node.fromJson(e as Map<String, dynamic>))
///         .toList(),
///   );
/// }
/// ```
class LuthorForwardRef {
  const LuthorForwardRef();
}

const luthorForwardRef = LuthorForwardRef();
