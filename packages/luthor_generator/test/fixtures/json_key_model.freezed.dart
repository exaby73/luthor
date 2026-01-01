// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'json_key_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JsonKeyModel {

@JsonKey(name: 'user_name') String get userName;@JsonKey(name: 'user_email')@IsEmail() String get userEmail; String get normalField;
/// Create a copy of JsonKeyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JsonKeyModelCopyWith<JsonKeyModel> get copyWith => _$JsonKeyModelCopyWithImpl<JsonKeyModel>(this as JsonKeyModel, _$identity);

  /// Serializes this JsonKeyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JsonKeyModel&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.normalField, normalField) || other.normalField == normalField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userName,userEmail,normalField);

@override
String toString() {
  return 'JsonKeyModel(userName: $userName, userEmail: $userEmail, normalField: $normalField)';
}


}

/// @nodoc
abstract mixin class $JsonKeyModelCopyWith<$Res>  {
  factory $JsonKeyModelCopyWith(JsonKeyModel value, $Res Function(JsonKeyModel) _then) = _$JsonKeyModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_name') String userName,@JsonKey(name: 'user_email')@IsEmail() String userEmail, String normalField
});




}
/// @nodoc
class _$JsonKeyModelCopyWithImpl<$Res>
    implements $JsonKeyModelCopyWith<$Res> {
  _$JsonKeyModelCopyWithImpl(this._self, this._then);

  final JsonKeyModel _self;
  final $Res Function(JsonKeyModel) _then;

/// Create a copy of JsonKeyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userName = null,Object? userEmail = null,Object? normalField = null,}) {
  return _then(_self.copyWith(
userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,normalField: null == normalField ? _self.normalField : normalField // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JsonKeyModel].
extension JsonKeyModelPatterns on JsonKeyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JsonKeyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JsonKeyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JsonKeyModel value)  $default,){
final _that = this;
switch (_that) {
case _JsonKeyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JsonKeyModel value)?  $default,){
final _that = this;
switch (_that) {
case _JsonKeyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_name')  String userName, @JsonKey(name: 'user_email')@IsEmail()  String userEmail,  String normalField)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JsonKeyModel() when $default != null:
return $default(_that.userName,_that.userEmail,_that.normalField);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_name')  String userName, @JsonKey(name: 'user_email')@IsEmail()  String userEmail,  String normalField)  $default,) {final _that = this;
switch (_that) {
case _JsonKeyModel():
return $default(_that.userName,_that.userEmail,_that.normalField);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_name')  String userName, @JsonKey(name: 'user_email')@IsEmail()  String userEmail,  String normalField)?  $default,) {final _that = this;
switch (_that) {
case _JsonKeyModel() when $default != null:
return $default(_that.userName,_that.userEmail,_that.normalField);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JsonKeyModel implements JsonKeyModel {
  const _JsonKeyModel({@JsonKey(name: 'user_name') required this.userName, @JsonKey(name: 'user_email')@IsEmail() required this.userEmail, required this.normalField});
  factory _JsonKeyModel.fromJson(Map<String, dynamic> json) => _$JsonKeyModelFromJson(json);

@override@JsonKey(name: 'user_name') final  String userName;
@override@JsonKey(name: 'user_email')@IsEmail() final  String userEmail;
@override final  String normalField;

/// Create a copy of JsonKeyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JsonKeyModelCopyWith<_JsonKeyModel> get copyWith => __$JsonKeyModelCopyWithImpl<_JsonKeyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JsonKeyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JsonKeyModel&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.normalField, normalField) || other.normalField == normalField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userName,userEmail,normalField);

@override
String toString() {
  return 'JsonKeyModel(userName: $userName, userEmail: $userEmail, normalField: $normalField)';
}


}

/// @nodoc
abstract mixin class _$JsonKeyModelCopyWith<$Res> implements $JsonKeyModelCopyWith<$Res> {
  factory _$JsonKeyModelCopyWith(_JsonKeyModel value, $Res Function(_JsonKeyModel) _then) = __$JsonKeyModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_name') String userName,@JsonKey(name: 'user_email')@IsEmail() String userEmail, String normalField
});




}
/// @nodoc
class __$JsonKeyModelCopyWithImpl<$Res>
    implements _$JsonKeyModelCopyWith<$Res> {
  __$JsonKeyModelCopyWithImpl(this._self, this._then);

  final _JsonKeyModel _self;
  final $Res Function(_JsonKeyModel) _then;

/// Create a copy of JsonKeyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userName = null,Object? userEmail = null,Object? normalField = null,}) {
  return _then(_JsonKeyModel(
userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,normalField: null == normalField ? _self.normalField : normalField // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
