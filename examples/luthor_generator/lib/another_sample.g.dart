// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'another_sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnotherSample _$AnotherSampleFromJson(Map<String, dynamic> json) =>
    _AnotherSample(
      id: (json['id'] as num).toInt(),
      name: json['full_name'] as String?,
      email: json['email'] as String,
      ip: json['ip'] as String?,
      password: json['password'] as String,
      type: json['type'] as String? ?? 'user',
      url: json['url'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$RoleEnumMap, e))
              .toList() ??
          const [Role.member],
    );

Map<String, dynamic> _$AnotherSampleToJson(_AnotherSample instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.name,
      'email': instance.email,
      'ip': instance.ip,
      'password': instance.password,
      'type': instance.type,
      'url': instance.url,
      'roles': instance.roles.map((e) => _$RoleEnumMap[e]!).toList(),
    };

const _$RoleEnumMap = {Role.admin: 'admin', Role.member: 'member'};

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const AnotherSampleSchemaKeys = (
  id: "id",
  name: "full_name",
  email: "email",
  ip: "ip",
  password: "password",
  type: "type",
  url: "url",
  roles: "roles",
);

final SchemaValidator $AnotherSampleSchema = l
    .schema({
      AnotherSampleSchemaKeys.id: l.int().required(),
      AnotherSampleSchemaKeys.name: l.string(),
      AnotherSampleSchemaKeys.email: l
          .string()
          .email(message: "Invalid email")
          .required(),
      AnotherSampleSchemaKeys.ip: l.string().ip(version: IpVersion.v4),
      AnotherSampleSchemaKeys.password: l.string().min(8).required(),
      AnotherSampleSchemaKeys.type: l.string(),
      AnotherSampleSchemaKeys.url: l.string().url(
        allowedSchemes: ["http", "https"],
      ),
      AnotherSampleSchemaKeys.roles: l.list(
        l.oneOf(["admin", "member"]).required(),
      ),
    })
    .withName("AnotherSample");

ValidationResult<AnotherSample> $AnotherSampleValidate(Object? json) =>
    $AnotherSampleSchema.validateSchema(json, fromJson: AnotherSample.fromJson);

extension AnotherSampleValidationExtension on AnotherSample {
  ValidationResult<AnotherSample> validateSelf() =>
      $AnotherSampleValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const AnotherSampleErrorKeys = (
  id: "id",
  name: "full_name",
  email: "email",
  ip: "ip",
  password: "password",
  type: "type",
  url: "url",
  roles: "roles",
);

Map<String, Object?> _$luthorJsonMap(Map<Object?, Object?> map) => {
  for (final entry in map.entries)
    entry.key.toString(): _$luthorJsonValue(entry.value),
};

Object? _$luthorJsonValue(Object? value) {
  if (value == null || value is String || value is num || value is bool) {
    return value;
  }
  if (value is Map) return _$luthorJsonMap(value);
  if (value is Iterable) {
    return [for (final item in value) _$luthorJsonValue(item)];
  }
  try {
    // ignore: avoid_dynamic_calls
    return _$luthorJsonValue((value as dynamic).toJson());
    // ignore: avoid_catching_errors
  } on NoSuchMethodError {
    return value;
  }
}
