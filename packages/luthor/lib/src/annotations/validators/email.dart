import 'package:luthor/src/validation_issue.dart';

/// Requires an email address string.
///
/// The generator emits `.email()` for the annotated field.
final class IsEmail {
  /// Creates the annotation.
  const IsEmail({this.message, this.messageBuilder});

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}

/// A [IsEmail] with the default message.
const isEmail = IsEmail();
