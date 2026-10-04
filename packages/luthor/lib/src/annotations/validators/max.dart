import 'package:luthor/src/validation_issue.dart';

/// Sets a maximum bound that depends on the annotated field's type.
///
/// On a `String` field, [max] is the maximum length, so it must be an
/// `int`. On an `int`, `double` or `num` field, [max] is the inclusive
/// maximum value. The generator emits `.max(max)` for the annotated
/// field.
final class HasMax {
  /// Creates the annotation.
  const HasMax(this.max, {this.message, this.messageBuilder});

  /// The maximum length of a string, or the maximum value of a number.
  final num max;

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}
