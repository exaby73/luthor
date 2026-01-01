// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'annotated_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnnotatedModel {

@IsEmail() String get email;@HasMin(8)@HasMax(100) String get password;@HasMin(18)@HasMax(120) int get age;@HasMinDouble(0.0)@HasMaxDouble(100.0) double get score;@StartsWith('https://') String? get website;@EndsWith('.com') String? get domain;@Contains('test') String? get testField;@IsUuid() String get uuid;
/// Create a copy of AnnotatedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnotatedModelCopyWith<AnnotatedModel> get copyWith => _$AnnotatedModelCopyWithImpl<AnnotatedModel>(this as AnnotatedModel, _$identity);

  /// Serializes this AnnotatedModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotatedModel&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.age, age) || other.age == age)&&(identical(other.score, score) || other.score == score)&&(identical(other.website, website) || other.website == website)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.testField, testField) || other.testField == testField)&&(identical(other.uuid, uuid) || other.uuid == uuid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,age,score,website,domain,testField,uuid);

@override
String toString() {
  return 'AnnotatedModel(email: $email, password: $password, age: $age, score: $score, website: $website, domain: $domain, testField: $testField, uuid: $uuid)';
}


}

/// @nodoc
abstract mixin class $AnnotatedModelCopyWith<$Res>  {
  factory $AnnotatedModelCopyWith(AnnotatedModel value, $Res Function(AnnotatedModel) _then) = _$AnnotatedModelCopyWithImpl;
@useResult
$Res call({
@IsEmail() String email,@HasMin(8)@HasMax(100) String password,@HasMin(18)@HasMax(120) int age,@HasMinDouble(0.0)@HasMaxDouble(100.0) double score,@StartsWith('https://') String? website,@EndsWith('.com') String? domain,@Contains('test') String? testField,@IsUuid() String uuid
});




}
/// @nodoc
class _$AnnotatedModelCopyWithImpl<$Res>
    implements $AnnotatedModelCopyWith<$Res> {
  _$AnnotatedModelCopyWithImpl(this._self, this._then);

  final AnnotatedModel _self;
  final $Res Function(AnnotatedModel) _then;

/// Create a copy of AnnotatedModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? age = null,Object? score = null,Object? website = freezed,Object? domain = freezed,Object? testField = freezed,Object? uuid = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,domain: freezed == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String?,testField: freezed == testField ? _self.testField : testField // ignore: cast_nullable_to_non_nullable
as String?,uuid: null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AnnotatedModel].
extension AnnotatedModelPatterns on AnnotatedModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnnotatedModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnnotatedModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnnotatedModel value)  $default,){
final _that = this;
switch (_that) {
case _AnnotatedModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnnotatedModel value)?  $default,){
final _that = this;
switch (_that) {
case _AnnotatedModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IsEmail()  String email, @HasMin(8)@HasMax(100)  String password, @HasMin(18)@HasMax(120)  int age, @HasMinDouble(0.0)@HasMaxDouble(100.0)  double score, @StartsWith('https://')  String? website, @EndsWith('.com')  String? domain, @Contains('test')  String? testField, @IsUuid()  String uuid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnnotatedModel() when $default != null:
return $default(_that.email,_that.password,_that.age,_that.score,_that.website,_that.domain,_that.testField,_that.uuid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IsEmail()  String email, @HasMin(8)@HasMax(100)  String password, @HasMin(18)@HasMax(120)  int age, @HasMinDouble(0.0)@HasMaxDouble(100.0)  double score, @StartsWith('https://')  String? website, @EndsWith('.com')  String? domain, @Contains('test')  String? testField, @IsUuid()  String uuid)  $default,) {final _that = this;
switch (_that) {
case _AnnotatedModel():
return $default(_that.email,_that.password,_that.age,_that.score,_that.website,_that.domain,_that.testField,_that.uuid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IsEmail()  String email, @HasMin(8)@HasMax(100)  String password, @HasMin(18)@HasMax(120)  int age, @HasMinDouble(0.0)@HasMaxDouble(100.0)  double score, @StartsWith('https://')  String? website, @EndsWith('.com')  String? domain, @Contains('test')  String? testField, @IsUuid()  String uuid)?  $default,) {final _that = this;
switch (_that) {
case _AnnotatedModel() when $default != null:
return $default(_that.email,_that.password,_that.age,_that.score,_that.website,_that.domain,_that.testField,_that.uuid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnnotatedModel implements AnnotatedModel {
  const _AnnotatedModel({@IsEmail() required this.email, @HasMin(8)@HasMax(100) required this.password, @HasMin(18)@HasMax(120) required this.age, @HasMinDouble(0.0)@HasMaxDouble(100.0) required this.score, @StartsWith('https://') this.website, @EndsWith('.com') this.domain, @Contains('test') this.testField, @IsUuid() required this.uuid});
  factory _AnnotatedModel.fromJson(Map<String, dynamic> json) => _$AnnotatedModelFromJson(json);

@override@IsEmail() final  String email;
@override@HasMin(8)@HasMax(100) final  String password;
@override@HasMin(18)@HasMax(120) final  int age;
@override@HasMinDouble(0.0)@HasMaxDouble(100.0) final  double score;
@override@StartsWith('https://') final  String? website;
@override@EndsWith('.com') final  String? domain;
@override@Contains('test') final  String? testField;
@override@IsUuid() final  String uuid;

/// Create a copy of AnnotatedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnotatedModelCopyWith<_AnnotatedModel> get copyWith => __$AnnotatedModelCopyWithImpl<_AnnotatedModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnotatedModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnotatedModel&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.age, age) || other.age == age)&&(identical(other.score, score) || other.score == score)&&(identical(other.website, website) || other.website == website)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.testField, testField) || other.testField == testField)&&(identical(other.uuid, uuid) || other.uuid == uuid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,age,score,website,domain,testField,uuid);

@override
String toString() {
  return 'AnnotatedModel(email: $email, password: $password, age: $age, score: $score, website: $website, domain: $domain, testField: $testField, uuid: $uuid)';
}


}

/// @nodoc
abstract mixin class _$AnnotatedModelCopyWith<$Res> implements $AnnotatedModelCopyWith<$Res> {
  factory _$AnnotatedModelCopyWith(_AnnotatedModel value, $Res Function(_AnnotatedModel) _then) = __$AnnotatedModelCopyWithImpl;
@override @useResult
$Res call({
@IsEmail() String email,@HasMin(8)@HasMax(100) String password,@HasMin(18)@HasMax(120) int age,@HasMinDouble(0.0)@HasMaxDouble(100.0) double score,@StartsWith('https://') String? website,@EndsWith('.com') String? domain,@Contains('test') String? testField,@IsUuid() String uuid
});




}
/// @nodoc
class __$AnnotatedModelCopyWithImpl<$Res>
    implements _$AnnotatedModelCopyWith<$Res> {
  __$AnnotatedModelCopyWithImpl(this._self, this._then);

  final _AnnotatedModel _self;
  final $Res Function(_AnnotatedModel) _then;

/// Create a copy of AnnotatedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? age = null,Object? score = null,Object? website = freezed,Object? domain = freezed,Object? testField = freezed,Object? uuid = null,}) {
  return _then(_AnnotatedModel(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,domain: freezed == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String?,testField: freezed == testField ? _self.testField : testField // ignore: cast_nullable_to_non_nullable
as String?,uuid: null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
