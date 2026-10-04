import 'package:luthor/src/validation_issue.dart';

/// Requires an ISO 8601 date or date-time string.
///
/// The generator emits `.dateTime()` for the annotated field.
final class IsDateTime {
  /// Creates the annotation.
  const IsDateTime({this.message, this.messageBuilder});

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}

/// A [IsDateTime] with the default message.
const isDateTime = IsDateTime();
