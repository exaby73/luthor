// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'another_sample.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AnotherSample _$AnotherSampleFromJson(Map<String, dynamic> json) {
  return _AnotherSample.fromJson(json);
}

/// @nodoc
mixin _$AnotherSample {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnotherSampleCopyWith<AnotherSample> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnotherSampleCopyWith<$Res> {
  factory $AnotherSampleCopyWith(
          AnotherSample value, $Res Function(AnotherSample) then) =
      _$AnotherSampleCopyWithImpl<$Res, AnotherSample>;
  @useResult
  $Res call({int id, String? name});
}

/// @nodoc
class _$AnotherSampleCopyWithImpl<$Res, $Val extends AnotherSample>
    implements $AnotherSampleCopyWith<$Res> {
  _$AnotherSampleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AnotherSampleCopyWith<$Res>
    implements $AnotherSampleCopyWith<$Res> {
  factory _$$_AnotherSampleCopyWith(
          _$_AnotherSample value, $Res Function(_$_AnotherSample) then) =
      __$$_AnotherSampleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? name});
}

/// @nodoc
class __$$_AnotherSampleCopyWithImpl<$Res>
    extends _$AnotherSampleCopyWithImpl<$Res, _$_AnotherSample>
    implements _$$_AnotherSampleCopyWith<$Res> {
  __$$_AnotherSampleCopyWithImpl(
      _$_AnotherSample _value, $Res Function(_$_AnotherSample) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
  }) {
    return _then(_$_AnotherSample(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AnotherSample implements _AnotherSample {
  const _$_AnotherSample({required this.id, this.name});

  factory _$_AnotherSample.fromJson(Map<String, dynamic> json) =>
      _$$_AnotherSampleFromJson(json);

  @override
  final int id;
  @override
  final String? name;

  @override
  String toString() {
    return 'AnotherSample(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnotherSample &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AnotherSampleCopyWith<_$_AnotherSample> get copyWith =>
      __$$_AnotherSampleCopyWithImpl<_$_AnotherSample>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AnotherSampleToJson(
      this,
    );
  }
}

abstract class _AnotherSample implements AnotherSample {
  const factory _AnotherSample({required final int id, final String? name}) =
      _$_AnotherSample;

  factory _AnotherSample.fromJson(Map<String, dynamic> json) =
      _$_AnotherSample.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_AnotherSampleCopyWith<_$_AnotherSample> get copyWith =>
      throw _privateConstructorUsedError;
}
