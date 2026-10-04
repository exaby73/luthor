import 'package:luthor/src/validation_issue.dart';

/// Sets a minimum bound that depends on the annotated field's type.
///
/// On a `String` field, [min] is the minimum length, so it must be an
/// `int`. On an `int`, `double` or `num` field, [min] is the inclusive
/// minimum value. The generator emits `.min(min)` for the annotated
/// field.
final class HasMin {
  /// Creates the annotation.
  const HasMin(this.min, {this.message, this.messageBuilder});

  /// The minimum length of a string, or the minimum value of a number.
  final num min;

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}
