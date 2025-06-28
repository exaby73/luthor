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
      friends: (json['friends'] as List<dynamic>?)
          ?.map((e) => ExternalUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'friends': instance.friends,
      'tags': instance.tags,
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

Validator $UserProfileSchema = l.withName('UserProfile').schema({
  'id': l.int().required(),
  'user': $ExternalUserSchema.required(),
  'friends': l.list(validators: [$ExternalUserSchema.required()]),
  'tags': l.list(validators: [l.string().required()]).required(),
});

SchemaValidationResult<UserProfile> $UserProfileValidate(
        Map<String, dynamic> json) =>
    $UserProfileSchema.validateSchema(json, fromJson: UserProfile.fromJson);

extension UserProfileValidationExtension on UserProfile {
  SchemaValidationResult<UserProfile> validateSelf() =>
      $UserProfileValidate(toJson());
}

// Auto-generated schemas for discovered classes
Validator $ExternalUserSchema = l.withName('ExternalUser').schema({
  'name': l.string().required(),
  'email': l.string().required(),
  'age': l.int(),
});

SchemaValidationResult<ExternalUser> $ExternalUserValidate(
        Map<String, dynamic> json) =>
    $ExternalUserSchema.validateSchema(json, fromJson: ExternalUser.fromJson);

extension ExternalUserValidationExtension on ExternalUser {
  SchemaValidationResult<ExternalUser> validateSelf() =>
      $ExternalUserValidate(toJson());
}
