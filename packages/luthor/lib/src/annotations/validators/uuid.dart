import 'package:luthor/src/validation_issue.dart';

/// Requires a UUID string.
///
/// The generator emits `.uuid()` for the annotated field.
final class IsUuid {
  /// Creates the annotation.
  const IsUuid({this.message, this.messageBuilder});

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}

/// A [IsUuid] with the default message.
const isUuid = IsUuid();
