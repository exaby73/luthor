import 'package:luthor/src/validation_issue.dart';

/// Requires a CUID string.
///
/// The generator emits `.cuid()` for the annotated field.
final class IsCuid {
  /// Creates the annotation.
  const IsCuid({this.message, this.messageBuilder});

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}

/// A [IsCuid] with the default message.
const isCuid = IsCuid();
