// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_generation_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExternalUser _$ExternalUserFromJson(Map<String, dynamic> json) =>
    _ExternalUser(
      name: json['name'] as String,
      email: json['email'] as String,
      age: (json['age'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExternalUserToJson(_ExternalUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'age': instance.age,
    };

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: (json['id'] as num).toInt(),
  user: ExternalUser.fromJson(json['user'] as Map<String, dynamic>),
  user2: json['user2'] == null
      ? null
      : ExternalUser.fromJson(json['user2'] as Map<String, dynamic>),
  friends: (json['friends'] as List<dynamic>?)
      ?.map((e) => ExternalUser.fromJson(e as Map<String, dynamic>))
      .toList(),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'user2': instance.user2,
      'friends': instance.friends,
      'tags': instance.tags,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const UserProfileSchemaKeys = (
  id: "id",
  user: "user",
  user2: "user2",
  friends: "friends",
  tags: "tags",
  createdAt: "createdAt",
  updatedAt: "updatedAt",
);

final SchemaValidator $UserProfileSchema = l
    .schema({
      UserProfileSchemaKeys.id: l.int().required(),
      UserProfileSchemaKeys.user: forwardRef(
        () => _$ExternalUserSchema.required(),
      ),
      UserProfileSchemaKeys.user2: forwardRef(() => _$ExternalUserSchema),
      UserProfileSchemaKeys.friends: l.list(
        forwardRef(() => _$ExternalUserSchema.required()),
      ),
      UserProfileSchemaKeys.tags: l.list(l.string().required()).required(),
      UserProfileSchemaKeys.createdAt: l.string().dateTime().required(),
      UserProfileSchemaKeys.updatedAt: l.string().dateTime(),
    })
    .withName("UserProfile");

ValidationResult<UserProfile> $UserProfileValidate(Object? json) =>
    $UserProfileSchema.validateSchema(json, fromJson: UserProfile.fromJson);

extension UserProfileValidationExtension on UserProfile {
  ValidationResult<UserProfile> validateSelf() =>
      $UserProfileValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const UserProfileErrorKeys = (
  id: "id",
  user: ($key: "user", name: "user.name", email: "user.email", age: "user.age"),
  user2: (
    $key: "user2",
    name: "user2.name",
    email: "user2.email",
    age: "user2.age",
  ),
  friends: "friends",
  tags: "tags",
  createdAt: "createdAt",
  updatedAt: "updatedAt",
);

final SchemaValidator _$ExternalUserSchema = l
    .schema({
      "name": l.string().required(),
      "email": l.string().required(),
      "age": l.int(),
    })
    .withName("ExternalUser");

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
