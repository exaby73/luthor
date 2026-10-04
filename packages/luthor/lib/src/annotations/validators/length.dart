import 'package:luthor/src/validation_issue.dart';

/// Requires a string of exactly [length] characters.
///
/// The generator emits `.length(length)` for the annotated field.
final class HasLength {
  /// Creates the annotation.
  const HasLength(this.length, {this.message, this.messageBuilder});

  /// The required number of characters.
  final int length;

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}
