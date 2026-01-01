// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nested_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NestedModel {

 String get id; SimpleModel get user; SimpleModel? get optionalUser;
/// Create a copy of NestedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NestedModelCopyWith<NestedModel> get copyWith => _$NestedModelCopyWithImpl<NestedModel>(this as NestedModel, _$identity);

  /// Serializes this NestedModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NestedModel&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.optionalUser, optionalUser) || other.optionalUser == optionalUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user,optionalUser);

@override
String toString() {
  return 'NestedModel(id: $id, user: $user, optionalUser: $optionalUser)';
}


}

/// @nodoc
abstract mixin class $NestedModelCopyWith<$Res>  {
  factory $NestedModelCopyWith(NestedModel value, $Res Function(NestedModel) _then) = _$NestedModelCopyWithImpl;
@useResult
$Res call({
 String id, SimpleModel user, SimpleModel? optionalUser
});


$SimpleModelCopyWith<$Res> get user;$SimpleModelCopyWith<$Res>? get optionalUser;

}
/// @nodoc
class _$NestedModelCopyWithImpl<$Res>
    implements $NestedModelCopyWith<$Res> {
  _$NestedModelCopyWithImpl(this._self, this._then);

  final NestedModel _self;
  final $Res Function(NestedModel) _then;

/// Create a copy of NestedModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? user = null,Object? optionalUser = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as SimpleModel,optionalUser: freezed == optionalUser ? _self.optionalUser : optionalUser // ignore: cast_nullable_to_non_nullable
as SimpleModel?,
  ));
}
/// Create a copy of NestedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SimpleModelCopyWith<$Res> get user {
  
  return $SimpleModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of NestedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SimpleModelCopyWith<$Res>? get optionalUser {
    if (_self.optionalUser == null) {
    return null;
  }

  return $SimpleModelCopyWith<$Res>(_self.optionalUser!, (value) {
    return _then(_self.copyWith(optionalUser: value));
  });
}
}


/// Adds pattern-matching-related methods to [NestedModel].
extension NestedModelPatterns on NestedModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NestedModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NestedModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NestedModel value)  $default,){
final _that = this;
switch (_that) {
case _NestedModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NestedModel value)?  $default,){
final _that = this;
switch (_that) {
case _NestedModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  SimpleModel user,  SimpleModel? optionalUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NestedModel() when $default != null:
return $default(_that.id,_that.user,_that.optionalUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  SimpleModel user,  SimpleModel? optionalUser)  $default,) {final _that = this;
switch (_that) {
case _NestedModel():
return $default(_that.id,_that.user,_that.optionalUser);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  SimpleModel user,  SimpleModel? optionalUser)?  $default,) {final _that = this;
switch (_that) {
case _NestedModel() when $default != null:
return $default(_that.id,_that.user,_that.optionalUser);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NestedModel implements NestedModel {
  const _NestedModel({required this.id, required this.user, this.optionalUser});
  factory _NestedModel.fromJson(Map<String, dynamic> json) => _$NestedModelFromJson(json);

@override final  String id;
@override final  SimpleModel user;
@override final  SimpleModel? optionalUser;

/// Create a copy of NestedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NestedModelCopyWith<_NestedModel> get copyWith => __$NestedModelCopyWithImpl<_NestedModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NestedModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NestedModel&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.optionalUser, optionalUser) || other.optionalUser == optionalUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user,optionalUser);

@override
String toString() {
  return 'NestedModel(id: $id, user: $user, optionalUser: $optionalUser)';
}


}

/// @nodoc
abstract mixin class _$NestedModelCopyWith<$Res> implements $NestedModelCopyWith<$Res> {
  factory _$NestedModelCopyWith(_NestedModel value, $Res Function(_NestedModel) _then) = __$NestedModelCopyWithImpl;
@override @useResult
$Res call({
 String id, SimpleModel user, SimpleModel? optionalUser
});


@override $SimpleModelCopyWith<$Res> get user;@override $SimpleModelCopyWith<$Res>? get optionalUser;

}
/// @nodoc
class __$NestedModelCopyWithImpl<$Res>
    implements _$NestedModelCopyWith<$Res> {
  __$NestedModelCopyWithImpl(this._self, this._then);

  final _NestedModel _self;
  final $Res Function(_NestedModel) _then;

/// Create a copy of NestedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? user = null,Object? optionalUser = freezed,}) {
  return _then(_NestedModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as SimpleModel,optionalUser: freezed == optionalUser ? _self.optionalUser : optionalUser // ignore: cast_nullable_to_non_nullable
as SimpleModel?,
  ));
}

/// Create a copy of NestedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SimpleModelCopyWith<$Res> get user {
  
  return $SimpleModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of NestedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SimpleModelCopyWith<$Res>? get optionalUser {
    if (_self.optionalUser == null) {
    return null;
  }

  return $SimpleModelCopyWith<$Res>(_self.optionalUser!, (value) {
    return _then(_self.copyWith(optionalUser: value));
  });
}
}

// dart format on
