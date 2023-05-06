// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SingleValidationResult<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> errors) error,
    required TResult Function(T data) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> errors)? error,
    TResult? Function(T data)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> errors)? error,
    TResult Function(T data)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SingleValidationResultError<T> value) error,
    required TResult Function(_SingleValidationResultSuccess<T> value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SingleValidationResultError<T> value)? error,
    TResult? Function(_SingleValidationResultSuccess<T> value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SingleValidationResultError<T> value)? error,
    TResult Function(_SingleValidationResultSuccess<T> value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SingleValidationResultCopyWith<T, $Res> {
  factory $SingleValidationResultCopyWith(SingleValidationResult<T> value,
          $Res Function(SingleValidationResult<T>) then) =
      _$SingleValidationResultCopyWithImpl<T, $Res, SingleValidationResult<T>>;
}

/// @nodoc
class _$SingleValidationResultCopyWithImpl<T, $Res,
        $Val extends SingleValidationResult<T>>
    implements $SingleValidationResultCopyWith<T, $Res> {
  _$SingleValidationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_SingleValidationResultErrorCopyWith<T, $Res> {
  factory _$$_SingleValidationResultErrorCopyWith(
          _$_SingleValidationResultError<T> value,
          $Res Function(_$_SingleValidationResultError<T>) then) =
      __$$_SingleValidationResultErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<String> errors});
}

/// @nodoc
class __$$_SingleValidationResultErrorCopyWithImpl<T, $Res>
    extends _$SingleValidationResultCopyWithImpl<T, $Res,
        _$_SingleValidationResultError<T>>
    implements _$$_SingleValidationResultErrorCopyWith<T, $Res> {
  __$$_SingleValidationResultErrorCopyWithImpl(
      _$_SingleValidationResultError<T> _value,
      $Res Function(_$_SingleValidationResultError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errors = null,
  }) {
    return _then(_$_SingleValidationResultError<T>(
      null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_SingleValidationResultError<T>
    extends _SingleValidationResultError<T> {
  const _$_SingleValidationResultError(final List<String> errors)
      : _errors = errors,
        super._();

  /// List of all errors from all validations.
  final List<String> _errors;

  /// List of all errors from all validations.
  @override
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  String toString() {
    return 'SingleValidationResult<$T>.error(errors: $errors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SingleValidationResultError<T> &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SingleValidationResultErrorCopyWith<T, _$_SingleValidationResultError<T>>
      get copyWith => __$$_SingleValidationResultErrorCopyWithImpl<T,
          _$_SingleValidationResultError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> errors) error,
    required TResult Function(T data) success,
  }) {
    return error(errors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> errors)? error,
    TResult? Function(T data)? success,
  }) {
    return error?.call(errors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> errors)? error,
    TResult Function(T data)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SingleValidationResultError<T> value) error,
    required TResult Function(_SingleValidationResultSuccess<T> value) success,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SingleValidationResultError<T> value)? error,
    TResult? Function(_SingleValidationResultSuccess<T> value)? success,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SingleValidationResultError<T> value)? error,
    TResult Function(_SingleValidationResultSuccess<T> value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _SingleValidationResultError<T>
    extends SingleValidationResult<T> {
  const factory _SingleValidationResultError(final List<String> errors) =
      _$_SingleValidationResultError<T>;
  const _SingleValidationResultError._() : super._();

  /// List of all errors from all validations.
  List<String> get errors;
  @JsonKey(ignore: true)
  _$$_SingleValidationResultErrorCopyWith<T, _$_SingleValidationResultError<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SingleValidationResultSuccessCopyWith<T, $Res> {
  factory _$$_SingleValidationResultSuccessCopyWith(
          _$_SingleValidationResultSuccess<T> value,
          $Res Function(_$_SingleValidationResultSuccess<T>) then) =
      __$$_SingleValidationResultSuccessCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$_SingleValidationResultSuccessCopyWithImpl<T, $Res>
    extends _$SingleValidationResultCopyWithImpl<T, $Res,
        _$_SingleValidationResultSuccess<T>>
    implements _$$_SingleValidationResultSuccessCopyWith<T, $Res> {
  __$$_SingleValidationResultSuccessCopyWithImpl(
      _$_SingleValidationResultSuccess<T> _value,
      $Res Function(_$_SingleValidationResultSuccess<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_SingleValidationResultSuccess<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_SingleValidationResultSuccess<T>
    extends _SingleValidationResultSuccess<T> {
  const _$_SingleValidationResultSuccess(this.data) : super._();

  /// The validated data (same as input data).
  @override
  final T data;

  @override
  String toString() {
    return 'SingleValidationResult<$T>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SingleValidationResultSuccess<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SingleValidationResultSuccessCopyWith<T,
          _$_SingleValidationResultSuccess<T>>
      get copyWith => __$$_SingleValidationResultSuccessCopyWithImpl<T,
          _$_SingleValidationResultSuccess<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> errors) error,
    required TResult Function(T data) success,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> errors)? error,
    TResult? Function(T data)? success,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> errors)? error,
    TResult Function(T data)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SingleValidationResultError<T> value) error,
    required TResult Function(_SingleValidationResultSuccess<T> value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SingleValidationResultError<T> value)? error,
    TResult? Function(_SingleValidationResultSuccess<T> value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SingleValidationResultError<T> value)? error,
    TResult Function(_SingleValidationResultSuccess<T> value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SingleValidationResultSuccess<T>
    extends SingleValidationResult<T> {
  const factory _SingleValidationResultSuccess(final T data) =
      _$_SingleValidationResultSuccess<T>;
  const _SingleValidationResultSuccess._() : super._();

  /// The validated data (same as input data).
  T get data;
  @JsonKey(ignore: true)
  _$$_SingleValidationResultSuccessCopyWith<T,
          _$_SingleValidationResultSuccess<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SchemaValidationResult<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> errors) error,
    required TResult Function(T data) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> errors)? error,
    TResult? Function(T data)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> errors)? error,
    TResult Function(T data)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SchemaValidationResultError<T> value) error,
    required TResult Function(_SchemaValidationResultSuccess<T> value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SchemaValidationResultError<T> value)? error,
    TResult? Function(_SchemaValidationResultSuccess<T> value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SchemaValidationResultError<T> value)? error,
    TResult Function(_SchemaValidationResultSuccess<T> value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchemaValidationResultCopyWith<T, $Res> {
  factory $SchemaValidationResultCopyWith(SchemaValidationResult<T> value,
          $Res Function(SchemaValidationResult<T>) then) =
      _$SchemaValidationResultCopyWithImpl<T, $Res, SchemaValidationResult<T>>;
}

/// @nodoc
class _$SchemaValidationResultCopyWithImpl<T, $Res,
        $Val extends SchemaValidationResult<T>>
    implements $SchemaValidationResultCopyWith<T, $Res> {
  _$SchemaValidationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_SchemaValidationResultErrorCopyWith<T, $Res> {
  factory _$$_SchemaValidationResultErrorCopyWith(
          _$_SchemaValidationResultError<T> value,
          $Res Function(_$_SchemaValidationResultError<T>) then) =
      __$$_SchemaValidationResultErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call({Map<String, dynamic> errors});
}

/// @nodoc
class __$$_SchemaValidationResultErrorCopyWithImpl<T, $Res>
    extends _$SchemaValidationResultCopyWithImpl<T, $Res,
        _$_SchemaValidationResultError<T>>
    implements _$$_SchemaValidationResultErrorCopyWith<T, $Res> {
  __$$_SchemaValidationResultErrorCopyWithImpl(
      _$_SchemaValidationResultError<T> _value,
      $Res Function(_$_SchemaValidationResultError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errors = null,
  }) {
    return _then(_$_SchemaValidationResultError<T>(
      null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$_SchemaValidationResultError<T>
    extends _SchemaValidationResultError<T> {
  const _$_SchemaValidationResultError(final Map<String, dynamic> errors)
      : _errors = errors,
        super._();

  /// Map of all errors from all validations.
  final Map<String, dynamic> _errors;

  /// Map of all errors from all validations.
  @override
  Map<String, dynamic> get errors {
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_errors);
  }

  @override
  String toString() {
    return 'SchemaValidationResult<$T>.error(errors: $errors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SchemaValidationResultError<T> &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SchemaValidationResultErrorCopyWith<T, _$_SchemaValidationResultError<T>>
      get copyWith => __$$_SchemaValidationResultErrorCopyWithImpl<T,
          _$_SchemaValidationResultError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> errors) error,
    required TResult Function(T data) success,
  }) {
    return error(errors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> errors)? error,
    TResult? Function(T data)? success,
  }) {
    return error?.call(errors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> errors)? error,
    TResult Function(T data)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SchemaValidationResultError<T> value) error,
    required TResult Function(_SchemaValidationResultSuccess<T> value) success,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SchemaValidationResultError<T> value)? error,
    TResult? Function(_SchemaValidationResultSuccess<T> value)? success,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SchemaValidationResultError<T> value)? error,
    TResult Function(_SchemaValidationResultSuccess<T> value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _SchemaValidationResultError<T>
    extends SchemaValidationResult<T> {
  const factory _SchemaValidationResultError(
      final Map<String, dynamic> errors) = _$_SchemaValidationResultError<T>;
  const _SchemaValidationResultError._() : super._();

  /// Map of all errors from all validations.
  Map<String, dynamic> get errors;
  @JsonKey(ignore: true)
  _$$_SchemaValidationResultErrorCopyWith<T, _$_SchemaValidationResultError<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SchemaValidationResultSuccessCopyWith<T, $Res> {
  factory _$$_SchemaValidationResultSuccessCopyWith(
          _$_SchemaValidationResultSuccess<T> value,
          $Res Function(_$_SchemaValidationResultSuccess<T>) then) =
      __$$_SchemaValidationResultSuccessCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$_SchemaValidationResultSuccessCopyWithImpl<T, $Res>
    extends _$SchemaValidationResultCopyWithImpl<T, $Res,
        _$_SchemaValidationResultSuccess<T>>
    implements _$$_SchemaValidationResultSuccessCopyWith<T, $Res> {
  __$$_SchemaValidationResultSuccessCopyWithImpl(
      _$_SchemaValidationResultSuccess<T> _value,
      $Res Function(_$_SchemaValidationResultSuccess<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_SchemaValidationResultSuccess<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_SchemaValidationResultSuccess<T>
    extends _SchemaValidationResultSuccess<T> {
  const _$_SchemaValidationResultSuccess(this.data) : super._();

  /// The validated data (same as input data).
  @override
  final T data;

  @override
  String toString() {
    return 'SchemaValidationResult<$T>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SchemaValidationResultSuccess<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SchemaValidationResultSuccessCopyWith<T,
          _$_SchemaValidationResultSuccess<T>>
      get copyWith => __$$_SchemaValidationResultSuccessCopyWithImpl<T,
          _$_SchemaValidationResultSuccess<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> errors) error,
    required TResult Function(T data) success,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> errors)? error,
    TResult? Function(T data)? success,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> errors)? error,
    TResult Function(T data)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SchemaValidationResultError<T> value) error,
    required TResult Function(_SchemaValidationResultSuccess<T> value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SchemaValidationResultError<T> value)? error,
    TResult? Function(_SchemaValidationResultSuccess<T> value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SchemaValidationResultError<T> value)? error,
    TResult Function(_SchemaValidationResultSuccess<T> value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SchemaValidationResultSuccess<T>
    extends SchemaValidationResult<T> {
  const factory _SchemaValidationResultSuccess(final T data) =
      _$_SchemaValidationResultSuccess<T>;
  const _SchemaValidationResultSuccess._() : super._();

  /// The validated data (same as input data).
  T get data;
  @JsonKey(ignore: true)
  _$$_SchemaValidationResultSuccessCopyWith<T,
          _$_SchemaValidationResultSuccess<T>>
      get copyWith => throw _privateConstructorUsedError;
}
