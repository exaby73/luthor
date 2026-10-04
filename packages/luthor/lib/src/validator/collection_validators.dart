part of '../validator.dart';

/// Validates lists whose elements validate to [E]. Created by `l.list()`.
///
/// [O] is `List<E>?` until `.required()` makes it `List<E>`.
///
/// Each element is validated by the element validator, and its issues are
/// reported at the element's index, such as `tags.1`. The output is a new
/// `List<E>` of the validated elements. An optional element validator lets
/// `null` elements through, so `l.list(l.int())` validates to `List<int?>`
/// and `l.list(l.int().required())` to `List<int>`.
final class ListValidator<E, O extends List<E>?> extends Validator<O>
    with _Modifiers<List<E>, O, ListValidator<E, O>> {
  ListValidator._(super._spec, this._element) : super._();

  final ValidatorReference<E> _element;

  @override
  ListValidator<E, O> _copy(_Spec spec) {
    return ListValidator<E, O>._(spec, _element);
  }

  /// Returns a copy of this validator that rejects `null` and missing values.
  ListValidator<E, List<E>> required({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return ListValidator<E, List<E>>._(
      _spec.withRequired(message, messageBuilder),
      _element,
    );
  }

  @override
  bool get _nests => true;

  @override
  _Outcome _convert(Object value, _Context context) {
    final input = value as List<Object?>;
    final element = _element.resolve();
    final output = <E>[];
    final issues = <ValidationIssue>[];

    for (var index = 0; index < input.length; index++) {
      final (itemOutput, itemIssues) = element._run(
        input[index],
        context.child(index, fieldName: element.name),
      );
      if (itemIssues.isEmpty) {
        output.add(itemOutput as E);
      } else {
        issues.addAll(itemIssues);
      }
    }

    return (output, issues);
  }
}

/// Validates maps whose keys validate to [K] and values to [V]. Created by
/// `l.map()`.
///
/// [O] is `Map<K, V>?` until `.required()` makes it `Map<K, V>`.
///
/// A value issue is reported at the path of its key, such as `scores.alice`.
/// A key issue is reported at the map's own path as an [IssueCode.invalidKey]
/// issue, so key and value errors never share a path. The output is a new
/// `Map<K, V>` of the validated entries.
final class MapValidator<K, V, O extends Map<K, V>?> extends Validator<O>
    with _Modifiers<Map<K, V>, O, MapValidator<K, V, O>> {
  MapValidator._(super._spec, this._keyValidator, this._valueValidator)
    : super._();

  final ValidatorReference<K>? _keyValidator;
  final ValidatorReference<V>? _valueValidator;

  @override
  MapValidator<K, V, O> _copy(_Spec spec) {
    return MapValidator<K, V, O>._(spec, _keyValidator, _valueValidator);
  }

  /// Returns a copy of this validator that rejects `null` and missing values.
  MapValidator<K, V, Map<K, V>> required({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return MapValidator<K, V, Map<K, V>>._(
      _spec.withRequired(message, messageBuilder),
      _keyValidator,
      _valueValidator,
    );
  }

  @override
  bool get _nests => true;

  @override
  _Outcome _convert(Object value, _Context context) {
    final input = value as Map<Object?, Object?>;
    final keyValidator = _keyValidator?.resolve();
    final valueValidator = _valueValidator?.resolve();
    final output = <K, V>{};
    final issues = <ValidationIssue>[];

    for (final entry in input.entries) {
      final key = entry.key;
      final keyContext = context.nested(fieldName: keyValidator?.name ?? 'key');
      final (keyOutput, keyIssues) = keyValidator != null
          ? keyValidator._run(key, keyContext)
          : _checkType<K>(key, keyContext);
      if (keyIssues.isNotEmpty) {
        issues.add(_invalidKeyIssue(context, key, keyIssues));
      }

      final valueContext = context.child(
        key ?? 'null',
        fieldName: valueValidator?.name,
      );
      final (valueOutput, valueIssues) = valueValidator != null
          ? valueValidator._run(entry.value, valueContext)
          : _checkType<V>(entry.value, valueContext);
      issues.addAll(valueIssues);

      if (keyIssues.isEmpty && valueIssues.isEmpty) {
        output[keyOutput as K] = valueOutput as V;
      }
    }

    return (output, issues);
  }

  ValidationIssue _invalidKeyIssue(
    _Context context,
    Object? key,
    List<ValidationIssue> keyIssues,
  ) {
    return context.issue(
      IssueCode.invalidKey,
      (field) => '$field has an invalid key "$key"',
      params: {'key': key, 'issues': keyIssues},
    );
  }
}

_Outcome _checkType<T>(Object? value, _Context context) {
  if (value is T) return (value, const []);
  return (
    value,
    [
      context.issue(
        IssueCode.invalidType,
        (field) => '$field must be a $T',
        params: {'expected': '$T'},
      ),
    ],
  );
}

/// Accepts a value that passes any of its options. Created by `l.union()`.
///
/// [O] is `Object?` until `.required()` makes it `Object`.
///
/// Options are tried in order against the same value, and the output of the
/// first option that passes is the output. When none passes, a single
/// [IssueCode.invalidUnion] issue holds the issues of every option.
final class UnionValidator<O extends Object?> extends Validator<O>
    with _Modifiers<Object, O, UnionValidator<O>> {
  UnionValidator._(super._spec, this._options, this._noMatch) : super._();

  final List<ValidatorReference<Object?>> _options;
  final _Check _noMatch;

  @override
  UnionValidator<O> _copy(_Spec spec) {
    return UnionValidator<O>._(spec, _options, _noMatch);
  }

  /// Returns a copy of this validator that rejects `null` and missing values.
  UnionValidator<Object> required({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return UnionValidator<Object>._(
      _spec.withRequired(message, messageBuilder),
      _options,
      _noMatch,
    );
  }

  @override
  bool get _nests => true;

  @override
  _Outcome _convert(Object value, _Context context) {
    final optionIssues = <List<ValidationIssue>>[];
    for (final option in _options) {
      final validator = option.resolve();
      final (output, issues) = validator._run(
        value,
        context.nested(fieldName: validator.name),
      );
      if (issues.isEmpty) return (output, const []);
      optionIssues.add(issues);
    }
    return (
      value,
      [
        _noMatch.issue(context, params: {'issues': optionIssues}),
      ],
    );
  }
}

/// Accepts only the values in a fixed list, compared with `==`. Created by
/// `l.oneOf()`.
///
/// [O] is `T?` until `.required()` makes it `T`. The output is the matching
/// allowed value, so `l.oneOf([1, 2])` turns an input of `1.0` into `1`.
final class OneOfValidator<T extends Object, O extends T?> extends Validator<O>
    with _Modifiers<T, O, OneOfValidator<T, O>> {
  OneOfValidator._(super._spec, this._values, this._notAllowed) : super._();

  final List<T> _values;
  final _Check _notAllowed;

  @override
  OneOfValidator<T, O> _copy(_Spec spec) {
    return OneOfValidator<T, O>._(spec, _values, _notAllowed);
  }

  /// Returns a copy of this validator that rejects `null` and missing values.
  OneOfValidator<T, T> required({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return OneOfValidator<T, T>._(
      _spec.withRequired(message, messageBuilder),
      _values,
      _notAllowed,
    );
  }

  @override
  _Outcome _convert(Object value, _Context context) {
    for (final allowed in _values) {
      if (allowed == value) return (allowed, const []);
    }
    return (value, [_notAllowed.issue(context)]);
  }
}
