part of '../validator.dart';

enum _UnknownKeys { strip, passthrough, strict }

/// Validates a map against named fields. Created by `l.schema()`.
///
/// [O] is `Map<String, Object?>?` until `.required()` makes it
/// `Map<String, Object?>`.
///
/// Any [Map] is accepted as input, whatever its type arguments. The output
/// is a new `Map<String, Object?>` with the validated value of each field
/// that is present. Unknown keys are stripped from the output by default;
/// see [passthrough] and [strict].
///
/// A missing field passes unless its validator is required. A present field
/// whose value is `null` passes unless its validator is required.
///
/// The default error messages of a field use its key as the field name.
final class SchemaValidator<O extends Map<String, Object?>?>
    extends Validator<O>
    with _Modifiers<Map<String, Object?>, O, SchemaValidator<O>> {
  SchemaValidator._(
    super._spec,
    this._fields, {
    _UnknownKeys unknownKeys = _UnknownKeys.strip,
    _Check? unknownKeyCheck,
  }) : _unknownKeys = unknownKeys,
       _unknownKeyCheck = unknownKeyCheck,
       super._();

  final Map<String, ValidatorReference<Object?>> _fields;
  final _UnknownKeys _unknownKeys;
  final _Check? _unknownKeyCheck;

  @override
  SchemaValidator<O> _copy(_Spec spec) {
    return SchemaValidator<O>._(
      spec,
      _fields,
      unknownKeys: _unknownKeys,
      unknownKeyCheck: _unknownKeyCheck,
    );
  }

  /// Returns a copy of this validator that rejects `null` and missing values.
  SchemaValidator<Map<String, Object?>> required({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return SchemaValidator<Map<String, Object?>>._(
      _spec.withRequired(message, messageBuilder),
      _fields,
      unknownKeys: _unknownKeys,
      unknownKeyCheck: _unknownKeyCheck,
    );
  }

  /// Returns a copy of this validator that keeps unknown keys in the output.
  ///
  /// Unknown keys are copied without validation. Non-string keys are
  /// converted with `toString()`.
  SchemaValidator<O> passthrough() {
    return SchemaValidator<O>._(
      _spec,
      _fields,
      unknownKeys: _UnknownKeys.passthrough,
    );
  }

  /// Returns a copy of this validator that reports an
  /// [IssueCode.unrecognizedKey] issue for each unknown key, at the path of
  /// that key.
  SchemaValidator<O> strict({String? message, MessageBuilder? messageBuilder}) {
    return SchemaValidator<O>._(
      _spec,
      _fields,
      unknownKeys: _UnknownKeys.strict,
      unknownKeyCheck: _Check(
        IssueCode.unrecognizedKey,
        (_, _) => false,
        (field) => '$field is not an allowed key',
        message: message,
        messageBuilder: messageBuilder,
      ),
    );
  }

  /// Validates [input] and converts the output with [fromJson].
  ///
  /// `null` reports an [IssueCode.required] issue, since there is no map to
  /// convert. [fromJson] runs only when validation succeeds, and receives
  /// the output map, without unknown keys unless [passthrough] is set. If it
  /// throws, the result is a failure with an [IssueCode.fromJsonFailed] issue.
  ///
  /// Never throws for invalid input.
  ValidationResult<T> validateSchema<T>(
    Object? input, {
    required FromJson<T> fromJson,
  }) {
    final context = _Context.root(name);
    if (input == null) {
      final required = _spec.required ?? _requiredCheck(null, null);
      return ValidationFailure(input: input, issues: [required.issue(context)]);
    }
    final (output, issues) = _run(input, context);
    if (issues.isNotEmpty) {
      return ValidationFailure(input: input, issues: issues);
    }
    try {
      return ValidationSuccess(fromJson(output! as Map<String, Object?>));
    } on Object catch (error) {
      return ValidationFailure(
        input: input,
        issues: [
          context.issue(
            IssueCode.fromJsonFailed,
            (field) => '$field could not be converted',
            params: {'error': error},
          ),
        ],
      );
    }
  }

  @override
  bool get _nests => true;

  @override
  _Outcome _convert(Object value, _Context context) {
    final input = value as Map<Object?, Object?>;
    final fields = {
      for (final entry in input.entries) '${entry.key}': entry.value,
    };
    final data = SchemaData._(fields, root: context.schema?.root ?? fields);
    final output = <String, Object?>{};
    final issues = <ValidationIssue>[];

    for (final entry in _fields.entries) {
      final key = entry.key;
      final validator = entry.value.resolve();
      final present = input.containsKey(key);
      if (!present && !validator._isRequired) continue;

      final (fieldOutput, fieldIssues) = validator._run(
        input[key],
        context.child(key, fieldName: key, schema: data),
      );
      issues.addAll(fieldIssues);
      if (present) output[key] = fieldOutput;
    }

    for (final entry in input.entries) {
      final key = entry.key;
      if (key is String && _fields.containsKey(key)) continue;
      switch (_unknownKeys) {
        case _UnknownKeys.strip:
          break;
        case _UnknownKeys.passthrough:
          output['$key'] = entry.value;
        case _UnknownKeys.strict:
          issues.add(
            _unknownKeyCheck!.issue(
              context.child(key ?? 'null', fieldName: '$key'),
              params: {'key': key},
            ),
          );
      }
    }

    return (output, issues);
  }
}
