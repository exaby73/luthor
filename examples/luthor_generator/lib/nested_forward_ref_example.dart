import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'nested_forward_ref_example.freezed.dart';
part 'nested_forward_ref_example.g.dart';

/// Example showing nested self-references and when @luthorForwardRef is needed
@luthor
@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String username,
    // Automatic detection: List<Comment> contains Comment which matches... wait, no!
    // User.comments is List<Comment>, but we're in User class, so Comment doesn't match User.
    // This is NOT auto-detected because Comment ≠ User.
    // But if Comment has User? user field, that also won't be auto-detected from Comment's perspective.
    // So explicit annotation is needed for cross-class circular references.
    List<Comment>? comments,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

/// Example showing nested self-references and when @luthorForwardRef is needed
@luthor
@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required String id,
    required String text,
    // Automatic detection: List<Comment> is automatically detected as self-reference
    List<Comment>? replies,
    // Direct self-reference: Comment? parent is also automatically detected
    Comment? parent,
    // Nested self-reference: Map<String, Comment> is auto-detected because
    // Comment (the value type) matches the enclosing class
    Map<String, Comment>? mentions,
    // Cross-class circular reference: User.comments contains List<Comment>,
    // but from Comment's perspective, we only see User (not Comment), so auto-detection fails.
    // Explicit annotation is required.
    @luthorForwardRef User? user,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

void main() {
  // Test nested self-referential schema with cross-class circular reference
  final data = {
    'id': '1',
    'text': 'Root comment',
    'replies': [
      {
        'id': '2',
        'text': 'Reply 1',
        'replies': [
          {
            'id': '3',
            'text': 'Nested reply',
            'replies': null,
            'parent': null,
            'mentions': null,
            'user': null,
          },
        ],
        'parent': null,
        'mentions': null,
        'user': {'id': 'user1', 'username': 'john_doe', 'comments': null},
      },
      {
        'id': '4',
        'text': 'Reply 2',
        'replies': null,
        'parent': null,
        'mentions': {
          'user1': {
            'id': '5',
            'text': 'Mentioned comment',
            'replies': null,
            'parent': null,
            'mentions': null,
            'user': null,
          },
        },
        'user': null,
      },
    ],
    'parent': null,
    'mentions': null,
    'user': {
      'id': 'user2',
      'username': 'jane_smith',
      'comments': [
        {
          'id': '6',
          'text': 'User comment',
          'replies': null,
          'parent': null,
          'mentions': null,
          'user': null,
        },
      ],
    },
  };

  final result = $CommentValidate(data);
  switch (result) {
    case SchemaValidationError(errors: final errors):
      print('Validation failed:');
      errors.forEach((key, value) {
        print('$key: $value');
      });
    case SchemaValidationSuccess(data: final data):
      print('Validation succeeded!');
      print('Comment ID: ${data.id}');
      print('Comment text: ${data.text}');
      print('Replies count: ${data.replies?.length ?? 0}');
      print('Has parent: ${data.parent != null}');
      print('Mentions count: ${data.mentions?.length ?? 0}');
      print('User: ${data.user?.username ?? 'none'}');
      if (data.user != null) {
        print('User comments count: ${data.user!.comments?.length ?? 0}');
      }
  }
}
