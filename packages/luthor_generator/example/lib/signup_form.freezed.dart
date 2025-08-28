// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignupForm {

@IsEmail() String get email;@HasMin(8) String get password;@WithSchemaCustomValidator(passwordsMatch, message: 'Passwords must match') String get confirmPassword; int get minAge;@WithSchemaCustomValidator(isGreaterThanMinAge, message: 'Max age must be greater than min age') int get maxAge;
/// Create a copy of SignupForm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupFormCopyWith<SignupForm> get copyWith => _$SignupFormCopyWithImpl<SignupForm>(this as SignupForm, _$identity);

  /// Serializes this SignupForm to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupForm&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.minAge, minAge) || other.minAge == minAge)&&(identical(other.maxAge, maxAge) || other.maxAge == maxAge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,confirmPassword,minAge,maxAge);

@override
String toString() {
  return 'SignupForm(email: $email, password: $password, confirmPassword: $confirmPassword, minAge: $minAge, maxAge: $maxAge)';
}


}

/// @nodoc
abstract mixin class $SignupFormCopyWith<$Res>  {
  factory $SignupFormCopyWith(SignupForm value, $Res Function(SignupForm) _then) = _$SignupFormCopyWithImpl;
@useResult
$Res call({
@IsEmail() String email,@HasMin(8) String password,@WithSchemaCustomValidator(passwordsMatch, message: 'Passwords must match') String confirmPassword, int minAge,@WithSchemaCustomValidator(isGreaterThanMinAge, message: 'Max age must be greater than min age') int maxAge
});




}
/// @nodoc
class _$SignupFormCopyWithImpl<$Res>
    implements $SignupFormCopyWith<$Res> {
  _$SignupFormCopyWithImpl(this._self, this._then);

  final SignupForm _self;
  final $Res Function(SignupForm) _then;

/// Create a copy of SignupForm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? confirmPassword = null,Object? minAge = null,Object? maxAge = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,minAge: null == minAge ? _self.minAge : minAge // ignore: cast_nullable_to_non_nullable
as int,maxAge: null == maxAge ? _self.maxAge : maxAge // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SignupForm].
extension SignupFormPatterns on SignupForm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupForm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupForm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupForm value)  $default,){
final _that = this;
switch (_that) {
case _SignupForm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupForm value)?  $default,){
final _that = this;
switch (_that) {
case _SignupForm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IsEmail()  String email, @HasMin(8)  String password, @WithSchemaCustomValidator(passwordsMatch, message: 'Passwords must match')  String confirmPassword,  int minAge, @WithSchemaCustomValidator(isGreaterThanMinAge, message: 'Max age must be greater than min age')  int maxAge)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupForm() when $default != null:
return $default(_that.email,_that.password,_that.confirmPassword,_that.minAge,_that.maxAge);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IsEmail()  String email, @HasMin(8)  String password, @WithSchemaCustomValidator(passwordsMatch, message: 'Passwords must match')  String confirmPassword,  int minAge, @WithSchemaCustomValidator(isGreaterThanMinAge, message: 'Max age must be greater than min age')  int maxAge)  $default,) {final _that = this;
switch (_that) {
case _SignupForm():
return $default(_that.email,_that.password,_that.confirmPassword,_that.minAge,_that.maxAge);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IsEmail()  String email, @HasMin(8)  String password, @WithSchemaCustomValidator(passwordsMatch, message: 'Passwords must match')  String confirmPassword,  int minAge, @WithSchemaCustomValidator(isGreaterThanMinAge, message: 'Max age must be greater than min age')  int maxAge)?  $default,) {final _that = this;
switch (_that) {
case _SignupForm() when $default != null:
return $default(_that.email,_that.password,_that.confirmPassword,_that.minAge,_that.maxAge);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignupForm implements SignupForm {
  const _SignupForm({@IsEmail() required this.email, @HasMin(8) required this.password, @WithSchemaCustomValidator(passwordsMatch, message: 'Passwords must match') required this.confirmPassword, required this.minAge, @WithSchemaCustomValidator(isGreaterThanMinAge, message: 'Max age must be greater than min age') required this.maxAge});
  factory _SignupForm.fromJson(Map<String, dynamic> json) => _$SignupFormFromJson(json);

@override@IsEmail() final  String email;
@override@HasMin(8) final  String password;
@override@WithSchemaCustomValidator(passwordsMatch, message: 'Passwords must match') final  String confirmPassword;
@override final  int minAge;
@override@WithSchemaCustomValidator(isGreaterThanMinAge, message: 'Max age must be greater than min age') final  int maxAge;

/// Create a copy of SignupForm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupFormCopyWith<_SignupForm> get copyWith => __$SignupFormCopyWithImpl<_SignupForm>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupFormToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupForm&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.minAge, minAge) || other.minAge == minAge)&&(identical(other.maxAge, maxAge) || other.maxAge == maxAge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,confirmPassword,minAge,maxAge);

@override
String toString() {
  return 'SignupForm(email: $email, password: $password, confirmPassword: $confirmPassword, minAge: $minAge, maxAge: $maxAge)';
}


}

/// @nodoc
abstract mixin class _$SignupFormCopyWith<$Res> implements $SignupFormCopyWith<$Res> {
  factory _$SignupFormCopyWith(_SignupForm value, $Res Function(_SignupForm) _then) = __$SignupFormCopyWithImpl;
@override @useResult
$Res call({
@IsEmail() String email,@HasMin(8) String password,@WithSchemaCustomValidator(passwordsMatch, message: 'Passwords must match') String confirmPassword, int minAge,@WithSchemaCustomValidator(isGreaterThanMinAge, message: 'Max age must be greater than min age') int maxAge
});




}
/// @nodoc
class __$SignupFormCopyWithImpl<$Res>
    implements _$SignupFormCopyWith<$Res> {
  __$SignupFormCopyWithImpl(this._self, this._then);

  final _SignupForm _self;
  final $Res Function(_SignupForm) _then;

/// Create a copy of SignupForm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? confirmPassword = null,Object? minAge = null,Object? maxAge = null,}) {
  return _then(_SignupForm(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,minAge: null == minAge ? _self.minAge : minAge // ignore: cast_nullable_to_non_nullable
as int,maxAge: null == maxAge ? _self.maxAge : maxAge // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
