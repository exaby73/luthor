/// Identifies the kind of problem a [ValidationIssue] reports.
///
/// Codes are an open set backed by a [String], so new codes can be added in
/// minor releases. When switching on a code, always include a default case.
///
/// ```dart
/// String translate(ValidationIssue issue) => switch (issue.code) {
///   IssueCode.required => '${issue.fieldName} fehlt',
///   _ => issue.message,
/// };
/// ```
extension type const IssueCode(String name) {
  /// The value is `null` or missing but `.required()` is present.
  static const required = IssueCode('required');

  /// The value does not have the type the validator expects.
  ///
  /// `params['expected']` names the expected type, such as `'string'`.
  static const invalidType = IssueCode('invalidType');

  /// A number is below `params['min']`.
  static const tooSmall = IssueCode('tooSmall');

  /// A number is above `params['max']`.
  static const tooBig = IssueCode('tooBig');

  /// A number is `NaN` or infinite and `.finite()` is present.
  static const notFinite = IssueCode('notFinite');

  /// A string is shorter than `params['min']` characters.
  static const tooShort = IssueCode('tooShort');

  /// A string is longer than `params['max']` characters.
  static const tooLong = IssueCode('tooLong');

  /// A string does not have exactly `params['length']` characters.
  static const invalidLength = IssueCode('invalidLength');

  /// A string is not a valid email address.
  static const invalidEmail = IssueCode('invalidEmail');

  /// A string is not a valid ISO 8601 date or date-time.
  static const invalidDateTime = IssueCode('invalidDateTime');

  /// A string is not an absolute URI, or its scheme is not in
  /// `params['allowedSchemes']`.
  static const invalidUri = IssueCode('invalidUri');

  /// A string is not a URL with a scheme and a host, or its scheme is not in
  /// `params['allowedSchemes']`.
  static const invalidUrl = IssueCode('invalidUrl');

  /// A string is not made only of emoji.
  static const invalidEmoji = IssueCode('invalidEmoji');

  /// A string is not a UUID.
  static const invalidUuid = IssueCode('invalidUuid');

  /// A string is not a CUID.
  static const invalidCuid = IssueCode('invalidCuid');

  /// A string is not a CUID2.
  static const invalidCuid2 = IssueCode('invalidCuid2');

  /// A string is not an IP address of `params['version']`, or of any version
  /// when that is `null`.
  static const invalidIp = IssueCode('invalidIp');

  /// A string does not match `params['pattern']`.
  static const invalidPattern = IssueCode('invalidPattern');

  /// A string does not start with `params['prefix']`.
  static const missingPrefix = IssueCode('missingPrefix');

  /// A string does not end with `params['suffix']`.
  static const missingSuffix = IssueCode('missingSuffix');

  /// A string does not contain `params['substring']`.
  static const missingSubstring = IssueCode('missingSubstring');

  /// The value is not one of `params['allowed']`.
  static const notOneOf = IssueCode('notOneOf');

  /// The value matches none of the options of a union.
  ///
  /// `params['issues']` holds a `List<List<ValidationIssue>>` with the issues
  /// of each option, in order.
  static const invalidUnion = IssueCode('invalidUnion');

  /// A map key failed its key validator.
  ///
  /// The issue is reported at the map's path. `params['key']` is the key and
  /// `params['issues']` holds the key validator's `List<ValidationIssue>`.
  static const invalidKey = IssueCode('invalidKey');

  /// A strict schema received a key it does not declare.
  ///
  /// `params['key']` is the key.
  static const unrecognizedKey = IssueCode('unrecognizedKey');

  /// A custom validator or schema custom validator returned `false` or threw.
  static const custom = IssueCode('custom');

  /// The input is nested deeper than the maximum depth.
  ///
  /// `params['maxDepth']` is the limit that was exceeded.
  static const tooDeep = IssueCode('tooDeep');

  /// The `fromJson` function passed to `validateSchema` threw.
  ///
  /// `params['error']` is the thrown object.
  static const fromJsonFailed = IssueCode('fromJsonFailed');
}

/// One problem found while validating a value.
///
/// Issues are the source of truth of a failed validation result. The error
/// messages and the error map are derived from them.
final class ValidationIssue {
  /// Creates an issue.
  const ValidationIssue({
    required this.code,
    required this.message,
    this.path = const [],
    this.params = const {},
    this.fieldName,
  });

  /// The kind of problem.
  final IssueCode code;

  /// The location of the problem inside the validated value.
  ///
  /// Each segment is a schema field key or map key, or an `int` list index.
  /// The path is empty for problems with the validated value itself.
  final List<Object> path;

  /// The human-readable error message.
  final String message;

  /// The values that describe the problem, such as `{'min': 3}`.
  ///
  /// Each [IssueCode] documents the params it sets.
  final Map<String, Object?> params;

  /// The field name used in default error messages, or `null` when the value
  /// has no name.
  final String? fieldName;

  /// The [path] as an error path, with segments joined by dots.
  ///
  /// The error path of the validated value itself is the empty string.
  String get errorPath => path.join('.');

  /// Returns a copy of this issue with [message] replaced.
  ValidationIssue withMessage(String message) {
    return ValidationIssue(
      code: code,
      message: message,
      path: path,
      params: params,
      fieldName: fieldName,
    );
  }

  @override
  String toString() {
    return 'ValidationIssue(code: $code, path: $errorPath, message: $message)';
  }
}

/// Builds the error message of an issue.
///
/// The [issue] passed in carries the default message, so a builder can fall
/// back to `issue.message`.
typedef MessageBuilder = String Function(ValidationIssue issue);
