// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'another_sample.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AnotherSample _$AnotherSampleFromJson(Map<String, dynamic> json) {
  return _AnotherSample.fromJson(json);
}

/// @nodoc
mixin _$AnotherSample {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String? get name => throw _privateConstructorUsedError;
  @IsEmail(message: "Invalid email")
  String get email => throw _privateConstructorUsedError;
  @HasMin(8)
  String get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnotherSampleCopyWith<AnotherSample> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnotherSampleCopyWith<$Res> {
  factory $AnotherSampleCopyWith(
          AnotherSample value, $Res Function(AnotherSample) then) =
      _$AnotherSampleCopyWithImpl<$Res, AnotherSample>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'full_name') String? name,
      @IsEmail(message: "Invalid email") String email,
      @HasMin(8) String password});
}

/// @nodoc
class _$AnotherSampleCopyWithImpl<$Res, $Val extends AnotherSample>
    implements $AnotherSampleCopyWith<$Res> {
  _$AnotherSampleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnotherSampleImplCopyWith<$Res>
    implements $AnotherSampleCopyWith<$Res> {
  factory _$$AnotherSampleImplCopyWith(
          _$AnotherSampleImpl value, $Res Function(_$AnotherSampleImpl) then) =
      __$$AnotherSampleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'full_name') String? name,
      @IsEmail(message: "Invalid email") String email,
      @HasMin(8) String password});
}

/// @nodoc
class __$$AnotherSampleImplCopyWithImpl<$Res>
    extends _$AnotherSampleCopyWithImpl<$Res, _$AnotherSampleImpl>
    implements _$$AnotherSampleImplCopyWith<$Res> {
  __$$AnotherSampleImplCopyWithImpl(
      _$AnotherSampleImpl _value, $Res Function(_$AnotherSampleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$AnotherSampleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnotherSampleImpl implements _AnotherSample {
  const _$AnotherSampleImpl(
      {required this.id,
      @JsonKey(name: 'full_name') this.name,
      @IsEmail(message: "Invalid email") required this.email,
      @HasMin(8) required this.password});

  factory _$AnotherSampleImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnotherSampleImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'full_name')
  final String? name;
  @override
  @IsEmail(message: "Invalid email")
  final String email;
  @override
  @HasMin(8)
  final String password;

  @override
  String toString() {
    return 'AnotherSample(id: $id, name: $name, email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnotherSampleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnotherSampleImplCopyWith<_$AnotherSampleImpl> get copyWith =>
      __$$AnotherSampleImplCopyWithImpl<_$AnotherSampleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnotherSampleImplToJson(
      this,
    );
  }
}

abstract class _AnotherSample implements AnotherSample {
  const factory _AnotherSample(
      {required final int id,
      @JsonKey(name: 'full_name') final String? name,
      @IsEmail(message: "Invalid email") required final String email,
      @HasMin(8) required final String password}) = _$AnotherSampleImpl;

  factory _AnotherSample.fromJson(Map<String, dynamic> json) =
      _$AnotherSampleImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'full_name')
  String? get name;
  @override
  @IsEmail(message: "Invalid email")
  String get email;
  @override
  @HasMin(8)
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$AnotherSampleImplCopyWith<_$AnotherSampleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
