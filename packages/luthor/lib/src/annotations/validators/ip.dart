import 'package:luthor/src/types/ip.dart';
import 'package:luthor/src/validation_issue.dart';

/// Requires an IP address string.
///
/// The generator emits `.ip(version: version)` for the annotated field.
final class IsIp {
  /// Creates the annotation.
  const IsIp({this.version, this.message, this.messageBuilder});

  /// The required IP version, or `null` for either version.
  final IpVersion? version;

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}

/// An [IsIp] that accepts either IP version and uses the default message.
const isIp = IsIp();
