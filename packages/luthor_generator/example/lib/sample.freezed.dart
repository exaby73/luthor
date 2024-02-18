// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Sample _$SampleFromJson(Map<String, dynamic> json) {
  return _Sample.fromJson(json);
}

/// @nodoc
mixin _$Sample {
  dynamic get anyValue => throw _privateConstructorUsedError;
  bool get boolValue => throw _privateConstructorUsedError;
  double get doubleValue => throw _privateConstructorUsedError;
  int get intValue => throw _privateConstructorUsedError;
  List<String> get listValue =>
      throw _privateConstructorUsedError; // The following will work with luthor_generator, but not with json_serializable
// Null? nullValue,
  num get numValue => throw _privateConstructorUsedError;
  String get stringValue => throw _privateConstructorUsedError;
  @isEmail
  String get email => throw _privateConstructorUsedError;
  @isDateTime
  String get date => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  @HasLength(10)
  String? get exactly10Characters => throw _privateConstructorUsedError;
  @HasMin(8)
  @HasMax(200)
  String get minAndMaxString => throw _privateConstructorUsedError;
  @HasMin(2)
  @HasMax(4)
  int get minAndMaxInt => throw _privateConstructorUsedError;
  @HasMinDouble(2.0)
  @HasMaxDouble(4.0)
  double get minAndMaxDouble => throw _privateConstructorUsedError;
  @HasMinNumber(2)
  @HasMaxNumber(3.0)
  num get minAndMaxNumber => throw _privateConstructorUsedError;
  @IsUri(allowedSchemes: ['https'])
  String? get httpsLink => throw _privateConstructorUsedError;
  @MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor')
  String get luthorPath => throw _privateConstructorUsedError;
  AnotherSample get anotherSample => throw _privateConstructorUsedError;
  @JsonKey(name: 'jsonKeyName')
  String get foo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SampleCopyWith<Sample> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SampleCopyWith<$Res> {
  factory $SampleCopyWith(Sample value, $Res Function(Sample) then) =
      _$SampleCopyWithImpl<$Res, Sample>;
  @useResult
  $Res call(
      {dynamic anyValue,
      bool boolValue,
      double doubleValue,
      int intValue,
      List<String> listValue,
      num numValue,
      String stringValue,
      @isEmail String email,
      @isDateTime String date,
      DateTime dateTime,
      @HasLength(10) String? exactly10Characters,
      @HasMin(8) @HasMax(200) String minAndMaxString,
      @HasMin(2) @HasMax(4) int minAndMaxInt,
      @HasMinDouble(2.0) @HasMaxDouble(4.0) double minAndMaxDouble,
      @HasMinNumber(2) @HasMaxNumber(3.0) num minAndMaxNumber,
      @IsUri(allowedSchemes: ['https']) String? httpsLink,
      @MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor') String luthorPath,
      AnotherSample anotherSample,
      @JsonKey(name: 'jsonKeyName') String foo});

  $AnotherSampleCopyWith<$Res> get anotherSample;
}

/// @nodoc
class _$SampleCopyWithImpl<$Res, $Val extends Sample>
    implements $SampleCopyWith<$Res> {
  _$SampleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? anyValue = freezed,
    Object? boolValue = null,
    Object? doubleValue = null,
    Object? intValue = null,
    Object? listValue = null,
    Object? numValue = null,
    Object? stringValue = null,
    Object? email = null,
    Object? date = null,
    Object? dateTime = null,
    Object? exactly10Characters = freezed,
    Object? minAndMaxString = null,
    Object? minAndMaxInt = null,
    Object? minAndMaxDouble = null,
    Object? minAndMaxNumber = null,
    Object? httpsLink = freezed,
    Object? luthorPath = null,
    Object? anotherSample = null,
    Object? foo = null,
  }) {
    return _then(_value.copyWith(
      anyValue: freezed == anyValue
          ? _value.anyValue
          : anyValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      boolValue: null == boolValue
          ? _value.boolValue
          : boolValue // ignore: cast_nullable_to_non_nullable
              as bool,
      doubleValue: null == doubleValue
          ? _value.doubleValue
          : doubleValue // ignore: cast_nullable_to_non_nullable
              as double,
      intValue: null == intValue
          ? _value.intValue
          : intValue // ignore: cast_nullable_to_non_nullable
              as int,
      listValue: null == listValue
          ? _value.listValue
          : listValue // ignore: cast_nullable_to_non_nullable
              as List<String>,
      numValue: null == numValue
          ? _value.numValue
          : numValue // ignore: cast_nullable_to_non_nullable
              as num,
      stringValue: null == stringValue
          ? _value.stringValue
          : stringValue // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      exactly10Characters: freezed == exactly10Characters
          ? _value.exactly10Characters
          : exactly10Characters // ignore: cast_nullable_to_non_nullable
              as String?,
      minAndMaxString: null == minAndMaxString
          ? _value.minAndMaxString
          : minAndMaxString // ignore: cast_nullable_to_non_nullable
              as String,
      minAndMaxInt: null == minAndMaxInt
          ? _value.minAndMaxInt
          : minAndMaxInt // ignore: cast_nullable_to_non_nullable
              as int,
      minAndMaxDouble: null == minAndMaxDouble
          ? _value.minAndMaxDouble
          : minAndMaxDouble // ignore: cast_nullable_to_non_nullable
              as double,
      minAndMaxNumber: null == minAndMaxNumber
          ? _value.minAndMaxNumber
          : minAndMaxNumber // ignore: cast_nullable_to_non_nullable
              as num,
      httpsLink: freezed == httpsLink
          ? _value.httpsLink
          : httpsLink // ignore: cast_nullable_to_non_nullable
              as String?,
      luthorPath: null == luthorPath
          ? _value.luthorPath
          : luthorPath // ignore: cast_nullable_to_non_nullable
              as String,
      anotherSample: null == anotherSample
          ? _value.anotherSample
          : anotherSample // ignore: cast_nullable_to_non_nullable
              as AnotherSample,
      foo: null == foo
          ? _value.foo
          : foo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AnotherSampleCopyWith<$Res> get anotherSample {
    return $AnotherSampleCopyWith<$Res>(_value.anotherSample, (value) {
      return _then(_value.copyWith(anotherSample: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SampleImplCopyWith<$Res> implements $SampleCopyWith<$Res> {
  factory _$$SampleImplCopyWith(
          _$SampleImpl value, $Res Function(_$SampleImpl) then) =
      __$$SampleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic anyValue,
      bool boolValue,
      double doubleValue,
      int intValue,
      List<String> listValue,
      num numValue,
      String stringValue,
      @isEmail String email,
      @isDateTime String date,
      DateTime dateTime,
      @HasLength(10) String? exactly10Characters,
      @HasMin(8) @HasMax(200) String minAndMaxString,
      @HasMin(2) @HasMax(4) int minAndMaxInt,
      @HasMinDouble(2.0) @HasMaxDouble(4.0) double minAndMaxDouble,
      @HasMinNumber(2) @HasMaxNumber(3.0) num minAndMaxNumber,
      @IsUri(allowedSchemes: ['https']) String? httpsLink,
      @MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor') String luthorPath,
      AnotherSample anotherSample,
      @JsonKey(name: 'jsonKeyName') String foo});

  @override
  $AnotherSampleCopyWith<$Res> get anotherSample;
}

/// @nodoc
class __$$SampleImplCopyWithImpl<$Res>
    extends _$SampleCopyWithImpl<$Res, _$SampleImpl>
    implements _$$SampleImplCopyWith<$Res> {
  __$$SampleImplCopyWithImpl(
      _$SampleImpl _value, $Res Function(_$SampleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? anyValue = freezed,
    Object? boolValue = null,
    Object? doubleValue = null,
    Object? intValue = null,
    Object? listValue = null,
    Object? numValue = null,
    Object? stringValue = null,
    Object? email = null,
    Object? date = null,
    Object? dateTime = null,
    Object? exactly10Characters = freezed,
    Object? minAndMaxString = null,
    Object? minAndMaxInt = null,
    Object? minAndMaxDouble = null,
    Object? minAndMaxNumber = null,
    Object? httpsLink = freezed,
    Object? luthorPath = null,
    Object? anotherSample = null,
    Object? foo = null,
  }) {
    return _then(_$SampleImpl(
      anyValue: freezed == anyValue
          ? _value.anyValue
          : anyValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      boolValue: null == boolValue
          ? _value.boolValue
          : boolValue // ignore: cast_nullable_to_non_nullable
              as bool,
      doubleValue: null == doubleValue
          ? _value.doubleValue
          : doubleValue // ignore: cast_nullable_to_non_nullable
              as double,
      intValue: null == intValue
          ? _value.intValue
          : intValue // ignore: cast_nullable_to_non_nullable
              as int,
      listValue: null == listValue
          ? _value._listValue
          : listValue // ignore: cast_nullable_to_non_nullable
              as List<String>,
      numValue: null == numValue
          ? _value.numValue
          : numValue // ignore: cast_nullable_to_non_nullable
              as num,
      stringValue: null == stringValue
          ? _value.stringValue
          : stringValue // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      exactly10Characters: freezed == exactly10Characters
          ? _value.exactly10Characters
          : exactly10Characters // ignore: cast_nullable_to_non_nullable
              as String?,
      minAndMaxString: null == minAndMaxString
          ? _value.minAndMaxString
          : minAndMaxString // ignore: cast_nullable_to_non_nullable
              as String,
      minAndMaxInt: null == minAndMaxInt
          ? _value.minAndMaxInt
          : minAndMaxInt // ignore: cast_nullable_to_non_nullable
              as int,
      minAndMaxDouble: null == minAndMaxDouble
          ? _value.minAndMaxDouble
          : minAndMaxDouble // ignore: cast_nullable_to_non_nullable
              as double,
      minAndMaxNumber: null == minAndMaxNumber
          ? _value.minAndMaxNumber
          : minAndMaxNumber // ignore: cast_nullable_to_non_nullable
              as num,
      httpsLink: freezed == httpsLink
          ? _value.httpsLink
          : httpsLink // ignore: cast_nullable_to_non_nullable
              as String?,
      luthorPath: null == luthorPath
          ? _value.luthorPath
          : luthorPath // ignore: cast_nullable_to_non_nullable
              as String,
      anotherSample: null == anotherSample
          ? _value.anotherSample
          : anotherSample // ignore: cast_nullable_to_non_nullable
              as AnotherSample,
      foo: null == foo
          ? _value.foo
          : foo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SampleImpl implements _Sample {
  const _$SampleImpl(
      {this.anyValue,
      required this.boolValue,
      required this.doubleValue,
      required this.intValue,
      required final List<String> listValue,
      required this.numValue,
      required this.stringValue,
      @isEmail required this.email,
      @isDateTime required this.date,
      required this.dateTime,
      @HasLength(10) this.exactly10Characters,
      @HasMin(8) @HasMax(200) required this.minAndMaxString,
      @HasMin(2) @HasMax(4) required this.minAndMaxInt,
      @HasMinDouble(2.0) @HasMaxDouble(4.0) required this.minAndMaxDouble,
      @HasMinNumber(2) @HasMaxNumber(3.0) required this.minAndMaxNumber,
      @IsUri(allowedSchemes: ['https']) this.httpsLink,
      @MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor')
      required this.luthorPath,
      required this.anotherSample,
      @JsonKey(name: 'jsonKeyName') required this.foo})
      : _listValue = listValue;

  factory _$SampleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SampleImplFromJson(json);

  @override
  final dynamic anyValue;
  @override
  final bool boolValue;
  @override
  final double doubleValue;
  @override
  final int intValue;
  final List<String> _listValue;
  @override
  List<String> get listValue {
    if (_listValue is EqualUnmodifiableListView) return _listValue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listValue);
  }

// The following will work with luthor_generator, but not with json_serializable
// Null? nullValue,
  @override
  final num numValue;
  @override
  final String stringValue;
  @override
  @isEmail
  final String email;
  @override
  @isDateTime
  final String date;
  @override
  final DateTime dateTime;
  @override
  @HasLength(10)
  final String? exactly10Characters;
  @override
  @HasMin(8)
  @HasMax(200)
  final String minAndMaxString;
  @override
  @HasMin(2)
  @HasMax(4)
  final int minAndMaxInt;
  @override
  @HasMinDouble(2.0)
  @HasMaxDouble(4.0)
  final double minAndMaxDouble;
  @override
  @HasMinNumber(2)
  @HasMaxNumber(3.0)
  final num minAndMaxNumber;
  @override
  @IsUri(allowedSchemes: ['https'])
  final String? httpsLink;
  @override
  @MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor')
  final String luthorPath;
  @override
  final AnotherSample anotherSample;
  @override
  @JsonKey(name: 'jsonKeyName')
  final String foo;

  @override
  String toString() {
    return 'Sample(anyValue: $anyValue, boolValue: $boolValue, doubleValue: $doubleValue, intValue: $intValue, listValue: $listValue, numValue: $numValue, stringValue: $stringValue, email: $email, date: $date, dateTime: $dateTime, exactly10Characters: $exactly10Characters, minAndMaxString: $minAndMaxString, minAndMaxInt: $minAndMaxInt, minAndMaxDouble: $minAndMaxDouble, minAndMaxNumber: $minAndMaxNumber, httpsLink: $httpsLink, luthorPath: $luthorPath, anotherSample: $anotherSample, foo: $foo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SampleImpl &&
            const DeepCollectionEquality().equals(other.anyValue, anyValue) &&
            (identical(other.boolValue, boolValue) ||
                other.boolValue == boolValue) &&
            (identical(other.doubleValue, doubleValue) ||
                other.doubleValue == doubleValue) &&
            (identical(other.intValue, intValue) ||
                other.intValue == intValue) &&
            const DeepCollectionEquality()
                .equals(other._listValue, _listValue) &&
            (identical(other.numValue, numValue) ||
                other.numValue == numValue) &&
            (identical(other.stringValue, stringValue) ||
                other.stringValue == stringValue) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.exactly10Characters, exactly10Characters) ||
                other.exactly10Characters == exactly10Characters) &&
            (identical(other.minAndMaxString, minAndMaxString) ||
                other.minAndMaxString == minAndMaxString) &&
            (identical(other.minAndMaxInt, minAndMaxInt) ||
                other.minAndMaxInt == minAndMaxInt) &&
            (identical(other.minAndMaxDouble, minAndMaxDouble) ||
                other.minAndMaxDouble == minAndMaxDouble) &&
            (identical(other.minAndMaxNumber, minAndMaxNumber) ||
                other.minAndMaxNumber == minAndMaxNumber) &&
            (identical(other.httpsLink, httpsLink) ||
                other.httpsLink == httpsLink) &&
            (identical(other.luthorPath, luthorPath) ||
                other.luthorPath == luthorPath) &&
            (identical(other.anotherSample, anotherSample) ||
                other.anotherSample == anotherSample) &&
            (identical(other.foo, foo) || other.foo == foo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(anyValue),
        boolValue,
        doubleValue,
        intValue,
        const DeepCollectionEquality().hash(_listValue),
        numValue,
        stringValue,
        email,
        date,
        dateTime,
        exactly10Characters,
        minAndMaxString,
        minAndMaxInt,
        minAndMaxDouble,
        minAndMaxNumber,
        httpsLink,
        luthorPath,
        anotherSample,
        foo
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SampleImplCopyWith<_$SampleImpl> get copyWith =>
      __$$SampleImplCopyWithImpl<_$SampleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SampleImplToJson(
      this,
    );
  }
}

abstract class _Sample implements Sample {
  const factory _Sample(
      {final dynamic anyValue,
      required final bool boolValue,
      required final double doubleValue,
      required final int intValue,
      required final List<String> listValue,
      required final num numValue,
      required final String stringValue,
      @isEmail required final String email,
      @isDateTime required final String date,
      required final DateTime dateTime,
      @HasLength(10) final String? exactly10Characters,
      @HasMin(8) @HasMax(200) required final String minAndMaxString,
      @HasMin(2) @HasMax(4) required final int minAndMaxInt,
      @HasMinDouble(2.0)
      @HasMaxDouble(4.0)
      required final double minAndMaxDouble,
      @HasMinNumber(2) @HasMaxNumber(3.0) required final num minAndMaxNumber,
      @IsUri(allowedSchemes: ['https']) final String? httpsLink,
      @MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor')
      required final String luthorPath,
      required final AnotherSample anotherSample,
      @JsonKey(name: 'jsonKeyName') required final String foo}) = _$SampleImpl;

  factory _Sample.fromJson(Map<String, dynamic> json) = _$SampleImpl.fromJson;

  @override
  dynamic get anyValue;
  @override
  bool get boolValue;
  @override
  double get doubleValue;
  @override
  int get intValue;
  @override
  List<String> get listValue;
  @override // The following will work with luthor_generator, but not with json_serializable
// Null? nullValue,
  num get numValue;
  @override
  String get stringValue;
  @override
  @isEmail
  String get email;
  @override
  @isDateTime
  String get date;
  @override
  DateTime get dateTime;
  @override
  @HasLength(10)
  String? get exactly10Characters;
  @override
  @HasMin(8)
  @HasMax(200)
  String get minAndMaxString;
  @override
  @HasMin(2)
  @HasMax(4)
  int get minAndMaxInt;
  @override
  @HasMinDouble(2.0)
  @HasMaxDouble(4.0)
  double get minAndMaxDouble;
  @override
  @HasMinNumber(2)
  @HasMaxNumber(3.0)
  num get minAndMaxNumber;
  @override
  @IsUri(allowedSchemes: ['https'])
  String? get httpsLink;
  @override
  @MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor')
  String get luthorPath;
  @override
  AnotherSample get anotherSample;
  @override
  @JsonKey(name: 'jsonKeyName')
  String get foo;
  @override
  @JsonKey(ignore: true)
  _$$SampleImplCopyWith<_$SampleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
