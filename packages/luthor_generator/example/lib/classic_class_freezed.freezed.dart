// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'classic_class_freezed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClassicClassFreezed {

 String get name; int get age;
/// Create a copy of ClassicClassFreezed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassicClassFreezedCopyWith<ClassicClassFreezed> get copyWith => _$ClassicClassFreezedCopyWithImpl<ClassicClassFreezed>(this as ClassicClassFreezed, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassicClassFreezed&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,age);

@override
String toString() {
  return 'ClassicClassFreezed(name: $name, age: $age)';
}


}

/// @nodoc
abstract mixin class $ClassicClassFreezedCopyWith<$Res>  {
  factory $ClassicClassFreezedCopyWith(ClassicClassFreezed value, $Res Function(ClassicClassFreezed) _then) = _$ClassicClassFreezedCopyWithImpl;
@useResult
$Res call({
@HasMin(3) String name, int age
});




}
/// @nodoc
class _$ClassicClassFreezedCopyWithImpl<$Res>
    implements $ClassicClassFreezedCopyWith<$Res> {
  _$ClassicClassFreezedCopyWithImpl(this._self, this._then);

  final ClassicClassFreezed _self;
  final $Res Function(ClassicClassFreezed) _then;

/// Create a copy of ClassicClassFreezed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? age = null,}) {
  return _then(ClassicClassFreezed(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


// dart format on
