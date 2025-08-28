// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

 int get id;@JsonKey(name: 'full_name') String? get name;@IsEmail(message: "Invalid email") String get email;@IsIp(version: IpVersion.v4) String? get ip;@HasMin(8) String get password; String get type;@IsUrl(allowedSchemes: ['http', 'https']) String? get url;
/// Create a copy of AnotherSample
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnotherSampleCopyWith<AnotherSample> get copyWith => _$AnotherSampleCopyWithImpl<AnotherSample>(this as AnotherSample, _$identity);

  /// Serializes this AnotherSample to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnotherSample&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.password, password) || other.password == password)&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,ip,password,type,url);

@override
String toString() {
  return 'AnotherSample(id: $id, name: $name, email: $email, ip: $ip, password: $password, type: $type, url: $url)';
}


}

/// @nodoc
abstract mixin class $AnotherSampleCopyWith<$Res>  {
  factory $AnotherSampleCopyWith(AnotherSample value, $Res Function(AnotherSample) _then) = _$AnotherSampleCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'full_name') String? name,@IsEmail(message: "Invalid email") String email,@IsIp(version: IpVersion.v4) String? ip,@HasMin(8) String password, String type,@IsUrl(allowedSchemes: ['http', 'https']) String? url
});




}
/// @nodoc
class _$AnotherSampleCopyWithImpl<$Res>
    implements $AnotherSampleCopyWith<$Res> {
  _$AnotherSampleCopyWithImpl(this._self, this._then);

  final AnotherSample _self;
  final $Res Function(AnotherSample) _then;

/// Create a copy of AnotherSample
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? email = null,Object? ip = freezed,Object? password = null,Object? type = null,Object? url = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,ip: freezed == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String?,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AnotherSample].
extension AnotherSamplePatterns on AnotherSample {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnotherSample value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnotherSample() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnotherSample value)  $default,){
final _that = this;
switch (_that) {
case _AnotherSample():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnotherSample value)?  $default,){
final _that = this;
switch (_that) {
case _AnotherSample() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'full_name')  String? name, @IsEmail(message: "Invalid email")  String email, @IsIp(version: IpVersion.v4)  String? ip, @HasMin(8)  String password,  String type, @IsUrl(allowedSchemes: ['http', 'https'])  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnotherSample() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.ip,_that.password,_that.type,_that.url);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'full_name')  String? name, @IsEmail(message: "Invalid email")  String email, @IsIp(version: IpVersion.v4)  String? ip, @HasMin(8)  String password,  String type, @IsUrl(allowedSchemes: ['http', 'https'])  String? url)  $default,) {final _that = this;
switch (_that) {
case _AnotherSample():
return $default(_that.id,_that.name,_that.email,_that.ip,_that.password,_that.type,_that.url);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'full_name')  String? name, @IsEmail(message: "Invalid email")  String email, @IsIp(version: IpVersion.v4)  String? ip, @HasMin(8)  String password,  String type, @IsUrl(allowedSchemes: ['http', 'https'])  String? url)?  $default,) {final _that = this;
switch (_that) {
case _AnotherSample() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.ip,_that.password,_that.type,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnotherSample implements AnotherSample {
  const _AnotherSample({required this.id, @JsonKey(name: 'full_name') this.name, @IsEmail(message: "Invalid email") required this.email, @IsIp(version: IpVersion.v4) this.ip, @HasMin(8) required this.password, this.type = 'user', @IsUrl(allowedSchemes: ['http', 'https']) this.url});
  factory _AnotherSample.fromJson(Map<String, dynamic> json) => _$AnotherSampleFromJson(json);

@override final  int id;
@override@JsonKey(name: 'full_name') final  String? name;
@override@IsEmail(message: "Invalid email") final  String email;
@override@IsIp(version: IpVersion.v4) final  String? ip;
@override@HasMin(8) final  String password;
@override@JsonKey() final  String type;
@override@IsUrl(allowedSchemes: ['http', 'https']) final  String? url;

/// Create a copy of AnotherSample
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnotherSampleCopyWith<_AnotherSample> get copyWith => __$AnotherSampleCopyWithImpl<_AnotherSample>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnotherSampleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnotherSample&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.password, password) || other.password == password)&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,ip,password,type,url);

@override
String toString() {
  return 'AnotherSample(id: $id, name: $name, email: $email, ip: $ip, password: $password, type: $type, url: $url)';
}


}

/// @nodoc
abstract mixin class _$AnotherSampleCopyWith<$Res> implements $AnotherSampleCopyWith<$Res> {
  factory _$AnotherSampleCopyWith(_AnotherSample value, $Res Function(_AnotherSample) _then) = __$AnotherSampleCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'full_name') String? name,@IsEmail(message: "Invalid email") String email,@IsIp(version: IpVersion.v4) String? ip,@HasMin(8) String password, String type,@IsUrl(allowedSchemes: ['http', 'https']) String? url
});




}
/// @nodoc
class __$AnotherSampleCopyWithImpl<$Res>
    implements _$AnotherSampleCopyWith<$Res> {
  __$AnotherSampleCopyWithImpl(this._self, this._then);

  final _AnotherSample _self;
  final $Res Function(_AnotherSample) _then;

/// Create a copy of AnotherSample
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? email = null,Object? ip = freezed,Object? password = null,Object? type = null,Object? url = freezed,}) {
  return _then(_AnotherSample(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,ip: freezed == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String?,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
