// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strict_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invite _$InviteFromJson(Map<String, dynamic> json) =>
    Invite(email: json['email'] as String, note: json['note'] as String?);

Map<String, dynamic> _$InviteToJson(Invite instance) => <String, dynamic>{
  'email': instance.email,
  'note': instance.note,
};

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const InviteSchemaKeys = (email: "email", note: "note");

final SchemaValidator $InviteSchema = l
    .schema({
      InviteSchemaKeys.email: l.string().email().required(),
      InviteSchemaKeys.note: l.string(),
    })
    .strict()
    .withName("Invite");

ValidationResult<Invite> $InviteValidate(Object? json) =>
    $InviteSchema.validateSchema(json, fromJson: Invite.fromJson);

extension InviteValidationExtension on Invite {
  ValidationResult<Invite> validateSelf() =>
      $InviteValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const InviteErrorKeys = (email: "email", note: "note");

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
