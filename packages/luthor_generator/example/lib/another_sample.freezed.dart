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
  @IsIp(version: IpVersion.v4)
  String? get ip => throw _privateConstructorUsedError;
  @HasMin(8)
  String get password => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @IsUrl(allowedSchemes: ['http', 'https'])
  String? get url => throw _privateConstructorUsedError;
  Sample get sample => throw _privateConstructorUsedError;
  Sample? get optionalSample => throw _privateConstructorUsedError;

  /// Serializes this AnotherSample to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      @IsIp(version: IpVersion.v4) String? ip,
      @HasMin(8) String password,
      String type,
      @IsUrl(allowedSchemes: ['http', 'https']) String? url,
      Sample sample,
      Sample? optionalSample});

  $SampleCopyWith<$Res> get sample;
  $SampleCopyWith<$Res>? get optionalSample;
}

/// @nodoc
class _$AnotherSampleCopyWithImpl<$Res, $Val extends AnotherSample>
    implements $AnotherSampleCopyWith<$Res> {
  _$AnotherSampleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? email = null,
    Object? ip = freezed,
    Object? password = null,
    Object? type = null,
    Object? url = freezed,
    Object? sample = null,
    Object? optionalSample = freezed,
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
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      sample: null == sample
          ? _value.sample
          : sample // ignore: cast_nullable_to_non_nullable
              as Sample,
      optionalSample: freezed == optionalSample
          ? _value.optionalSample
          : optionalSample // ignore: cast_nullable_to_non_nullable
              as Sample?,
    ) as $Val);
  }

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SampleCopyWith<$Res> get sample {
    return $SampleCopyWith<$Res>(_value.sample, (value) {
      return _then(_value.copyWith(sample: value) as $Val);
    });
  }

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SampleCopyWith<$Res>? get optionalSample {
    if (_value.optionalSample == null) {
      return null;
    }

    return $SampleCopyWith<$Res>(_value.optionalSample!, (value) {
      return _then(_value.copyWith(optionalSample: value) as $Val);
    });
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
      @IsIp(version: IpVersion.v4) String? ip,
      @HasMin(8) String password,
      String type,
      @IsUrl(allowedSchemes: ['http', 'https']) String? url,
      Sample sample,
      Sample? optionalSample});

  @override
  $SampleCopyWith<$Res> get sample;
  @override
  $SampleCopyWith<$Res>? get optionalSample;
}

/// @nodoc
class __$$AnotherSampleImplCopyWithImpl<$Res>
    extends _$AnotherSampleCopyWithImpl<$Res, _$AnotherSampleImpl>
    implements _$$AnotherSampleImplCopyWith<$Res> {
  __$$AnotherSampleImplCopyWithImpl(
      _$AnotherSampleImpl _value, $Res Function(_$AnotherSampleImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? email = null,
    Object? ip = freezed,
    Object? password = null,
    Object? type = null,
    Object? url = freezed,
    Object? sample = null,
    Object? optionalSample = freezed,
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
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      sample: null == sample
          ? _value.sample
          : sample // ignore: cast_nullable_to_non_nullable
              as Sample,
      optionalSample: freezed == optionalSample
          ? _value.optionalSample
          : optionalSample // ignore: cast_nullable_to_non_nullable
              as Sample?,
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
      @IsIp(version: IpVersion.v4) this.ip,
      @HasMin(8) required this.password,
      this.type = 'user',
      @IsUrl(allowedSchemes: ['http', 'https']) this.url,
      required this.sample,
      this.optionalSample});

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
  @IsIp(version: IpVersion.v4)
  final String? ip;
  @override
  @HasMin(8)
  final String password;
  @override
  @JsonKey()
  final String type;
  @override
  @IsUrl(allowedSchemes: ['http', 'https'])
  final String? url;
  @override
  final Sample sample;
  @override
  final Sample? optionalSample;

  @override
  String toString() {
    return 'AnotherSample(id: $id, name: $name, email: $email, ip: $ip, password: $password, type: $type, url: $url, sample: $sample, optionalSample: $optionalSample)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnotherSampleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.sample, sample) || other.sample == sample) &&
            (identical(other.optionalSample, optionalSample) ||
                other.optionalSample == optionalSample));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, ip, password,
      type, url, sample, optionalSample);

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      @IsIp(version: IpVersion.v4) final String? ip,
      @HasMin(8) required final String password,
      final String type,
      @IsUrl(allowedSchemes: ['http', 'https']) final String? url,
      required final Sample sample,
      final Sample? optionalSample}) = _$AnotherSampleImpl;

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
  @IsIp(version: IpVersion.v4)
  String? get ip;
  @override
  @HasMin(8)
  String get password;
  @override
  String get type;
  @override
  @IsUrl(allowedSchemes: ['http', 'https'])
  String? get url;
  @override
  Sample get sample;
  @override
  Sample? get optionalSample;

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnotherSampleImplCopyWith<_$AnotherSampleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
