import 'package:luthor/src/validation_issue.dart';

/// Requires an absolute URI string.
///
/// The generator emits `.uri(allowedSchemes: allowedSchemes)` for the
/// annotated field.
final class IsUri {
  /// Creates the annotation.
  const IsUri({this.allowedSchemes, this.message, this.messageBuilder});

  /// The schemes the value may use, compared case-insensitively, or `null`
  /// for any scheme.
  final List<String>? allowedSchemes;

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}

/// An [IsUri] that allows any scheme and uses the default message.
const isUri = IsUri();
