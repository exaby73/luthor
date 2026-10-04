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

Validator $UserProfileSchema = l.withName('UserProfile').schema({
  UserProfileSchemaKeys.id: l.int().required(),
  UserProfileSchemaKeys.user: $ExternalUserSchema.required(),
  UserProfileSchemaKeys.user2: $ExternalUserSchema,
  UserProfileSchemaKeys.friends: l.list(
    validators: [$ExternalUserSchema.required()],
  ),
  UserProfileSchemaKeys.tags: l
      .list(validators: [l.string().required()])
      .required(),
  UserProfileSchemaKeys.createdAt: l.string().dateTime().required(),
  UserProfileSchemaKeys.updatedAt: l.string(),
});

SchemaValidationResult<UserProfile> $UserProfileValidate(
  Map<String, dynamic> json,
) => $UserProfileSchema.validateSchema(json, fromJson: UserProfile.fromJson);

extension UserProfileValidationExtension on UserProfile {
  SchemaValidationResult<UserProfile> validateSelf() =>
      $UserProfileValidate(toJson());
}

// ignore: constant_identifier_names
const UserProfileErrorKeys = (
  id: "id",
  user: (name: "user.name", email: "user.email", age: "user.age"),
  user2: (name: "user2.name", email: "user2.email", age: "user2.age"),
  friends: "friends",
  tags: "tags",
  createdAt: "createdAt",
  updatedAt: "updatedAt",
);

// Auto-generated schemas for discovered classes

// ignore: constant_identifier_names
const ExternalUserSchemaKeys = (name: "name", email: "email", age: "age");

Validator $ExternalUserSchema = l.withName('ExternalUser').schema({
  ExternalUserSchemaKeys.name: l.string().required(),
  ExternalUserSchemaKeys.email: l.string().required(),
  ExternalUserSchemaKeys.age: l.int(),
});

SchemaValidationResult<ExternalUser> $ExternalUserValidate(
  Map<String, dynamic> json,
) => $ExternalUserSchema.validateSchema(json, fromJson: ExternalUser.fromJson);

extension ExternalUserValidationExtension on ExternalUser {
  SchemaValidationResult<ExternalUser> validateSelf() =>
      $ExternalUserValidate(toJson());
}

// ignore: constant_identifier_names
const ExternalUserErrorKeys = (name: "name", email: "email", age: "age");
