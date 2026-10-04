part of '../validator.dart';

/// Creates validators, and holds the settings that apply to every
/// validation. Use it through [l].
///
/// Each method starts a validator with a type check, such as `l.string()`.
/// Type methods mirror Dart types, not JSON types: `l.int()` accepts only
/// `int` values.
final class ValidatorFactory {
  ValidatorFactory._();

  /// The default value of [maxDepth].
  static const defaultMaxDepth = 512;

  /// Builds the message of every issue that has no per-validation `message`
  /// or `messageBuilder`, for example to translate messages.
  ///
  /// The issue passed in carries the default English message. Set it back to
  /// `null` to use the default messages.
  ///
  /// ```dart
  /// l.messageBuilder = (issue) => switch (issue.code) {
  ///   IssueCode.required => '${issue.fieldName ?? 'Wert'} fehlt',
  ///   _ => issue.message,
  /// };
  /// ```
  MessageBuilder? messageBuilder;

  /// How deep schemas, lists, maps and unions may nest inside the validated
  /// value before validation stops with an [IssueCode.tooDeep] issue.
  ///
  /// The guard fails closed: data beyond the limit is reported, never
  /// accepted. It protects recursive schemas from deeply nested untrusted
  /// input.
  core.int maxDepth = defaultMaxDepth;

  /// Starts a validator for `String` values.
  StringValidator<String?> string({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return StringValidator<String?>._(
      _Spec(
        type: _typeCheck(
          'string',
          (value) => value is String,
          (field) => '$field must be a string',
          message,
          messageBuilder,
        ),
      ),
    );
  }

  /// Starts a validator for `int` values.
  ///
  /// Doubles such as `1.0` fail on the VM; see [NumberValidator].
  NumberValidator<core.int, core.int?> int({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return NumberValidator<core.int, core.int?>._(
      _Spec(
        type: _typeCheck(
          'int',
          (value) => value is core.int,
          (field) => '$field must be an integer',
          message,
          messageBuilder,
        ),
      ),
    );
  }

  /// Starts a validator for `double` values.
  ///
  /// Integers such as `1` fail on the VM; use [num] to accept both.
  NumberValidator<core.double, core.double?> double({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return NumberValidator<core.double, core.double?>._(
      _Spec(
        type: _typeCheck(
          'double',
          (value) => value is core.double,
          (field) => '$field must be a double',
          message,
          messageBuilder,
        ),
      ),
    );
  }

  /// Starts a validator for any `num`, `int` or `double`.
  NumberValidator<core.num, core.num?> num({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return NumberValidator<core.num, core.num?>._(
      _Spec(
        type: _typeCheck(
          'num',
          (value) => value is core.num,
          (field) => '$field must be a number',
          message,
          messageBuilder,
        ),
      ),
    );
  }

  /// Starts a validator for `bool` values.
  BoolValidator<core.bool?> bool({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return BoolValidator<core.bool?>._(
      _Spec(
        type: _typeCheck(
          'bool',
          (value) => value is core.bool,
          (field) => '$field must be a bool',
          message,
          messageBuilder,
        ),
      ),
    );
  }

  /// Starts a validator that accepts any value.
  AnyValidator<Object?> any() => AnyValidator<Object?>._(const _Spec());

  /// Starts a validator that accepts only `null`.
  NullValidator nullValue({String? message, MessageBuilder? messageBuilder}) {
    return NullValidator._(
      _Spec(
        type: _typeCheck(
          'null',
          (_) => false,
          (field) => '$field must be null',
          message,
          messageBuilder,
        ),
      ),
    );
  }

  /// Starts a validator for file-like values.
  ///
  /// [accept] accepts further values as files, such as package types like
  /// `XFile` or `MultipartFile`: `l.file(accept: (value) => value is XFile)`.
  /// An [accept] that throws rejects the value.
  FileValidator<Object?> file({
    FileAcceptor? accept,
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return FileValidator<Object?>._(
      _Spec(
        type: _typeCheck(
          'file',
          (value) =>
              isFile(value) || (accept != null && _passes(() => accept(value))),
          (field) => '$field must be a file',
          message,
          messageBuilder,
        ),
      ),
    );
  }

  /// Starts a validator for lists whose elements pass [element].
  ///
  /// Use `l.list(l.any())` to accept any elements.
  ///
  /// ```dart
  /// l.list(l.string().email().required()); // validates to List<String>?
  /// ```
  ListValidator<E, List<E>?> list<E>(
    ValidatorReference<E> element, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return ListValidator<E, List<E>?>._(
      _Spec(
        type: _typeCheck(
          'list',
          (value) => value is List,
          (field) => '$field must be a list',
          message,
          messageBuilder,
        ),
      ),
      element,
    );
  }

  /// Starts a validator for maps whose keys pass [keyValidator] and values
  /// pass [valueValidator].
  ///
  /// Without a key or value validator, keys or values are only checked to be
  /// of type [K] or [V].
  MapValidator<K, V, Map<K, V>?> map<K, V>({
    ValidatorReference<K>? keyValidator,
    ValidatorReference<V>? valueValidator,
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return MapValidator<K, V, Map<K, V>?>._(
      _Spec(type: _mapType(message, messageBuilder)),
      keyValidator,
      valueValidator,
    );
  }

  /// Starts a schema: a validator for maps with the given [fields].
  ///
  /// [message] and [messageBuilder] apply when the value is not a map.
  ///
  /// ```dart
  /// final user = l.schema({
  ///   'email': l.string().email().required(),
  ///   'age': l.int().min(18),
  /// });
  /// ```
  SchemaValidator<Map<String, Object?>?> schema(
    Map<String, ValidatorReference<Object?>> fields, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return SchemaValidator<Map<String, Object?>?>._(
      _Spec(type: _mapType(message, messageBuilder)),
      Map.unmodifiable(fields),
    );
  }

  /// Starts a validator that accepts a value passing any of [options].
  ///
  /// [message] and [messageBuilder] apply when no option passes. Throws an
  /// [ArgumentError] if [options] is empty.
  ///
  /// ```dart
  /// l.list(l.union([l.string().email(), l.int().min(1)]));
  /// ```
  UnionValidator<Object?> union(
    List<ValidatorReference<Object?>> options, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    if (options.isEmpty) {
      throw ArgumentError.value(options, 'options', 'must not be empty');
    }
    return UnionValidator<Object?>._(
      const _Spec(),
      List.unmodifiable(options),
      _Check(
        IssueCode.invalidUnion,
        (_, _) => false,
        (field) => '$field does not match any allowed option',
        message: message,
        messageBuilder: messageBuilder,
      ),
    );
  }

  /// Starts a validator that accepts only the given [values], compared with
  /// `==`.
  ///
  /// Use it for enum fields serialized by name or by `@JsonValue`:
  /// `l.oneOf(['admin', 'member'])`. Throws an [ArgumentError] if [values]
  /// is empty.
  OneOfValidator<T, T?> oneOf<T extends Object>(
    List<T> values, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    if (values.isEmpty) {
      throw ArgumentError.value(values, 'values', 'must not be empty');
    }
    final allowed = List<T>.unmodifiable(values);
    return OneOfValidator<T, T?>._(
      const _Spec(),
      allowed,
      _Check(
        IssueCode.notOneOf,
        (_, _) => false,
        (field) => '$field must be one of: ${allowed.join(', ')}',
        params: {'allowed': allowed},
        message: message,
        messageBuilder: messageBuilder,
      ),
    );
  }
}

_Check _mapType(String? message, MessageBuilder? messageBuilder) {
  return _typeCheck(
    'map',
    (value) => value is Map,
    (field) => '$field must be a map',
    message,
    messageBuilder,
  );
}

/// The entry point for creating validators and changing global settings.
///
/// ```dart
/// final result = l.string().email().required().validate('dev@example.com');
/// ```
final l = ValidatorFactory._();
