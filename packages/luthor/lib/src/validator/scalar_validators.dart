part of '../validator.dart';

/// Validates booleans. Created by `l.bool()`.
///
/// [O] is `bool?` until `.required()` makes it `bool`.
final class BoolValidator<O extends bool?> extends Validator<O>
    with _Modifiers<bool, O, BoolValidator<O>> {
  BoolValidator._(super._spec) : super._();

  @override
  BoolValidator<O> _copy(_Spec spec) => BoolValidator<O>._(spec);

  /// Returns a copy of this validator that rejects `null` and missing values.
  BoolValidator<bool> required({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return BoolValidator<bool>._(_spec.withRequired(message, messageBuilder));
  }
}

/// Accepts any value. Created by `l.any()`.
///
/// [O] is `Object?` until `.required()` makes it `Object`.
final class AnyValidator<O extends Object?> extends Validator<O>
    with _Modifiers<Object, O, AnyValidator<O>> {
  AnyValidator._(super._spec) : super._();

  @override
  AnyValidator<O> _copy(_Spec spec) => AnyValidator<O>._(spec);

  /// Returns a copy of this validator that rejects `null` and missing values.
  AnyValidator<Object> required({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return AnyValidator<Object>._(_spec.withRequired(message, messageBuilder));
  }
}

/// Accepts only `null`. Created by `l.nullValue()`.
///
/// Its output is always `null`. It has no `required()`, since a required
/// value can never be `null`.
final class NullValidator extends Validator<Object?> {
  NullValidator._(super._spec) : super._();

  /// Returns a copy of this validator that uses [name] as the field name in
  /// default error messages when it validates a value directly.
  NullValidator withName(String? name) => NullValidator._(_spec.withName(name));
}

/// Validates file-like values. Created by `l.file()`.
///
/// [O] is `Object?` until `.required()` makes it `Object`.
final class FileValidator<O extends Object?> extends Validator<O>
    with _Modifiers<Object, O, FileValidator<O>> {
  FileValidator._(super._spec) : super._();

  @override
  FileValidator<O> _copy(_Spec spec) => FileValidator<O>._(spec);

  /// Returns a copy of this validator that rejects `null` and missing values.
  FileValidator<Object> required({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return FileValidator<Object>._(_spec.withRequired(message, messageBuilder));
  }
}
