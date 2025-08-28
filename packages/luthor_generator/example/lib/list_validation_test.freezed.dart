// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_validation_test.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListValidationTest {

// Test case 1: List with nullable primitive types
 List<String?> get nullableStrings; List<int?> get nullableInts;// Test case 2: List with custom objects
 List<AnotherSample> get customObjects;// Test case 3: List with nullable custom objects
 List<AnotherSample?> get nullableCustomObjects;// Test case 4: Optional lists with nullable elements
 List<String?>? get optionalNullableStrings;
/// Create a copy of ListValidationTest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListValidationTestCopyWith<ListValidationTest> get copyWith => _$ListValidationTestCopyWithImpl<ListValidationTest>(this as ListValidationTest, _$identity);

  /// Serializes this ListValidationTest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListValidationTest&&const DeepCollectionEquality().equals(other.nullableStrings, nullableStrings)&&const DeepCollectionEquality().equals(other.nullableInts, nullableInts)&&const DeepCollectionEquality().equals(other.customObjects, customObjects)&&const DeepCollectionEquality().equals(other.nullableCustomObjects, nullableCustomObjects)&&const DeepCollectionEquality().equals(other.optionalNullableStrings, optionalNullableStrings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(nullableStrings),const DeepCollectionEquality().hash(nullableInts),const DeepCollectionEquality().hash(customObjects),const DeepCollectionEquality().hash(nullableCustomObjects),const DeepCollectionEquality().hash(optionalNullableStrings));

@override
String toString() {
  return 'ListValidationTest(nullableStrings: $nullableStrings, nullableInts: $nullableInts, customObjects: $customObjects, nullableCustomObjects: $nullableCustomObjects, optionalNullableStrings: $optionalNullableStrings)';
}


}

/// @nodoc
abstract mixin class $ListValidationTestCopyWith<$Res>  {
  factory $ListValidationTestCopyWith(ListValidationTest value, $Res Function(ListValidationTest) _then) = _$ListValidationTestCopyWithImpl;
@useResult
$Res call({
 List<String?> nullableStrings, List<int?> nullableInts, List<AnotherSample> customObjects, List<AnotherSample?> nullableCustomObjects, List<String?>? optionalNullableStrings
});




}
/// @nodoc
class _$ListValidationTestCopyWithImpl<$Res>
    implements $ListValidationTestCopyWith<$Res> {
  _$ListValidationTestCopyWithImpl(this._self, this._then);

  final ListValidationTest _self;
  final $Res Function(ListValidationTest) _then;

/// Create a copy of ListValidationTest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nullableStrings = null,Object? nullableInts = null,Object? customObjects = null,Object? nullableCustomObjects = null,Object? optionalNullableStrings = freezed,}) {
  return _then(_self.copyWith(
nullableStrings: null == nullableStrings ? _self.nullableStrings : nullableStrings // ignore: cast_nullable_to_non_nullable
as List<String?>,nullableInts: null == nullableInts ? _self.nullableInts : nullableInts // ignore: cast_nullable_to_non_nullable
as List<int?>,customObjects: null == customObjects ? _self.customObjects : customObjects // ignore: cast_nullable_to_non_nullable
as List<AnotherSample>,nullableCustomObjects: null == nullableCustomObjects ? _self.nullableCustomObjects : nullableCustomObjects // ignore: cast_nullable_to_non_nullable
as List<AnotherSample?>,optionalNullableStrings: freezed == optionalNullableStrings ? _self.optionalNullableStrings : optionalNullableStrings // ignore: cast_nullable_to_non_nullable
as List<String?>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ListValidationTest].
extension ListValidationTestPatterns on ListValidationTest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListValidationTest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListValidationTest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListValidationTest value)  $default,){
final _that = this;
switch (_that) {
case _ListValidationTest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListValidationTest value)?  $default,){
final _that = this;
switch (_that) {
case _ListValidationTest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String?> nullableStrings,  List<int?> nullableInts,  List<AnotherSample> customObjects,  List<AnotherSample?> nullableCustomObjects,  List<String?>? optionalNullableStrings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListValidationTest() when $default != null:
return $default(_that.nullableStrings,_that.nullableInts,_that.customObjects,_that.nullableCustomObjects,_that.optionalNullableStrings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String?> nullableStrings,  List<int?> nullableInts,  List<AnotherSample> customObjects,  List<AnotherSample?> nullableCustomObjects,  List<String?>? optionalNullableStrings)  $default,) {final _that = this;
switch (_that) {
case _ListValidationTest():
return $default(_that.nullableStrings,_that.nullableInts,_that.customObjects,_that.nullableCustomObjects,_that.optionalNullableStrings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String?> nullableStrings,  List<int?> nullableInts,  List<AnotherSample> customObjects,  List<AnotherSample?> nullableCustomObjects,  List<String?>? optionalNullableStrings)?  $default,) {final _that = this;
switch (_that) {
case _ListValidationTest() when $default != null:
return $default(_that.nullableStrings,_that.nullableInts,_that.customObjects,_that.nullableCustomObjects,_that.optionalNullableStrings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListValidationTest implements ListValidationTest {
  const _ListValidationTest({required final  List<String?> nullableStrings, required final  List<int?> nullableInts, required final  List<AnotherSample> customObjects, required final  List<AnotherSample?> nullableCustomObjects, final  List<String?>? optionalNullableStrings}): _nullableStrings = nullableStrings,_nullableInts = nullableInts,_customObjects = customObjects,_nullableCustomObjects = nullableCustomObjects,_optionalNullableStrings = optionalNullableStrings;
  factory _ListValidationTest.fromJson(Map<String, dynamic> json) => _$ListValidationTestFromJson(json);

// Test case 1: List with nullable primitive types
 final  List<String?> _nullableStrings;
// Test case 1: List with nullable primitive types
@override List<String?> get nullableStrings {
  if (_nullableStrings is EqualUnmodifiableListView) return _nullableStrings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nullableStrings);
}

 final  List<int?> _nullableInts;
@override List<int?> get nullableInts {
  if (_nullableInts is EqualUnmodifiableListView) return _nullableInts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nullableInts);
}

// Test case 2: List with custom objects
 final  List<AnotherSample> _customObjects;
// Test case 2: List with custom objects
@override List<AnotherSample> get customObjects {
  if (_customObjects is EqualUnmodifiableListView) return _customObjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customObjects);
}

// Test case 3: List with nullable custom objects
 final  List<AnotherSample?> _nullableCustomObjects;
// Test case 3: List with nullable custom objects
@override List<AnotherSample?> get nullableCustomObjects {
  if (_nullableCustomObjects is EqualUnmodifiableListView) return _nullableCustomObjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nullableCustomObjects);
}

// Test case 4: Optional lists with nullable elements
 final  List<String?>? _optionalNullableStrings;
// Test case 4: Optional lists with nullable elements
@override List<String?>? get optionalNullableStrings {
  final value = _optionalNullableStrings;
  if (value == null) return null;
  if (_optionalNullableStrings is EqualUnmodifiableListView) return _optionalNullableStrings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ListValidationTest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListValidationTestCopyWith<_ListValidationTest> get copyWith => __$ListValidationTestCopyWithImpl<_ListValidationTest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListValidationTestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListValidationTest&&const DeepCollectionEquality().equals(other._nullableStrings, _nullableStrings)&&const DeepCollectionEquality().equals(other._nullableInts, _nullableInts)&&const DeepCollectionEquality().equals(other._customObjects, _customObjects)&&const DeepCollectionEquality().equals(other._nullableCustomObjects, _nullableCustomObjects)&&const DeepCollectionEquality().equals(other._optionalNullableStrings, _optionalNullableStrings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_nullableStrings),const DeepCollectionEquality().hash(_nullableInts),const DeepCollectionEquality().hash(_customObjects),const DeepCollectionEquality().hash(_nullableCustomObjects),const DeepCollectionEquality().hash(_optionalNullableStrings));

@override
String toString() {
  return 'ListValidationTest(nullableStrings: $nullableStrings, nullableInts: $nullableInts, customObjects: $customObjects, nullableCustomObjects: $nullableCustomObjects, optionalNullableStrings: $optionalNullableStrings)';
}


}

/// @nodoc
abstract mixin class _$ListValidationTestCopyWith<$Res> implements $ListValidationTestCopyWith<$Res> {
  factory _$ListValidationTestCopyWith(_ListValidationTest value, $Res Function(_ListValidationTest) _then) = __$ListValidationTestCopyWithImpl;
@override @useResult
$Res call({
 List<String?> nullableStrings, List<int?> nullableInts, List<AnotherSample> customObjects, List<AnotherSample?> nullableCustomObjects, List<String?>? optionalNullableStrings
});




}
/// @nodoc
class __$ListValidationTestCopyWithImpl<$Res>
    implements _$ListValidationTestCopyWith<$Res> {
  __$ListValidationTestCopyWithImpl(this._self, this._then);

  final _ListValidationTest _self;
  final $Res Function(_ListValidationTest) _then;

/// Create a copy of ListValidationTest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nullableStrings = null,Object? nullableInts = null,Object? customObjects = null,Object? nullableCustomObjects = null,Object? optionalNullableStrings = freezed,}) {
  return _then(_ListValidationTest(
nullableStrings: null == nullableStrings ? _self._nullableStrings : nullableStrings // ignore: cast_nullable_to_non_nullable
as List<String?>,nullableInts: null == nullableInts ? _self._nullableInts : nullableInts // ignore: cast_nullable_to_non_nullable
as List<int?>,customObjects: null == customObjects ? _self._customObjects : customObjects // ignore: cast_nullable_to_non_nullable
as List<AnotherSample>,nullableCustomObjects: null == nullableCustomObjects ? _self._nullableCustomObjects : nullableCustomObjects // ignore: cast_nullable_to_non_nullable
as List<AnotherSample?>,optionalNullableStrings: freezed == optionalNullableStrings ? _self._optionalNullableStrings : optionalNullableStrings // ignore: cast_nullable_to_non_nullable
as List<String?>?,
  ));
}


}

// dart format on
