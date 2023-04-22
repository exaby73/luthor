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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
  @HasLength(10)
  String? get exactly10Characters => throw _privateConstructorUsedError;
  @HasMin(8)
  @HasMax(200)
  String get minAndMax => throw _privateConstructorUsedError;
  @IsUri(allowedSchemes: ['https'])
  String? get httpsLink => throw _privateConstructorUsedError;
  AnotherSample get anotherSample => throw _privateConstructorUsedError;

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
      @HasLength(10) String? exactly10Characters,
      @HasMin(8) @HasMax(200) String minAndMax,
      @IsUri(allowedSchemes: ['https']) String? httpsLink,
      AnotherSample anotherSample});

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
    Object? exactly10Characters = freezed,
    Object? minAndMax = null,
    Object? httpsLink = freezed,
    Object? anotherSample = null,
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
      exactly10Characters: freezed == exactly10Characters
          ? _value.exactly10Characters
          : exactly10Characters // ignore: cast_nullable_to_non_nullable
              as String?,
      minAndMax: null == minAndMax
          ? _value.minAndMax
          : minAndMax // ignore: cast_nullable_to_non_nullable
              as String,
      httpsLink: freezed == httpsLink
          ? _value.httpsLink
          : httpsLink // ignore: cast_nullable_to_non_nullable
              as String?,
      anotherSample: null == anotherSample
          ? _value.anotherSample
          : anotherSample // ignore: cast_nullable_to_non_nullable
              as AnotherSample,
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
abstract class _$$_SampleCopyWith<$Res> implements $SampleCopyWith<$Res> {
  factory _$$_SampleCopyWith(_$_Sample value, $Res Function(_$_Sample) then) =
      __$$_SampleCopyWithImpl<$Res>;
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
      @HasLength(10) String? exactly10Characters,
      @HasMin(8) @HasMax(200) String minAndMax,
      @IsUri(allowedSchemes: ['https']) String? httpsLink,
      AnotherSample anotherSample});

  @override
  $AnotherSampleCopyWith<$Res> get anotherSample;
}

/// @nodoc
class __$$_SampleCopyWithImpl<$Res>
    extends _$SampleCopyWithImpl<$Res, _$_Sample>
    implements _$$_SampleCopyWith<$Res> {
  __$$_SampleCopyWithImpl(_$_Sample _value, $Res Function(_$_Sample) _then)
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
    Object? exactly10Characters = freezed,
    Object? minAndMax = null,
    Object? httpsLink = freezed,
    Object? anotherSample = null,
  }) {
    return _then(_$_Sample(
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
      exactly10Characters: freezed == exactly10Characters
          ? _value.exactly10Characters
          : exactly10Characters // ignore: cast_nullable_to_non_nullable
              as String?,
      minAndMax: null == minAndMax
          ? _value.minAndMax
          : minAndMax // ignore: cast_nullable_to_non_nullable
              as String,
      httpsLink: freezed == httpsLink
          ? _value.httpsLink
          : httpsLink // ignore: cast_nullable_to_non_nullable
              as String?,
      anotherSample: null == anotherSample
          ? _value.anotherSample
          : anotherSample // ignore: cast_nullable_to_non_nullable
              as AnotherSample,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Sample implements _Sample {
  const _$_Sample(
      {this.anyValue,
      required this.boolValue,
      required this.doubleValue,
      required this.intValue,
      required final List<String> listValue,
      required this.numValue,
      required this.stringValue,
      @isEmail required this.email,
      @isDateTime required this.date,
      @HasLength(10) this.exactly10Characters,
      @HasMin(8) @HasMax(200) required this.minAndMax,
      @IsUri(allowedSchemes: ['https']) this.httpsLink,
      required this.anotherSample})
      : _listValue = listValue;

  factory _$_Sample.fromJson(Map<String, dynamic> json) =>
      _$$_SampleFromJson(json);

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
  @HasLength(10)
  final String? exactly10Characters;
  @override
  @HasMin(8)
  @HasMax(200)
  final String minAndMax;
  @override
  @IsUri(allowedSchemes: ['https'])
  final String? httpsLink;
  @override
  final AnotherSample anotherSample;

  @override
  String toString() {
    return 'Sample(anyValue: $anyValue, boolValue: $boolValue, doubleValue: $doubleValue, intValue: $intValue, listValue: $listValue, numValue: $numValue, stringValue: $stringValue, email: $email, date: $date, exactly10Characters: $exactly10Characters, minAndMax: $minAndMax, httpsLink: $httpsLink, anotherSample: $anotherSample)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Sample &&
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
            (identical(other.exactly10Characters, exactly10Characters) ||
                other.exactly10Characters == exactly10Characters) &&
            (identical(other.minAndMax, minAndMax) ||
                other.minAndMax == minAndMax) &&
            (identical(other.httpsLink, httpsLink) ||
                other.httpsLink == httpsLink) &&
            (identical(other.anotherSample, anotherSample) ||
                other.anotherSample == anotherSample));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
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
      exactly10Characters,
      minAndMax,
      httpsLink,
      anotherSample);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SampleCopyWith<_$_Sample> get copyWith =>
      __$$_SampleCopyWithImpl<_$_Sample>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SampleToJson(
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
      @HasLength(10) final String? exactly10Characters,
      @HasMin(8) @HasMax(200) required final String minAndMax,
      @IsUri(allowedSchemes: ['https']) final String? httpsLink,
      required final AnotherSample anotherSample}) = _$_Sample;

  factory _Sample.fromJson(Map<String, dynamic> json) = _$_Sample.fromJson;

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
  @HasLength(10)
  String? get exactly10Characters;
  @override
  @HasMin(8)
  @HasMax(200)
  String get minAndMax;
  @override
  @IsUri(allowedSchemes: ['https'])
  String? get httpsLink;
  @override
  AnotherSample get anotherSample;
  @override
  @JsonKey(ignore: true)
  _$$_SampleCopyWith<_$_Sample> get copyWith =>
      throw _privateConstructorUsedError;
}
