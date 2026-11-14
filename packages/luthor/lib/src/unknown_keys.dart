import 'package:luthor/src/validation_issue.dart';

/// How a schema handles keys in its input that it does not declare.
///
/// Set it on a schema with `.unknownKeys()`, or on a model with
/// `@Luthor(unknownKeys: ...)`.
enum UnknownKeys {
  /// Drops unknown keys from the output. The default.
  strip,

  /// Copies unknown keys into the output without validating them.
  passthrough,

  /// Reports each unknown key as an [IssueCode.unrecognizedKey] issue.
  strict,
}
