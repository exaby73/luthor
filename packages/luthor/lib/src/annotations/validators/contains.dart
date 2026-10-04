import 'package:luthor/src/validation_issue.dart';

/// Requires a string that contains [string].
///
/// The generator emits `.contains(string)` for the annotated field.
final class Contains {
  /// Creates the annotation.
  const Contains(this.string, {this.message, this.messageBuilder});

  /// The text the value must contain.
  final String string;

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}
