import 'package:luthor/src/validation_issue.dart';

/// Requires a string made only of emoji.
///
/// The generator emits `.emoji()` for the annotated field.
final class IsEmoji {
  /// Creates the annotation.
  const IsEmoji({this.message, this.messageBuilder});

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}

/// A [IsEmoji] with the default message.
const isEmoji = IsEmoji();
