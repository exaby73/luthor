// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListModel {

 List<String> get stringList; List<int> get intList; List<String>? get optionalList;
/// Create a copy of ListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListModelCopyWith<ListModel> get copyWith => _$ListModelCopyWithImpl<ListModel>(this as ListModel, _$identity);

  /// Serializes this ListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListModel&&const DeepCollectionEquality().equals(other.stringList, stringList)&&const DeepCollectionEquality().equals(other.intList, intList)&&const DeepCollectionEquality().equals(other.optionalList, optionalList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(stringList),const DeepCollectionEquality().hash(intList),const DeepCollectionEquality().hash(optionalList));

@override
String toString() {
  return 'ListModel(stringList: $stringList, intList: $intList, optionalList: $optionalList)';
}


}

/// @nodoc
abstract mixin class $ListModelCopyWith<$Res>  {
  factory $ListModelCopyWith(ListModel value, $Res Function(ListModel) _then) = _$ListModelCopyWithImpl;
@useResult
$Res call({
 List<String> stringList, List<int> intList, List<String>? optionalList
});




}
/// @nodoc
class _$ListModelCopyWithImpl<$Res>
    implements $ListModelCopyWith<$Res> {
  _$ListModelCopyWithImpl(this._self, this._then);

  final ListModel _self;
  final $Res Function(ListModel) _then;

/// Create a copy of ListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stringList = null,Object? intList = null,Object? optionalList = freezed,}) {
  return _then(_self.copyWith(
stringList: null == stringList ? _self.stringList : stringList // ignore: cast_nullable_to_non_nullable
as List<String>,intList: null == intList ? _self.intList : intList // ignore: cast_nullable_to_non_nullable
as List<int>,optionalList: freezed == optionalList ? _self.optionalList : optionalList // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ListModel].
extension ListModelPatterns on ListModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListModel value)  $default,){
final _that = this;
switch (_that) {
case _ListModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListModel value)?  $default,){
final _that = this;
switch (_that) {
case _ListModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> stringList,  List<int> intList,  List<String>? optionalList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListModel() when $default != null:
return $default(_that.stringList,_that.intList,_that.optionalList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> stringList,  List<int> intList,  List<String>? optionalList)  $default,) {final _that = this;
switch (_that) {
case _ListModel():
return $default(_that.stringList,_that.intList,_that.optionalList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> stringList,  List<int> intList,  List<String>? optionalList)?  $default,) {final _that = this;
switch (_that) {
case _ListModel() when $default != null:
return $default(_that.stringList,_that.intList,_that.optionalList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListModel implements ListModel {
  const _ListModel({required final  List<String> stringList, required final  List<int> intList, final  List<String>? optionalList}): _stringList = stringList,_intList = intList,_optionalList = optionalList;
  factory _ListModel.fromJson(Map<String, dynamic> json) => _$ListModelFromJson(json);

 final  List<String> _stringList;
@override List<String> get stringList {
  if (_stringList is EqualUnmodifiableListView) return _stringList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stringList);
}

 final  List<int> _intList;
@override List<int> get intList {
  if (_intList is EqualUnmodifiableListView) return _intList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_intList);
}

 final  List<String>? _optionalList;
@override List<String>? get optionalList {
  final value = _optionalList;
  if (value == null) return null;
  if (_optionalList is EqualUnmodifiableListView) return _optionalList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListModelCopyWith<_ListModel> get copyWith => __$ListModelCopyWithImpl<_ListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListModel&&const DeepCollectionEquality().equals(other._stringList, _stringList)&&const DeepCollectionEquality().equals(other._intList, _intList)&&const DeepCollectionEquality().equals(other._optionalList, _optionalList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stringList),const DeepCollectionEquality().hash(_intList),const DeepCollectionEquality().hash(_optionalList));

@override
String toString() {
  return 'ListModel(stringList: $stringList, intList: $intList, optionalList: $optionalList)';
}


}

/// @nodoc
abstract mixin class _$ListModelCopyWith<$Res> implements $ListModelCopyWith<$Res> {
  factory _$ListModelCopyWith(_ListModel value, $Res Function(_ListModel) _then) = __$ListModelCopyWithImpl;
@override @useResult
$Res call({
 List<String> stringList, List<int> intList, List<String>? optionalList
});




}
/// @nodoc
class __$ListModelCopyWithImpl<$Res>
    implements _$ListModelCopyWith<$Res> {
  __$ListModelCopyWithImpl(this._self, this._then);

  final _ListModel _self;
  final $Res Function(_ListModel) _then;

/// Create a copy of ListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stringList = null,Object? intList = null,Object? optionalList = freezed,}) {
  return _then(_ListModel(
stringList: null == stringList ? _self._stringList : stringList // ignore: cast_nullable_to_non_nullable
as List<String>,intList: null == intList ? _self._intList : intList // ignore: cast_nullable_to_non_nullable
as List<int>,optionalList: freezed == optionalList ? _self._optionalList : optionalList // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
