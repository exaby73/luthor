import 'package:luthor/src/validation_issue.dart';

/// Adds a custom validator to the annotated field.
///
/// The generator emits `.custom(customValidator)` for the annotated field.
final class WithCustomValidator {
  /// Creates the annotation.
  const WithCustomValidator(
    this.customValidator, {
    this.message,
    this.messageBuilder,
  });

  /// The custom validator.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function. Its parameter must accept the field's validated type,
  /// such as `bool isEven(int value)` on an `int` field, or `Object?`.
  final bool Function(Never value) customValidator;

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}
