// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'without_freezed.dart';

class WithDartMappableMapper extends ClassMapperBase<WithDartMappable> {
  WithDartMappableMapper._();

  static WithDartMappableMapper? _instance;
  static WithDartMappableMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WithDartMappableMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WithDartMappable';

  static String _$email(WithDartMappable v) => v.email;
  static const Field<WithDartMappable, String> _f$email =
      Field('email', _$email);
  static String _$password(WithDartMappable v) => v.password;
  static const Field<WithDartMappable, String> _f$password =
      Field('password', _$password);

  @override
  final MappableFields<WithDartMappable> fields = const {
    #email: _f$email,
    #password: _f$password,
  };

  static WithDartMappable _instantiate(DecodingData data) {
    return WithDartMappable(
        email: data.dec(_f$email), password: data.dec(_f$password));
  }

  @override
  final Function instantiate = _instantiate;

  static WithDartMappable fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WithDartMappable>(map);
  }

  static WithDartMappable fromJson(String json) {
    return ensureInitialized().decodeJson<WithDartMappable>(json);
  }
}

mixin WithDartMappableMappable {
  String toJson() {
    return WithDartMappableMapper.ensureInitialized()
        .encodeJson<WithDartMappable>(this as WithDartMappable);
  }

  Map<String, dynamic> toMap() {
    return WithDartMappableMapper.ensureInitialized()
        .encodeMap<WithDartMappable>(this as WithDartMappable);
  }

  WithDartMappableCopyWith<WithDartMappable, WithDartMappable, WithDartMappable>
      get copyWith => _WithDartMappableCopyWithImpl(
          this as WithDartMappable, $identity, $identity);
  @override
  String toString() {
    return WithDartMappableMapper.ensureInitialized()
        .stringifyValue(this as WithDartMappable);
  }

  @override
  bool operator ==(Object other) {
    return WithDartMappableMapper.ensureInitialized()
        .equalsValue(this as WithDartMappable, other);
  }

  @override
  int get hashCode {
    return WithDartMappableMapper.ensureInitialized()
        .hashValue(this as WithDartMappable);
  }
}

extension WithDartMappableValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WithDartMappable, $Out> {
  WithDartMappableCopyWith<$R, WithDartMappable, $Out>
      get $asWithDartMappable =>
          $base.as((v, t, t2) => _WithDartMappableCopyWithImpl(v, t, t2));
}

abstract class WithDartMappableCopyWith<$R, $In extends WithDartMappable, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? email, String? password});
  WithDartMappableCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _WithDartMappableCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WithDartMappable, $Out>
    implements WithDartMappableCopyWith<$R, WithDartMappable, $Out> {
  _WithDartMappableCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WithDartMappable> $mapper =
      WithDartMappableMapper.ensureInitialized();
  @override
  $R call({String? email, String? password}) => $apply(FieldCopyWithData({
        if (email != null) #email: email,
        if (password != null) #password: password
      }));
  @override
  WithDartMappable $make(CopyWithData data) => WithDartMappable(
      email: data.get(#email, or: $value.email),
      password: data.get(#password, or: $value.password));

  @override
  WithDartMappableCopyWith<$R2, WithDartMappable, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WithDartMappableCopyWithImpl($value, $cast, t);
}
