import 'dart:collection';
import 'dart:core';
import 'dart:core' as core;

import 'package:luthor/src/formats.dart';
import 'package:luthor/src/types/ip.dart';
import 'package:luthor/src/validation_issue.dart';
import 'package:luthor/src/validation_result.dart';

part 'validator/check.dart';
part 'validator/collection_validators.dart';
part 'validator/context.dart';
part 'validator/factory.dart';
part 'validator/number_validator.dart';
part 'validator/scalar_validators.dart';
part 'validator/schema_validator.dart';
part 'validator/string_validator.dart';

/// Converts a validated map into a model, such as a generated `fromJson`.
typedef FromJson<T> = T Function(Map<String, Object?> json);

/// A function passed to `.custom()` that checks one value.
///
/// It receives only values that passed the validator's type check, and never
/// `null`. Returning `false` or throwing fails the value.
typedef CustomValidator<T> = bool Function(T value);

/// A function passed to `.customWithSchema()` that checks one field with
/// access to the data of the schema that contains it.
///
/// It receives only values that passed the validator's type check, and never
/// `null`. Returning `false` or throwing fails the value.
typedef SchemaCustomValidator<T> = bool Function(T value, SchemaData data);

/// Accepts a value as a file in `l.file(accept: ...)`.
typedef FileAcceptor = bool Function(Object value);

/// A reference to a validator, resolved when a value is validated.
///
/// Every [Validator] is a reference to itself. [forwardRef] creates a lazy
/// reference, so a schema can refer to itself or to a schema defined later.
abstract interface class ValidatorReference<O> {
  /// Returns the referenced validator.
  Validator<O> resolve();
}

/// Creates a forward reference that calls [resolver] each time a value is
/// validated.
///
/// Use it for schemas that refer to themselves or to each other. Recursion is
/// bounded by the input, and by [ValidatorFactory.maxDepth].
///
/// ```dart
/// late final SchemaValidator node;
/// node = l.schema({
///   'value': l.string().required(),
///   'children': l.list(forwardRef(() => node.required())),
/// });
/// ```
ValidatorReference<O> forwardRef<O>(Validator<O> Function() resolver) {
  return _ForwardRef<O>(resolver);
}

final class _ForwardRef<O> implements ValidatorReference<O> {
  const _ForwardRef(this._resolver);

  final Validator<O> Function() _resolver;

  @override
  Validator<O> resolve() => _resolver();
}

/// An immutable, chainable object that checks a value and produces a typed
/// output of type [O].
///
/// Validators are created from [l], such as `l.string()`. Every modifier
/// returns a new validator, so a validator can be reused safely.
///
/// A validator is optional by default: `null`, and a missing schema field,
/// pass unless `.required()` is present. Required validators have a
/// non-nullable [O].
abstract base class Validator<O> implements ValidatorReference<O> {
  Validator._(this._spec);

  final _Spec _spec;

  /// The field name used in default error messages when this validator
  /// validates a value directly. Set it with `withName`.
  ///
  /// Inside a schema, the field key is the field name instead.
  String? get name => _spec.name;

  @override
  Validator<O> resolve() => this;

  /// Validates [input] and returns the typed output or the issues found.
  ///
  /// Never throws for invalid input.
  ValidationResult<O> validate(Object? input) {
    final (output, issues) = _run(input, _Context.root(name));
    if (issues.isNotEmpty) {
      return ValidationFailure(input: input, issues: issues);
    }
    return ValidationSuccess(output as O);
  }

  bool get _isRequired => _spec.required != null;

  _Outcome _run(Object? value, _Context context) {
    if (value == null) {
      final required = _spec.required;
      return (null, required == null ? const [] : [required.issue(context)]);
    }
    final typeIssue = _spec.type?.check(value, context);
    if (typeIssue != null) return (value, [typeIssue]);
    if (_nests && context.depth > context.maxDepth) {
      return (value, [context.tooDeep()]);
    }

    final (output, issues) = _convert(value, context);
    if (issues.isNotEmpty) return (output, issues);
    return (
      output,
      [for (final check in _spec.checks) ?check.check(output!, context)],
    );
  }

  bool get _nests => false;

  _Outcome _convert(Object value, _Context context) => (value, const []);
}

typedef _Outcome = (Object?, List<ValidationIssue>);

final class _Spec {
  const _Spec({this.name, this.type, this.required, this.checks = const []});

  final String? name;
  final _Check? type;
  final _Check? required;
  final List<_Check> checks;

  _Spec withName(String? name) {
    return _Spec(name: name, type: type, required: required, checks: checks);
  }

  _Spec withRequired(String? message, MessageBuilder? messageBuilder) {
    return _Spec(
      name: name,
      type: type,
      required: _requiredCheck(message, messageBuilder),
      checks: checks,
    );
  }

  _Spec withCheck(_Check check) {
    return _Spec(
      name: name,
      type: type,
      required: required,
      checks: [...checks, check],
    );
  }
}

base mixin _Modifiers<T extends Object, O, Self extends Validator<O>>
    on Validator<O> {
  Self _copy(_Spec spec);

  /// Returns a copy of this validator that uses [name] as the field name in
  /// default error messages when it validates a value directly.
  ///
  /// Inside a schema, the field key is used instead.
  Self withName(String? name) => _copy(_spec.withName(name));

  /// Returns a copy of this validator that also runs [validator] on values
  /// that passed the type check.
  ///
  /// On schemas, lists, maps and unions, [validator] runs only when every
  /// child passed too, so it receives well-typed data.
  ///
  /// A [validator] that returns `false` or throws reports an
  /// [IssueCode.custom] issue.
  Self custom(
    CustomValidator<T> validator, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _copy(
      _spec.withCheck(
        _Check(
          IssueCode.custom,
          (value, _) => _passes(() => validator(value as T)),
          (field) => '$field does not pass custom validation',
          message: message,
          messageBuilder: messageBuilder,
        ),
      ),
    );
  }

  /// Returns a copy of this validator that also runs [validator] with the
  /// data of the schema that contains the value.
  ///
  /// Inside a list or map, [validator] receives the data of the schema that
  /// holds it. Outside a schema, it receives empty [SchemaData]. A
  /// [validator] that returns `false` or throws reports an [IssueCode.custom]
  /// issue.
  Self customWithSchema(
    SchemaCustomValidator<T> validator, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _copy(
      _spec.withCheck(
        _Check(
          IssueCode.custom,
          (value, context) => _passes(
            () => validator(value as T, context.schema ?? SchemaData._empty),
          ),
          (field) => '$field does not pass schema custom validation',
          message: message,
          messageBuilder: messageBuilder,
        ),
      ),
    );
  }
}

bool _passes(bool Function() test) {
  try {
    return test();
  } on Object {
    return false;
  }
}
