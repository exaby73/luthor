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
mixin _$ValidationResult<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function(T data) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function(T data)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function(T data)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ValidationResultError<T> value) error,
    required TResult Function(_ValidationResultSuccess<T> value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ValidationResultError<T> value)? error,
    TResult? Function(_ValidationResultSuccess<T> value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ValidationResultError<T> value)? error,
    TResult Function(_ValidationResultSuccess<T> value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationResultCopyWith<T, $Res> {
  factory $ValidationResultCopyWith(
          ValidationResult<T> value, $Res Function(ValidationResult<T>) then) =
      _$ValidationResultCopyWithImpl<T, $Res, ValidationResult<T>>;
}

/// @nodoc
class _$ValidationResultCopyWithImpl<T, $Res, $Val extends ValidationResult<T>>
    implements $ValidationResultCopyWith<T, $Res> {
  _$ValidationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_ValidationResultErrorCopyWith<T, $Res> {
  factory _$$_ValidationResultErrorCopyWith(_$_ValidationResultError<T> value,
          $Res Function(_$_ValidationResultError<T>) then) =
      __$$_ValidationResultErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_ValidationResultErrorCopyWithImpl<T, $Res>
    extends _$ValidationResultCopyWithImpl<T, $Res, _$_ValidationResultError<T>>
    implements _$$_ValidationResultErrorCopyWith<T, $Res> {
  __$$_ValidationResultErrorCopyWithImpl(_$_ValidationResultError<T> _value,
      $Res Function(_$_ValidationResultError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_ValidationResultError<T>(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ValidationResultError<T> extends _ValidationResultError<T> {
  const _$_ValidationResultError(this.message) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'ValidationResult<$T>.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ValidationResultError<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ValidationResultErrorCopyWith<T, _$_ValidationResultError<T>>
      get copyWith => __$$_ValidationResultErrorCopyWithImpl<T,
          _$_ValidationResultError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function(T data) success,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function(T data)? success,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function(T data)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ValidationResultError<T> value) error,
    required TResult Function(_ValidationResultSuccess<T> value) success,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ValidationResultError<T> value)? error,
    TResult? Function(_ValidationResultSuccess<T> value)? success,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ValidationResultError<T> value)? error,
    TResult Function(_ValidationResultSuccess<T> value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ValidationResultError<T> extends ValidationResult<T> {
  const factory _ValidationResultError(final String message) =
      _$_ValidationResultError<T>;
  const _ValidationResultError._() : super._();

  String get message;
  @JsonKey(ignore: true)
  _$$_ValidationResultErrorCopyWith<T, _$_ValidationResultError<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ValidationResultSuccessCopyWith<T, $Res> {
  factory _$$_ValidationResultSuccessCopyWith(
          _$_ValidationResultSuccess<T> value,
          $Res Function(_$_ValidationResultSuccess<T>) then) =
      __$$_ValidationResultSuccessCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$_ValidationResultSuccessCopyWithImpl<T, $Res>
    extends _$ValidationResultCopyWithImpl<T, $Res,
        _$_ValidationResultSuccess<T>>
    implements _$$_ValidationResultSuccessCopyWith<T, $Res> {
  __$$_ValidationResultSuccessCopyWithImpl(_$_ValidationResultSuccess<T> _value,
      $Res Function(_$_ValidationResultSuccess<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_ValidationResultSuccess<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_ValidationResultSuccess<T> extends _ValidationResultSuccess<T> {
  const _$_ValidationResultSuccess(this.data) : super._();

  @override
  final T data;

  @override
  String toString() {
    return 'ValidationResult<$T>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ValidationResultSuccess<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ValidationResultSuccessCopyWith<T, _$_ValidationResultSuccess<T>>
      get copyWith => __$$_ValidationResultSuccessCopyWithImpl<T,
          _$_ValidationResultSuccess<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function(T data) success,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function(T data)? success,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
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
    required TResult Function(_ValidationResultError<T> value) error,
    required TResult Function(_ValidationResultSuccess<T> value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ValidationResultError<T> value)? error,
    TResult? Function(_ValidationResultSuccess<T> value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ValidationResultError<T> value)? error,
    TResult Function(_ValidationResultSuccess<T> value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _ValidationResultSuccess<T> extends ValidationResult<T> {
  const factory _ValidationResultSuccess(final T data) =
      _$_ValidationResultSuccess<T>;
  const _ValidationResultSuccess._() : super._();

  T get data;
  @JsonKey(ignore: true)
  _$$_ValidationResultSuccessCopyWith<T, _$_ValidationResultSuccess<T>>
      get copyWith => throw _privateConstructorUsedError;
}
