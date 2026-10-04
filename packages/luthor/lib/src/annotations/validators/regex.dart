import 'package:luthor/src/validation_issue.dart';

/// Requires a string that matches [pattern] anywhere.
///
/// The generator emits `.regex(RegExp(pattern, ...))` with the flags below.
/// [pattern] is not anchored; use `^` and `$` to match the whole string.
final class MatchRegex {
  /// Creates the annotation.
  const MatchRegex(
    this.pattern, {
    this.caseSensitive = true,
    this.multiLine = false,
    this.unicode = false,
    this.dotAll = false,
    this.message,
    this.messageBuilder,
  });

  /// The regular expression source.
  final String pattern;

  /// The [RegExp.isCaseSensitive] flag.
  final bool caseSensitive;

  /// The [RegExp.isMultiLine] flag.
  final bool multiLine;

  /// The [RegExp.isUnicode] flag.
  final bool unicode;

  /// The [RegExp.isDotAll] flag.
  final bool dotAll;

  /// The error message, replacing the default message.
  final String? message;

  /// Builds the error message from the issue.
  ///
  /// Annotation arguments are constants, so this must be a top-level or
  /// static function, not a closure.
  final MessageBuilder? messageBuilder;
}
