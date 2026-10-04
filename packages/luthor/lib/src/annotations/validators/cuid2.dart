import 'package:luthor/src/validation_issue.dart';

/// Requires a CUID2 string.
///
/// The generator emits `.cuid2()` for the annotated field.
final class IsCuid2 {
  /// Creates the annotation.
  const IsCuid2({this.message, this.messageBuilder});

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}

/// A [IsCuid2] with the default message.
const isCuid2 = IsCuid2();
