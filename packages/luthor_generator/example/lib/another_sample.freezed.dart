// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'another_sample.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnotherSample {
  int get id;
  @JsonKey(name: 'full_name')
  String? get name;
  @IsEmail(message: "Invalid email")
  String get email;
  @IsIp(version: IpVersion.v4)
  String? get ip;
  @HasMin(8)
  String get password;
  String get type;
  @IsUrl(allowedSchemes: ['http', 'https'])
  String? get url;
  Sample get sample;
  Sample? get optionalSample;

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AnotherSampleCopyWith<AnotherSample> get copyWith =>
      _$AnotherSampleCopyWithImpl<AnotherSample>(
          this as AnotherSample, _$identity);

  /// Serializes this AnotherSample to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AnotherSample &&
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

  @override
  String toString() {
    return 'AnotherSample(id: $id, name: $name, email: $email, ip: $ip, password: $password, type: $type, url: $url, sample: $sample, optionalSample: $optionalSample)';
  }
}

/// @nodoc
abstract mixin class $AnotherSampleCopyWith<$Res> {
  factory $AnotherSampleCopyWith(
          AnotherSample value, $Res Function(AnotherSample) _then) =
      _$AnotherSampleCopyWithImpl;
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
class _$AnotherSampleCopyWithImpl<$Res>
    implements $AnotherSampleCopyWith<$Res> {
  _$AnotherSampleCopyWithImpl(this._self, this._then);

  final AnotherSample _self;
  final $Res Function(AnotherSample) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      ip: freezed == ip
          ? _self.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      sample: null == sample
          ? _self.sample
          : sample // ignore: cast_nullable_to_non_nullable
              as Sample,
      optionalSample: freezed == optionalSample
          ? _self.optionalSample
          : optionalSample // ignore: cast_nullable_to_non_nullable
              as Sample?,
    ));
  }

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SampleCopyWith<$Res> get sample {
    return $SampleCopyWith<$Res>(_self.sample, (value) {
      return _then(_self.copyWith(sample: value));
    });
  }

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SampleCopyWith<$Res>? get optionalSample {
    if (_self.optionalSample == null) {
      return null;
    }

    return $SampleCopyWith<$Res>(_self.optionalSample!, (value) {
      return _then(_self.copyWith(optionalSample: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _AnotherSample implements AnotherSample {
  const _AnotherSample(
      {required this.id,
      @JsonKey(name: 'full_name') this.name,
      @IsEmail(message: "Invalid email") required this.email,
      @IsIp(version: IpVersion.v4) this.ip,
      @HasMin(8) required this.password,
      this.type = 'user',
      @IsUrl(allowedSchemes: ['http', 'https']) this.url,
      required this.sample,
      this.optionalSample});
  factory _AnotherSample.fromJson(Map<String, dynamic> json) =>
      _$AnotherSampleFromJson(json);

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

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AnotherSampleCopyWith<_AnotherSample> get copyWith =>
      __$AnotherSampleCopyWithImpl<_AnotherSample>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AnotherSampleToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AnotherSample &&
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

  @override
  String toString() {
    return 'AnotherSample(id: $id, name: $name, email: $email, ip: $ip, password: $password, type: $type, url: $url, sample: $sample, optionalSample: $optionalSample)';
  }
}

/// @nodoc
abstract mixin class _$AnotherSampleCopyWith<$Res>
    implements $AnotherSampleCopyWith<$Res> {
  factory _$AnotherSampleCopyWith(
          _AnotherSample value, $Res Function(_AnotherSample) _then) =
      __$AnotherSampleCopyWithImpl;
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
class __$AnotherSampleCopyWithImpl<$Res>
    implements _$AnotherSampleCopyWith<$Res> {
  __$AnotherSampleCopyWithImpl(this._self, this._then);

  final _AnotherSample _self;
  final $Res Function(_AnotherSample) _then;

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_AnotherSample(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      ip: freezed == ip
          ? _self.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      sample: null == sample
          ? _self.sample
          : sample // ignore: cast_nullable_to_non_nullable
              as Sample,
      optionalSample: freezed == optionalSample
          ? _self.optionalSample
          : optionalSample // ignore: cast_nullable_to_non_nullable
              as Sample?,
    ));
  }

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SampleCopyWith<$Res> get sample {
    return $SampleCopyWith<$Res>(_self.sample, (value) {
      return _then(_self.copyWith(sample: value));
    });
  }

  /// Create a copy of AnotherSample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SampleCopyWith<$Res>? get optionalSample {
    if (_self.optionalSample == null) {
      return null;
    }

    return $SampleCopyWith<$Res>(_self.optionalSample!, (value) {
      return _then(_self.copyWith(optionalSample: value));
    });
  }
}

// dart format on
