// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Sample {

 dynamic get anyValue; bool get boolValue; double get doubleValue; int get intValue; List<String> get listValue;// The following will work with luthor_generator, but not with json_serializable
// Null? nullValue,
 num get numValue; String get stringValue;@IsEmail(messageFn: emailErrorMessage) String get email;@isDateTime String get date; DateTime get dateTime;@HasLength(10, messageFn: lengthErrorMessage) String? get exactly10Characters;@HasMin(8)@HasMax(200) String get minAndMaxString;@StartsWith('foo') String get startsWithFoo;@EndsWith('bar') String get endsWithBar;@Contains('baz') String get containsBaz;@HasMin(2)@HasMax(4) int get minAndMaxInt;@HasMinDouble(2.0)@HasMaxDouble(4.0) double get minAndMaxDouble;@HasMinNumber(2)@HasMaxNumber(3.0) num get minAndMaxNumber;@IsUri(allowedSchemes: ['https']) String? get httpsLink;@IsUrl() String? get aUrl;@MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor', messageFn: regexErrorMessage) String get luthorPath; AnotherSample get anotherSample;@JsonKey(name: 'jsonKeyName') String get foo;@WithCustomValidator(customValidatorFn, messageFn: Sample.customValidatorMessage) String get custom; List<int> get numbers; String? get hello;
/// Create a copy of Sample
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SampleCopyWith<Sample> get copyWith => _$SampleCopyWithImpl<Sample>(this as Sample, _$identity);

  /// Serializes this Sample to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Sample&&const DeepCollectionEquality().equals(other.anyValue, anyValue)&&(identical(other.boolValue, boolValue) || other.boolValue == boolValue)&&(identical(other.doubleValue, doubleValue) || other.doubleValue == doubleValue)&&(identical(other.intValue, intValue) || other.intValue == intValue)&&const DeepCollectionEquality().equals(other.listValue, listValue)&&(identical(other.numValue, numValue) || other.numValue == numValue)&&(identical(other.stringValue, stringValue) || other.stringValue == stringValue)&&(identical(other.email, email) || other.email == email)&&(identical(other.date, date) || other.date == date)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.exactly10Characters, exactly10Characters) || other.exactly10Characters == exactly10Characters)&&(identical(other.minAndMaxString, minAndMaxString) || other.minAndMaxString == minAndMaxString)&&(identical(other.startsWithFoo, startsWithFoo) || other.startsWithFoo == startsWithFoo)&&(identical(other.endsWithBar, endsWithBar) || other.endsWithBar == endsWithBar)&&(identical(other.containsBaz, containsBaz) || other.containsBaz == containsBaz)&&(identical(other.minAndMaxInt, minAndMaxInt) || other.minAndMaxInt == minAndMaxInt)&&(identical(other.minAndMaxDouble, minAndMaxDouble) || other.minAndMaxDouble == minAndMaxDouble)&&(identical(other.minAndMaxNumber, minAndMaxNumber) || other.minAndMaxNumber == minAndMaxNumber)&&(identical(other.httpsLink, httpsLink) || other.httpsLink == httpsLink)&&(identical(other.aUrl, aUrl) || other.aUrl == aUrl)&&(identical(other.luthorPath, luthorPath) || other.luthorPath == luthorPath)&&(identical(other.anotherSample, anotherSample) || other.anotherSample == anotherSample)&&(identical(other.foo, foo) || other.foo == foo)&&(identical(other.custom, custom) || other.custom == custom)&&const DeepCollectionEquality().equals(other.numbers, numbers)&&(identical(other.hello, hello) || other.hello == hello));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(anyValue),boolValue,doubleValue,intValue,const DeepCollectionEquality().hash(listValue),numValue,stringValue,email,date,dateTime,exactly10Characters,minAndMaxString,startsWithFoo,endsWithBar,containsBaz,minAndMaxInt,minAndMaxDouble,minAndMaxNumber,httpsLink,aUrl,luthorPath,anotherSample,foo,custom,const DeepCollectionEquality().hash(numbers),hello]);

@override
String toString() {
  return 'Sample(anyValue: $anyValue, boolValue: $boolValue, doubleValue: $doubleValue, intValue: $intValue, listValue: $listValue, numValue: $numValue, stringValue: $stringValue, email: $email, date: $date, dateTime: $dateTime, exactly10Characters: $exactly10Characters, minAndMaxString: $minAndMaxString, startsWithFoo: $startsWithFoo, endsWithBar: $endsWithBar, containsBaz: $containsBaz, minAndMaxInt: $minAndMaxInt, minAndMaxDouble: $minAndMaxDouble, minAndMaxNumber: $minAndMaxNumber, httpsLink: $httpsLink, aUrl: $aUrl, luthorPath: $luthorPath, anotherSample: $anotherSample, foo: $foo, custom: $custom, numbers: $numbers, hello: $hello)';
}


}

/// @nodoc
abstract mixin class $SampleCopyWith<$Res>  {
  factory $SampleCopyWith(Sample value, $Res Function(Sample) _then) = _$SampleCopyWithImpl;
@useResult
$Res call({
 dynamic anyValue, bool boolValue, double doubleValue, int intValue, List<String> listValue, num numValue, String stringValue,@IsEmail(messageFn: emailErrorMessage) String email,@isDateTime String date, DateTime dateTime,@HasLength(10, messageFn: lengthErrorMessage) String? exactly10Characters,@HasMin(8)@HasMax(200) String minAndMaxString,@StartsWith('foo') String startsWithFoo,@EndsWith('bar') String endsWithBar,@Contains('baz') String containsBaz,@HasMin(2)@HasMax(4) int minAndMaxInt,@HasMinDouble(2.0)@HasMaxDouble(4.0) double minAndMaxDouble,@HasMinNumber(2)@HasMaxNumber(3.0) num minAndMaxNumber,@IsUri(allowedSchemes: ['https']) String? httpsLink,@IsUrl() String? aUrl,@MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor', messageFn: regexErrorMessage) String luthorPath, AnotherSample anotherSample,@JsonKey(name: 'jsonKeyName') String foo,@WithCustomValidator(customValidatorFn, messageFn: Sample.customValidatorMessage) String custom, List<int> numbers, String? hello
});


$AnotherSampleCopyWith<$Res> get anotherSample;

}
/// @nodoc
class _$SampleCopyWithImpl<$Res>
    implements $SampleCopyWith<$Res> {
  _$SampleCopyWithImpl(this._self, this._then);

  final Sample _self;
  final $Res Function(Sample) _then;

/// Create a copy of Sample
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? anyValue = freezed,Object? boolValue = null,Object? doubleValue = null,Object? intValue = null,Object? listValue = null,Object? numValue = null,Object? stringValue = null,Object? email = null,Object? date = null,Object? dateTime = null,Object? exactly10Characters = freezed,Object? minAndMaxString = null,Object? startsWithFoo = null,Object? endsWithBar = null,Object? containsBaz = null,Object? minAndMaxInt = null,Object? minAndMaxDouble = null,Object? minAndMaxNumber = null,Object? httpsLink = freezed,Object? aUrl = freezed,Object? luthorPath = null,Object? anotherSample = null,Object? foo = null,Object? custom = null,Object? numbers = null,Object? hello = freezed,}) {
  return _then(_self.copyWith(
anyValue: freezed == anyValue ? _self.anyValue : anyValue // ignore: cast_nullable_to_non_nullable
as dynamic,boolValue: null == boolValue ? _self.boolValue : boolValue // ignore: cast_nullable_to_non_nullable
as bool,doubleValue: null == doubleValue ? _self.doubleValue : doubleValue // ignore: cast_nullable_to_non_nullable
as double,intValue: null == intValue ? _self.intValue : intValue // ignore: cast_nullable_to_non_nullable
as int,listValue: null == listValue ? _self.listValue : listValue // ignore: cast_nullable_to_non_nullable
as List<String>,numValue: null == numValue ? _self.numValue : numValue // ignore: cast_nullable_to_non_nullable
as num,stringValue: null == stringValue ? _self.stringValue : stringValue // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,exactly10Characters: freezed == exactly10Characters ? _self.exactly10Characters : exactly10Characters // ignore: cast_nullable_to_non_nullable
as String?,minAndMaxString: null == minAndMaxString ? _self.minAndMaxString : minAndMaxString // ignore: cast_nullable_to_non_nullable
as String,startsWithFoo: null == startsWithFoo ? _self.startsWithFoo : startsWithFoo // ignore: cast_nullable_to_non_nullable
as String,endsWithBar: null == endsWithBar ? _self.endsWithBar : endsWithBar // ignore: cast_nullable_to_non_nullable
as String,containsBaz: null == containsBaz ? _self.containsBaz : containsBaz // ignore: cast_nullable_to_non_nullable
as String,minAndMaxInt: null == minAndMaxInt ? _self.minAndMaxInt : minAndMaxInt // ignore: cast_nullable_to_non_nullable
as int,minAndMaxDouble: null == minAndMaxDouble ? _self.minAndMaxDouble : minAndMaxDouble // ignore: cast_nullable_to_non_nullable
as double,minAndMaxNumber: null == minAndMaxNumber ? _self.minAndMaxNumber : minAndMaxNumber // ignore: cast_nullable_to_non_nullable
as num,httpsLink: freezed == httpsLink ? _self.httpsLink : httpsLink // ignore: cast_nullable_to_non_nullable
as String?,aUrl: freezed == aUrl ? _self.aUrl : aUrl // ignore: cast_nullable_to_non_nullable
as String?,luthorPath: null == luthorPath ? _self.luthorPath : luthorPath // ignore: cast_nullable_to_non_nullable
as String,anotherSample: null == anotherSample ? _self.anotherSample : anotherSample // ignore: cast_nullable_to_non_nullable
as AnotherSample,foo: null == foo ? _self.foo : foo // ignore: cast_nullable_to_non_nullable
as String,custom: null == custom ? _self.custom : custom // ignore: cast_nullable_to_non_nullable
as String,numbers: null == numbers ? _self.numbers : numbers // ignore: cast_nullable_to_non_nullable
as List<int>,hello: freezed == hello ? _self.hello : hello // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Sample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnotherSampleCopyWith<$Res> get anotherSample {
  
  return $AnotherSampleCopyWith<$Res>(_self.anotherSample, (value) {
    return _then(_self.copyWith(anotherSample: value));
  });
}
}


/// Adds pattern-matching-related methods to [Sample].
extension SamplePatterns on Sample {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Sample value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Sample() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Sample value)  $default,){
final _that = this;
switch (_that) {
case _Sample():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Sample value)?  $default,){
final _that = this;
switch (_that) {
case _Sample() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic anyValue,  bool boolValue,  double doubleValue,  int intValue,  List<String> listValue,  num numValue,  String stringValue, @IsEmail(messageFn: emailErrorMessage)  String email, @isDateTime  String date,  DateTime dateTime, @HasLength(10, messageFn: lengthErrorMessage)  String? exactly10Characters, @HasMin(8)@HasMax(200)  String minAndMaxString, @StartsWith('foo')  String startsWithFoo, @EndsWith('bar')  String endsWithBar, @Contains('baz')  String containsBaz, @HasMin(2)@HasMax(4)  int minAndMaxInt, @HasMinDouble(2.0)@HasMaxDouble(4.0)  double minAndMaxDouble, @HasMinNumber(2)@HasMaxNumber(3.0)  num minAndMaxNumber, @IsUri(allowedSchemes: ['https'])  String? httpsLink, @IsUrl()  String? aUrl, @MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor', messageFn: regexErrorMessage)  String luthorPath,  AnotherSample anotherSample, @JsonKey(name: 'jsonKeyName')  String foo, @WithCustomValidator(customValidatorFn, messageFn: Sample.customValidatorMessage)  String custom,  List<int> numbers,  String? hello)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Sample() when $default != null:
return $default(_that.anyValue,_that.boolValue,_that.doubleValue,_that.intValue,_that.listValue,_that.numValue,_that.stringValue,_that.email,_that.date,_that.dateTime,_that.exactly10Characters,_that.minAndMaxString,_that.startsWithFoo,_that.endsWithBar,_that.containsBaz,_that.minAndMaxInt,_that.minAndMaxDouble,_that.minAndMaxNumber,_that.httpsLink,_that.aUrl,_that.luthorPath,_that.anotherSample,_that.foo,_that.custom,_that.numbers,_that.hello);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic anyValue,  bool boolValue,  double doubleValue,  int intValue,  List<String> listValue,  num numValue,  String stringValue, @IsEmail(messageFn: emailErrorMessage)  String email, @isDateTime  String date,  DateTime dateTime, @HasLength(10, messageFn: lengthErrorMessage)  String? exactly10Characters, @HasMin(8)@HasMax(200)  String minAndMaxString, @StartsWith('foo')  String startsWithFoo, @EndsWith('bar')  String endsWithBar, @Contains('baz')  String containsBaz, @HasMin(2)@HasMax(4)  int minAndMaxInt, @HasMinDouble(2.0)@HasMaxDouble(4.0)  double minAndMaxDouble, @HasMinNumber(2)@HasMaxNumber(3.0)  num minAndMaxNumber, @IsUri(allowedSchemes: ['https'])  String? httpsLink, @IsUrl()  String? aUrl, @MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor', messageFn: regexErrorMessage)  String luthorPath,  AnotherSample anotherSample, @JsonKey(name: 'jsonKeyName')  String foo, @WithCustomValidator(customValidatorFn, messageFn: Sample.customValidatorMessage)  String custom,  List<int> numbers,  String? hello)  $default,) {final _that = this;
switch (_that) {
case _Sample():
return $default(_that.anyValue,_that.boolValue,_that.doubleValue,_that.intValue,_that.listValue,_that.numValue,_that.stringValue,_that.email,_that.date,_that.dateTime,_that.exactly10Characters,_that.minAndMaxString,_that.startsWithFoo,_that.endsWithBar,_that.containsBaz,_that.minAndMaxInt,_that.minAndMaxDouble,_that.minAndMaxNumber,_that.httpsLink,_that.aUrl,_that.luthorPath,_that.anotherSample,_that.foo,_that.custom,_that.numbers,_that.hello);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic anyValue,  bool boolValue,  double doubleValue,  int intValue,  List<String> listValue,  num numValue,  String stringValue, @IsEmail(messageFn: emailErrorMessage)  String email, @isDateTime  String date,  DateTime dateTime, @HasLength(10, messageFn: lengthErrorMessage)  String? exactly10Characters, @HasMin(8)@HasMax(200)  String minAndMaxString, @StartsWith('foo')  String startsWithFoo, @EndsWith('bar')  String endsWithBar, @Contains('baz')  String containsBaz, @HasMin(2)@HasMax(4)  int minAndMaxInt, @HasMinDouble(2.0)@HasMaxDouble(4.0)  double minAndMaxDouble, @HasMinNumber(2)@HasMaxNumber(3.0)  num minAndMaxNumber, @IsUri(allowedSchemes: ['https'])  String? httpsLink, @IsUrl()  String? aUrl, @MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor', messageFn: regexErrorMessage)  String luthorPath,  AnotherSample anotherSample, @JsonKey(name: 'jsonKeyName')  String foo, @WithCustomValidator(customValidatorFn, messageFn: Sample.customValidatorMessage)  String custom,  List<int> numbers,  String? hello)?  $default,) {final _that = this;
switch (_that) {
case _Sample() when $default != null:
return $default(_that.anyValue,_that.boolValue,_that.doubleValue,_that.intValue,_that.listValue,_that.numValue,_that.stringValue,_that.email,_that.date,_that.dateTime,_that.exactly10Characters,_that.minAndMaxString,_that.startsWithFoo,_that.endsWithBar,_that.containsBaz,_that.minAndMaxInt,_that.minAndMaxDouble,_that.minAndMaxNumber,_that.httpsLink,_that.aUrl,_that.luthorPath,_that.anotherSample,_that.foo,_that.custom,_that.numbers,_that.hello);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Sample implements Sample {
  const _Sample({this.anyValue, required this.boolValue, required this.doubleValue, required this.intValue, required final  List<String> listValue, required this.numValue, required this.stringValue, @IsEmail(messageFn: emailErrorMessage) required this.email, @isDateTime required this.date, required this.dateTime, @HasLength(10, messageFn: lengthErrorMessage) this.exactly10Characters, @HasMin(8)@HasMax(200) required this.minAndMaxString, @StartsWith('foo') required this.startsWithFoo, @EndsWith('bar') required this.endsWithBar, @Contains('baz') required this.containsBaz, @HasMin(2)@HasMax(4) required this.minAndMaxInt, @HasMinDouble(2.0)@HasMaxDouble(4.0) required this.minAndMaxDouble, @HasMinNumber(2)@HasMaxNumber(3.0) required this.minAndMaxNumber, @IsUri(allowedSchemes: ['https']) this.httpsLink, @IsUrl() this.aUrl, @MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor', messageFn: regexErrorMessage) required this.luthorPath, required this.anotherSample, @JsonKey(name: 'jsonKeyName') required this.foo, @WithCustomValidator(customValidatorFn, messageFn: Sample.customValidatorMessage) required this.custom, required final  List<int> numbers, this.hello}): _listValue = listValue,_numbers = numbers;
  factory _Sample.fromJson(Map<String, dynamic> json) => _$SampleFromJson(json);

@override final  dynamic anyValue;
@override final  bool boolValue;
@override final  double doubleValue;
@override final  int intValue;
 final  List<String> _listValue;
@override List<String> get listValue {
  if (_listValue is EqualUnmodifiableListView) return _listValue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listValue);
}

// The following will work with luthor_generator, but not with json_serializable
// Null? nullValue,
@override final  num numValue;
@override final  String stringValue;
@override@IsEmail(messageFn: emailErrorMessage) final  String email;
@override@isDateTime final  String date;
@override final  DateTime dateTime;
@override@HasLength(10, messageFn: lengthErrorMessage) final  String? exactly10Characters;
@override@HasMin(8)@HasMax(200) final  String minAndMaxString;
@override@StartsWith('foo') final  String startsWithFoo;
@override@EndsWith('bar') final  String endsWithBar;
@override@Contains('baz') final  String containsBaz;
@override@HasMin(2)@HasMax(4) final  int minAndMaxInt;
@override@HasMinDouble(2.0)@HasMaxDouble(4.0) final  double minAndMaxDouble;
@override@HasMinNumber(2)@HasMaxNumber(3.0) final  num minAndMaxNumber;
@override@IsUri(allowedSchemes: ['https']) final  String? httpsLink;
@override@IsUrl() final  String? aUrl;
@override@MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor', messageFn: regexErrorMessage) final  String luthorPath;
@override final  AnotherSample anotherSample;
@override@JsonKey(name: 'jsonKeyName') final  String foo;
@override@WithCustomValidator(customValidatorFn, messageFn: Sample.customValidatorMessage) final  String custom;
 final  List<int> _numbers;
@override List<int> get numbers {
  if (_numbers is EqualUnmodifiableListView) return _numbers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_numbers);
}

@override final  String? hello;

/// Create a copy of Sample
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SampleCopyWith<_Sample> get copyWith => __$SampleCopyWithImpl<_Sample>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SampleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sample&&const DeepCollectionEquality().equals(other.anyValue, anyValue)&&(identical(other.boolValue, boolValue) || other.boolValue == boolValue)&&(identical(other.doubleValue, doubleValue) || other.doubleValue == doubleValue)&&(identical(other.intValue, intValue) || other.intValue == intValue)&&const DeepCollectionEquality().equals(other._listValue, _listValue)&&(identical(other.numValue, numValue) || other.numValue == numValue)&&(identical(other.stringValue, stringValue) || other.stringValue == stringValue)&&(identical(other.email, email) || other.email == email)&&(identical(other.date, date) || other.date == date)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.exactly10Characters, exactly10Characters) || other.exactly10Characters == exactly10Characters)&&(identical(other.minAndMaxString, minAndMaxString) || other.minAndMaxString == minAndMaxString)&&(identical(other.startsWithFoo, startsWithFoo) || other.startsWithFoo == startsWithFoo)&&(identical(other.endsWithBar, endsWithBar) || other.endsWithBar == endsWithBar)&&(identical(other.containsBaz, containsBaz) || other.containsBaz == containsBaz)&&(identical(other.minAndMaxInt, minAndMaxInt) || other.minAndMaxInt == minAndMaxInt)&&(identical(other.minAndMaxDouble, minAndMaxDouble) || other.minAndMaxDouble == minAndMaxDouble)&&(identical(other.minAndMaxNumber, minAndMaxNumber) || other.minAndMaxNumber == minAndMaxNumber)&&(identical(other.httpsLink, httpsLink) || other.httpsLink == httpsLink)&&(identical(other.aUrl, aUrl) || other.aUrl == aUrl)&&(identical(other.luthorPath, luthorPath) || other.luthorPath == luthorPath)&&(identical(other.anotherSample, anotherSample) || other.anotherSample == anotherSample)&&(identical(other.foo, foo) || other.foo == foo)&&(identical(other.custom, custom) || other.custom == custom)&&const DeepCollectionEquality().equals(other._numbers, _numbers)&&(identical(other.hello, hello) || other.hello == hello));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(anyValue),boolValue,doubleValue,intValue,const DeepCollectionEquality().hash(_listValue),numValue,stringValue,email,date,dateTime,exactly10Characters,minAndMaxString,startsWithFoo,endsWithBar,containsBaz,minAndMaxInt,minAndMaxDouble,minAndMaxNumber,httpsLink,aUrl,luthorPath,anotherSample,foo,custom,const DeepCollectionEquality().hash(_numbers),hello]);

@override
String toString() {
  return 'Sample(anyValue: $anyValue, boolValue: $boolValue, doubleValue: $doubleValue, intValue: $intValue, listValue: $listValue, numValue: $numValue, stringValue: $stringValue, email: $email, date: $date, dateTime: $dateTime, exactly10Characters: $exactly10Characters, minAndMaxString: $minAndMaxString, startsWithFoo: $startsWithFoo, endsWithBar: $endsWithBar, containsBaz: $containsBaz, minAndMaxInt: $minAndMaxInt, minAndMaxDouble: $minAndMaxDouble, minAndMaxNumber: $minAndMaxNumber, httpsLink: $httpsLink, aUrl: $aUrl, luthorPath: $luthorPath, anotherSample: $anotherSample, foo: $foo, custom: $custom, numbers: $numbers, hello: $hello)';
}


}

/// @nodoc
abstract mixin class _$SampleCopyWith<$Res> implements $SampleCopyWith<$Res> {
  factory _$SampleCopyWith(_Sample value, $Res Function(_Sample) _then) = __$SampleCopyWithImpl;
@override @useResult
$Res call({
 dynamic anyValue, bool boolValue, double doubleValue, int intValue, List<String> listValue, num numValue, String stringValue,@IsEmail(messageFn: emailErrorMessage) String email,@isDateTime String date, DateTime dateTime,@HasLength(10, messageFn: lengthErrorMessage) String? exactly10Characters,@HasMin(8)@HasMax(200) String minAndMaxString,@StartsWith('foo') String startsWithFoo,@EndsWith('bar') String endsWithBar,@Contains('baz') String containsBaz,@HasMin(2)@HasMax(4) int minAndMaxInt,@HasMinDouble(2.0)@HasMaxDouble(4.0) double minAndMaxDouble,@HasMinNumber(2)@HasMaxNumber(3.0) num minAndMaxNumber,@IsUri(allowedSchemes: ['https']) String? httpsLink,@IsUrl() String? aUrl,@MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor', messageFn: regexErrorMessage) String luthorPath, AnotherSample anotherSample,@JsonKey(name: 'jsonKeyName') String foo,@WithCustomValidator(customValidatorFn, messageFn: Sample.customValidatorMessage) String custom, List<int> numbers, String? hello
});


@override $AnotherSampleCopyWith<$Res> get anotherSample;

}
/// @nodoc
class __$SampleCopyWithImpl<$Res>
    implements _$SampleCopyWith<$Res> {
  __$SampleCopyWithImpl(this._self, this._then);

  final _Sample _self;
  final $Res Function(_Sample) _then;

/// Create a copy of Sample
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? anyValue = freezed,Object? boolValue = null,Object? doubleValue = null,Object? intValue = null,Object? listValue = null,Object? numValue = null,Object? stringValue = null,Object? email = null,Object? date = null,Object? dateTime = null,Object? exactly10Characters = freezed,Object? minAndMaxString = null,Object? startsWithFoo = null,Object? endsWithBar = null,Object? containsBaz = null,Object? minAndMaxInt = null,Object? minAndMaxDouble = null,Object? minAndMaxNumber = null,Object? httpsLink = freezed,Object? aUrl = freezed,Object? luthorPath = null,Object? anotherSample = null,Object? foo = null,Object? custom = null,Object? numbers = null,Object? hello = freezed,}) {
  return _then(_Sample(
anyValue: freezed == anyValue ? _self.anyValue : anyValue // ignore: cast_nullable_to_non_nullable
as dynamic,boolValue: null == boolValue ? _self.boolValue : boolValue // ignore: cast_nullable_to_non_nullable
as bool,doubleValue: null == doubleValue ? _self.doubleValue : doubleValue // ignore: cast_nullable_to_non_nullable
as double,intValue: null == intValue ? _self.intValue : intValue // ignore: cast_nullable_to_non_nullable
as int,listValue: null == listValue ? _self._listValue : listValue // ignore: cast_nullable_to_non_nullable
as List<String>,numValue: null == numValue ? _self.numValue : numValue // ignore: cast_nullable_to_non_nullable
as num,stringValue: null == stringValue ? _self.stringValue : stringValue // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,exactly10Characters: freezed == exactly10Characters ? _self.exactly10Characters : exactly10Characters // ignore: cast_nullable_to_non_nullable
as String?,minAndMaxString: null == minAndMaxString ? _self.minAndMaxString : minAndMaxString // ignore: cast_nullable_to_non_nullable
as String,startsWithFoo: null == startsWithFoo ? _self.startsWithFoo : startsWithFoo // ignore: cast_nullable_to_non_nullable
as String,endsWithBar: null == endsWithBar ? _self.endsWithBar : endsWithBar // ignore: cast_nullable_to_non_nullable
as String,containsBaz: null == containsBaz ? _self.containsBaz : containsBaz // ignore: cast_nullable_to_non_nullable
as String,minAndMaxInt: null == minAndMaxInt ? _self.minAndMaxInt : minAndMaxInt // ignore: cast_nullable_to_non_nullable
as int,minAndMaxDouble: null == minAndMaxDouble ? _self.minAndMaxDouble : minAndMaxDouble // ignore: cast_nullable_to_non_nullable
as double,minAndMaxNumber: null == minAndMaxNumber ? _self.minAndMaxNumber : minAndMaxNumber // ignore: cast_nullable_to_non_nullable
as num,httpsLink: freezed == httpsLink ? _self.httpsLink : httpsLink // ignore: cast_nullable_to_non_nullable
as String?,aUrl: freezed == aUrl ? _self.aUrl : aUrl // ignore: cast_nullable_to_non_nullable
as String?,luthorPath: null == luthorPath ? _self.luthorPath : luthorPath // ignore: cast_nullable_to_non_nullable
as String,anotherSample: null == anotherSample ? _self.anotherSample : anotherSample // ignore: cast_nullable_to_non_nullable
as AnotherSample,foo: null == foo ? _self.foo : foo // ignore: cast_nullable_to_non_nullable
as String,custom: null == custom ? _self.custom : custom // ignore: cast_nullable_to_non_nullable
as String,numbers: null == numbers ? _self._numbers : numbers // ignore: cast_nullable_to_non_nullable
as List<int>,hello: freezed == hello ? _self.hello : hello // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Sample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnotherSampleCopyWith<$Res> get anotherSample {
  
  return $AnotherSampleCopyWith<$Res>(_self.anotherSample, (value) {
    return _then(_self.copyWith(anotherSample: value));
  });
}
}

// dart format on
