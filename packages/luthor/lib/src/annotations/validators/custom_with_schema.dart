import 'package:luthor/src/validation_issue.dart';
import 'package:luthor/src/validator.dart';

/// Adds a schema custom validator to the annotated field.
///
/// The generator emits `.customWithSchema(customValidator)` for the annotated
/// field.
final class WithSchemaCustomValidator {
  /// Creates the annotation.
  const WithSchemaCustomValidator(
    this.customValidator, {
    this.message,
    this.messageBuilder,
  });

  /// The schema custom validator.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function. Its first parameter must accept the field's validated
  /// type, or `Object?`. Its second parameter may be typed as
  /// `Map<String, Object?>`, or as [SchemaData] to reach `root`.
  final bool Function(Never value, SchemaData data) customValidator;

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}
