// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_validator_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomValidatorModel {

@WithCustomValidator(customValidatorFn, messageFn: customErrorMessage) String get customField; String get matchField;@WithSchemaCustomValidator(schemaValidatorFn, message: 'Fields must match') String get confirmField;
/// Create a copy of CustomValidatorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomValidatorModelCopyWith<CustomValidatorModel> get copyWith => _$CustomValidatorModelCopyWithImpl<CustomValidatorModel>(this as CustomValidatorModel, _$identity);

  /// Serializes this CustomValidatorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomValidatorModel&&(identical(other.customField, customField) || other.customField == customField)&&(identical(other.matchField, matchField) || other.matchField == matchField)&&(identical(other.confirmField, confirmField) || other.confirmField == confirmField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customField,matchField,confirmField);

@override
String toString() {
  return 'CustomValidatorModel(customField: $customField, matchField: $matchField, confirmField: $confirmField)';
}


}

/// @nodoc
abstract mixin class $CustomValidatorModelCopyWith<$Res>  {
  factory $CustomValidatorModelCopyWith(CustomValidatorModel value, $Res Function(CustomValidatorModel) _then) = _$CustomValidatorModelCopyWithImpl;
@useResult
$Res call({
@WithCustomValidator(customValidatorFn, messageFn: customErrorMessage) String customField, String matchField,@WithSchemaCustomValidator(schemaValidatorFn, message: 'Fields must match') String confirmField
});




}
/// @nodoc
class _$CustomValidatorModelCopyWithImpl<$Res>
    implements $CustomValidatorModelCopyWith<$Res> {
  _$CustomValidatorModelCopyWithImpl(this._self, this._then);

  final CustomValidatorModel _self;
  final $Res Function(CustomValidatorModel) _then;

/// Create a copy of CustomValidatorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customField = null,Object? matchField = null,Object? confirmField = null,}) {
  return _then(_self.copyWith(
customField: null == customField ? _self.customField : customField // ignore: cast_nullable_to_non_nullable
as String,matchField: null == matchField ? _self.matchField : matchField // ignore: cast_nullable_to_non_nullable
as String,confirmField: null == confirmField ? _self.confirmField : confirmField // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomValidatorModel].
extension CustomValidatorModelPatterns on CustomValidatorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomValidatorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomValidatorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomValidatorModel value)  $default,){
final _that = this;
switch (_that) {
case _CustomValidatorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomValidatorModel value)?  $default,){
final _that = this;
switch (_that) {
case _CustomValidatorModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@WithCustomValidator(customValidatorFn, messageFn: customErrorMessage)  String customField,  String matchField, @WithSchemaCustomValidator(schemaValidatorFn, message: 'Fields must match')  String confirmField)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomValidatorModel() when $default != null:
return $default(_that.customField,_that.matchField,_that.confirmField);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@WithCustomValidator(customValidatorFn, messageFn: customErrorMessage)  String customField,  String matchField, @WithSchemaCustomValidator(schemaValidatorFn, message: 'Fields must match')  String confirmField)  $default,) {final _that = this;
switch (_that) {
case _CustomValidatorModel():
return $default(_that.customField,_that.matchField,_that.confirmField);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@WithCustomValidator(customValidatorFn, messageFn: customErrorMessage)  String customField,  String matchField, @WithSchemaCustomValidator(schemaValidatorFn, message: 'Fields must match')  String confirmField)?  $default,) {final _that = this;
switch (_that) {
case _CustomValidatorModel() when $default != null:
return $default(_that.customField,_that.matchField,_that.confirmField);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomValidatorModel implements CustomValidatorModel {
  const _CustomValidatorModel({@WithCustomValidator(customValidatorFn, messageFn: customErrorMessage) required this.customField, required this.matchField, @WithSchemaCustomValidator(schemaValidatorFn, message: 'Fields must match') required this.confirmField});
  factory _CustomValidatorModel.fromJson(Map<String, dynamic> json) => _$CustomValidatorModelFromJson(json);

@override@WithCustomValidator(customValidatorFn, messageFn: customErrorMessage) final  String customField;
@override final  String matchField;
@override@WithSchemaCustomValidator(schemaValidatorFn, message: 'Fields must match') final  String confirmField;

/// Create a copy of CustomValidatorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomValidatorModelCopyWith<_CustomValidatorModel> get copyWith => __$CustomValidatorModelCopyWithImpl<_CustomValidatorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomValidatorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomValidatorModel&&(identical(other.customField, customField) || other.customField == customField)&&(identical(other.matchField, matchField) || other.matchField == matchField)&&(identical(other.confirmField, confirmField) || other.confirmField == confirmField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customField,matchField,confirmField);

@override
String toString() {
  return 'CustomValidatorModel(customField: $customField, matchField: $matchField, confirmField: $confirmField)';
}


}

/// @nodoc
abstract mixin class _$CustomValidatorModelCopyWith<$Res> implements $CustomValidatorModelCopyWith<$Res> {
  factory _$CustomValidatorModelCopyWith(_CustomValidatorModel value, $Res Function(_CustomValidatorModel) _then) = __$CustomValidatorModelCopyWithImpl;
@override @useResult
$Res call({
@WithCustomValidator(customValidatorFn, messageFn: customErrorMessage) String customField, String matchField,@WithSchemaCustomValidator(schemaValidatorFn, message: 'Fields must match') String confirmField
});




}
/// @nodoc
class __$CustomValidatorModelCopyWithImpl<$Res>
    implements _$CustomValidatorModelCopyWith<$Res> {
  __$CustomValidatorModelCopyWithImpl(this._self, this._then);

  final _CustomValidatorModel _self;
  final $Res Function(_CustomValidatorModel) _then;

/// Create a copy of CustomValidatorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customField = null,Object? matchField = null,Object? confirmField = null,}) {
  return _then(_CustomValidatorModel(
customField: null == customField ? _self.customField : customField // ignore: cast_nullable_to_non_nullable
as String,matchField: null == matchField ? _self.matchField : matchField // ignore: cast_nullable_to_non_nullable
as String,confirmField: null == confirmField ? _self.confirmField : confirmField // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
