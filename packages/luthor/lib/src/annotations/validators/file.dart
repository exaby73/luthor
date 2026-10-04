import 'package:luthor/src/validation_issue.dart';
import 'package:luthor/src/validator.dart';

/// Validates the annotated field with `l.file()`.
///
/// The generator emits `l.file(accept: accept)` for the annotated field.
final class IsFile {
  /// Creates the annotation.
  const IsFile({this.accept, this.message, this.messageBuilder});

  /// Accepts further values as files, such as `XFile`.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final FileAcceptor? accept;

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}

/// An [IsFile] with the default message.
const isFile = IsFile();
