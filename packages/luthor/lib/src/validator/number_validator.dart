part of '../validator.dart';

/// Validates numbers of the Dart type [N]. Created by `l.int()`, `l.double()`
/// and `l.num()`.
///
/// [O] is `N?` until `.required()` makes it `N`.
///
/// The type check is Dart's `is N`, so `l.int()` rejects `1.0` and
/// `l.double()` rejects `1` on the VM. On the web, where every number is a
/// JavaScript number, `1.0 is int` and `1 is double` are both true.
///
/// `NaN` and infinity are doubles, so they pass `l.double()` and `l.num()`.
/// Add [finite] to reject them.
final class NumberValidator<N extends num, O extends N?> extends Validator<O>
    with _Modifiers<N, O, NumberValidator<N, O>> {
  NumberValidator._(super._spec) : super._();

  @override
  NumberValidator<N, O> _copy(_Spec spec) => NumberValidator<N, O>._(spec);

  NumberValidator<N, O> _with(
    IssueCode code,
    bool Function(num value) test,
    String Function(String field) describe, {
    Map<String, Object?> params = const {},
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _copy(
      _spec.withCheck(
        _Check(
          code,
          (value, _) => test(value as num),
          describe,
          params: params,
          message: message,
          messageBuilder: messageBuilder,
        ),
      ),
    );
  }

  /// Returns a copy of this validator that rejects `null` and missing values.
  NumberValidator<N, N> required({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return NumberValidator<N, N>._(_spec.withRequired(message, messageBuilder));
  }

  /// Requires a value greater than or equal to [minValue].
  NumberValidator<N, O> min(
    N minValue, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _with(
      IssueCode.tooSmall,
      (value) => value >= minValue,
      (field) => '$field must be greater than or equal to $minValue',
      params: {'min': minValue},
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires a value less than or equal to [maxValue].
  NumberValidator<N, O> max(
    N maxValue, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _with(
      IssueCode.tooBig,
      (value) => value <= maxValue,
      (field) => '$field must be less than or equal to $maxValue',
      params: {'max': maxValue},
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Rejects `NaN`, infinity and negative infinity.
  NumberValidator<N, O> finite({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _with(
      IssueCode.notFinite,
      (value) => value.isFinite,
      (field) => '$field must be a finite number',
      message: message,
      messageBuilder: messageBuilder,
    );
  }
}

/// A [NumberValidator] for `int`, created by `l.int()`.
typedef IntValidator<O extends int?> = NumberValidator<int, O>;

/// A [NumberValidator] for `double`, created by `l.double()`.
typedef DoubleValidator<O extends double?> = NumberValidator<double, O>;

/// A [NumberValidator] for any `num`, created by `l.num()`.
typedef NumValidator<O extends num?> = NumberValidator<num, O>;
