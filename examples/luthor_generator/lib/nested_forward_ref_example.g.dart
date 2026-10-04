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

Validator $UserSchema = l.withName('User').schema({
  UserSchemaKeys.id: l.string().required(),
  UserSchemaKeys.username: l.string().required(),
  UserSchemaKeys.comments: l.list(validators: [$CommentSchema.required()]),
});

SchemaValidationResult<User> $UserValidate(Map<String, dynamic> json) =>
    $UserSchema.validateSchema(json, fromJson: User.fromJson);

extension UserValidationExtension on User {
  SchemaValidationResult<User> validateSelf() => $UserValidate(toJson());
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

Validator $CommentSchema = l.withName('Comment').schema({
  CommentSchemaKeys.id: l.string().required(),
  CommentSchemaKeys.text: l.string().required(),
  CommentSchemaKeys.replies: l.list(
    validators: [forwardRef(() => $CommentSchema.required())],
  ),
  CommentSchemaKeys.parent: forwardRef(() => $CommentSchema),
  CommentSchemaKeys.mentions: l.map(
    keyValidator: l.string().required(),
    valueValidator: forwardRef(() => $CommentSchema.required()),
  ),
  CommentSchemaKeys.user: forwardRef(() => $UserSchema),
});

SchemaValidationResult<Comment> $CommentValidate(Map<String, dynamic> json) =>
    $CommentSchema.validateSchema(json, fromJson: Comment.fromJson);

extension CommentValidationExtension on Comment {
  SchemaValidationResult<Comment> validateSelf() => $CommentValidate(toJson());
}

// ignore: constant_identifier_names
const CommentErrorKeys = (
  id: "id",
  text: "text",
  replies: "replies",
  parent: (
    id: "parent.id",
    text: "parent.text",
    replies: "parent.replies",
    parent: "parent.parent",
    mentions: "parent.mentions",
    user: (
      id: "parent.user.id",
      username: "parent.user.username",
      comments: "parent.user.comments",
    ),
  ),
  mentions: "mentions",
  user: (id: "user.id", username: "user.username", comments: "user.comments"),
);
