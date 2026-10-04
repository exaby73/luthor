import 'package:luthor/src/validation_issue.dart';

/// Requires a string that starts with [string].
///
/// The generator emits `.startsWith(string)` for the annotated field.
final class StartsWith {
  /// Creates the annotation.
  const StartsWith(this.string, {this.message, this.messageBuilder});

  /// The text the value must start with.
  final String string;

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}
