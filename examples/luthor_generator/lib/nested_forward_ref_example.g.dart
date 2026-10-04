// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nested_forward_ref_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  username: json['username'] as String,
  comments: (json['comments'] as List<dynamic>?)
      ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'comments': instance.comments,
};

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
  id: json['id'] as String,
  text: json['text'] as String,
  replies: (json['replies'] as List<dynamic>?)
      ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
      .toList(),
  parent: json['parent'] == null
      ? null
      : Comment.fromJson(json['parent'] as Map<String, dynamic>),
  mentions: (json['mentions'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, Comment.fromJson(e as Map<String, dynamic>)),
  ),
  user: json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'replies': instance.replies,
  'parent': instance.parent,
  'mentions': instance.mentions,
  'user': instance.user,
};

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const UserSchemaKeys = (id: "id", username: "username", comments: "comments");

final SchemaValidator $UserSchema = l
    .schema({
      UserSchemaKeys.id: l.string().required(),
      UserSchemaKeys.username: l.string().required(),
      UserSchemaKeys.comments: l.list(
        forwardRef(() => $CommentSchema.required()),
      ),
    })
    .withName("User");

ValidationResult<User> $UserValidate(Object? json) =>
    $UserSchema.validateSchema(json, fromJson: User.fromJson);

extension UserValidationExtension on User {
  ValidationResult<User> validateSelf() =>
      $UserValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const UserErrorKeys = (id: "id", username: "username", comments: "comments");

// ignore: constant_identifier_names
const CommentSchemaKeys = (
  id: "id",
  text: "text",
  replies: "replies",
  parent: "parent",
  mentions: "mentions",
  user: "user",
);

final SchemaValidator $CommentSchema = l
    .schema({
      CommentSchemaKeys.id: l.string().required(),
      CommentSchemaKeys.text: l.string().required(),
      CommentSchemaKeys.replies: l.list(
        forwardRef(() => $CommentSchema.required()),
      ),
      CommentSchemaKeys.parent: forwardRef(() => $CommentSchema),
      CommentSchemaKeys.mentions: l.map(
        keyValidator: l.string().required(),
        valueValidator: forwardRef(() => $CommentSchema.required()),
      ),
      CommentSchemaKeys.user: forwardRef(() => $UserSchema),
    })
    .withName("Comment");

ValidationResult<Comment> $CommentValidate(Object? json) =>
    $CommentSchema.validateSchema(json, fromJson: Comment.fromJson);

extension CommentValidationExtension on Comment {
  ValidationResult<Comment> validateSelf() =>
      $CommentValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const CommentErrorKeys = (
  id: "id",
  text: "text",
  replies: "replies",
  parent: "parent",
  mentions: "mentions",
  user: (
    $key: "user",
    id: "user.id",
    username: "user.username",
    comments: "user.comments",
  ),
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
