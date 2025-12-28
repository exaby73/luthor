// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simple_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SimpleModel {

 String get name; int get age; bool get isActive; double get score; String? get optionalField;
/// Create a copy of SimpleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimpleModelCopyWith<SimpleModel> get copyWith => _$SimpleModelCopyWithImpl<SimpleModel>(this as SimpleModel, _$identity);

  /// Serializes this SimpleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimpleModel&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.score, score) || other.score == score)&&(identical(other.optionalField, optionalField) || other.optionalField == optionalField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,age,isActive,score,optionalField);

@override
String toString() {
  return 'SimpleModel(name: $name, age: $age, isActive: $isActive, score: $score, optionalField: $optionalField)';
}


}

/// @nodoc
abstract mixin class $SimpleModelCopyWith<$Res>  {
  factory $SimpleModelCopyWith(SimpleModel value, $Res Function(SimpleModel) _then) = _$SimpleModelCopyWithImpl;
@useResult
$Res call({
 String name, int age, bool isActive, double score, String? optionalField
});




}
/// @nodoc
class _$SimpleModelCopyWithImpl<$Res>
    implements $SimpleModelCopyWith<$Res> {
  _$SimpleModelCopyWithImpl(this._self, this._then);

  final SimpleModel _self;
  final $Res Function(SimpleModel) _then;

/// Create a copy of SimpleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? age = null,Object? isActive = null,Object? score = null,Object? optionalField = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,optionalField: freezed == optionalField ? _self.optionalField : optionalField // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SimpleModel].
extension SimpleModelPatterns on SimpleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SimpleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SimpleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SimpleModel value)  $default,){
final _that = this;
switch (_that) {
case _SimpleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SimpleModel value)?  $default,){
final _that = this;
switch (_that) {
case _SimpleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int age,  bool isActive,  double score,  String? optionalField)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SimpleModel() when $default != null:
return $default(_that.name,_that.age,_that.isActive,_that.score,_that.optionalField);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int age,  bool isActive,  double score,  String? optionalField)  $default,) {final _that = this;
switch (_that) {
case _SimpleModel():
return $default(_that.name,_that.age,_that.isActive,_that.score,_that.optionalField);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int age,  bool isActive,  double score,  String? optionalField)?  $default,) {final _that = this;
switch (_that) {
case _SimpleModel() when $default != null:
return $default(_that.name,_that.age,_that.isActive,_that.score,_that.optionalField);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SimpleModel implements SimpleModel {
  const _SimpleModel({required this.name, required this.age, required this.isActive, required this.score, this.optionalField});
  factory _SimpleModel.fromJson(Map<String, dynamic> json) => _$SimpleModelFromJson(json);

@override final  String name;
@override final  int age;
@override final  bool isActive;
@override final  double score;
@override final  String? optionalField;

/// Create a copy of SimpleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimpleModelCopyWith<_SimpleModel> get copyWith => __$SimpleModelCopyWithImpl<_SimpleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SimpleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimpleModel&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.score, score) || other.score == score)&&(identical(other.optionalField, optionalField) || other.optionalField == optionalField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,age,isActive,score,optionalField);

@override
String toString() {
  return 'SimpleModel(name: $name, age: $age, isActive: $isActive, score: $score, optionalField: $optionalField)';
}


}

/// @nodoc
abstract mixin class _$SimpleModelCopyWith<$Res> implements $SimpleModelCopyWith<$Res> {
  factory _$SimpleModelCopyWith(_SimpleModel value, $Res Function(_SimpleModel) _then) = __$SimpleModelCopyWithImpl;
@override @useResult
$Res call({
 String name, int age, bool isActive, double score, String? optionalField
});




}
/// @nodoc
class __$SimpleModelCopyWithImpl<$Res>
    implements _$SimpleModelCopyWith<$Res> {
  __$SimpleModelCopyWithImpl(this._self, this._then);

  final _SimpleModel _self;
  final $Res Function(_SimpleModel) _then;

/// Create a copy of SimpleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? age = null,Object? isActive = null,Object? score = null,Object? optionalField = freezed,}) {
  return _then(_SimpleModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,optionalField: freezed == optionalField ? _self.optionalField : optionalField // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
