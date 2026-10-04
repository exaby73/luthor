import 'package:luthor/src/validation_issue.dart';

/// Requires a URL string with a scheme and a host.
///
/// The generator emits `.url(allowedSchemes: allowedSchemes)` for the
/// annotated field.
final class IsUrl {
  /// Creates the annotation.
  const IsUrl({this.allowedSchemes, this.message, this.messageBuilder});

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

/// An [IsUrl] that allows any scheme and uses the default message.
const isUrl = IsUrl();
