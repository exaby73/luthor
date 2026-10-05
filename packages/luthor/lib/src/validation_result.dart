import 'package:luthor/src/validation_issue.dart';

/// The result of validating a value: a [ValidationSuccess] holding the typed
/// output, or a [ValidationFailure] holding the issues.
///
/// The error views ([messages], [errors], [getError] and [getErrors]) are
/// derived from [issues] and are empty on success, so they can be read
/// without matching on the result first.
///
/// ```dart
/// switch (l.string().email().required().validate(input)) {
///   case ValidationSuccess(:final data):
///     print('valid: $data');
///   case ValidationFailure(:final messages):
///     print('invalid: $messages');
/// }
/// ```
sealed class ValidationResult<T> {
  const ValidationResult();

  /// Whether the value passed every validation.
  bool get isValid;

  /// The problems found, in the order they were found. Empty on success.
  List<ValidationIssue> get issues;

  /// Every error message, in issue order.
  List<String> get messages => [for (final issue in issues) issue.message];

  /// The error map: error messages grouped by error path.
  ///
  /// Keys are dot-joined paths such as `'address.city'` or `'items.1.id'`.
  /// Errors about the validated value itself, including object-level errors
  /// from `.custom()` on a schema, are under the empty path `''`.
  Map<String, List<String>> get errors {
    final errors = <String, List<String>>{};
    for (final issue in issues) {
      (errors[issue.errorPath] ??= []).add(issue.message);
    }
    return errors;
  }

  /// Returns the first error message at exactly [path], or `null` if there is
  /// none.
  ///
  /// [path] is an error path such as `'address.city'`. Use `''` for errors
  /// about the validated value itself.
  ///
  /// ```dart
  /// final result = l.schema({
  ///   'name': l.string().required(),
  ///   'address': l.schema({'city': l.string().required()}).required(),
  /// }).validate({'address': <String, Object?>{}});
  ///
  /// result.getError('name'); // name is required
  /// result.getError('address.city'); // city is required
  /// result.getError('address'); // null
  /// ```
  String? getError(String path) {
    for (final issue in issues) {
      if (issue.errorPath == path) return issue.message;
    }
    return null;
  }

  /// Returns every error message at exactly [path], in issue order.
  List<String> getErrors(String path) {
    return [
      for (final issue in issues)
        if (issue.errorPath == path) issue.message,
    ];
  }
}

/// A validation result for a value that passed every validation.
final class ValidationSuccess<T> extends ValidationResult<T> {
  /// Creates a successful result holding [data].
  const ValidationSuccess(this.data);

  /// The validated output.
  final T data;

  @override
  bool get isValid => true;

  @override
  List<ValidationIssue> get issues => const [];

  @override
  String toString() => 'ValidationSuccess(data: $data)';
}

/// A validation result for a value that failed at least one validation.
final class ValidationFailure<T> extends ValidationResult<T> {
  /// Creates a failed result for [input] with at least one issue.
  ///
  /// Throws an [ArgumentError] if [issues] is empty.
  ValidationFailure({
    required this.input,
    required List<ValidationIssue> issues,
  }) : issues = List.unmodifiable(issues) {
    if (issues.isEmpty) {
      throw ArgumentError.value(issues, 'issues', 'must not be empty');
    }
  }

  /// The raw value that was validated.
  final Object? input;

  @override
  final List<ValidationIssue> issues;

  @override
  bool get isValid => false;

  /// A debug description of [errors]. Object-level errors, whose error path
  /// is `''`, are shown under `(root)`. [errors] and [getError] still use
  /// `''`.
  @override
  String toString() {
    final shown = {
      for (final MapEntry(:key, :value) in errors.entries)
        key.isEmpty ? '(root)' : key: value,
    };
    return 'ValidationFailure(errors: $shown)';
  }
}
