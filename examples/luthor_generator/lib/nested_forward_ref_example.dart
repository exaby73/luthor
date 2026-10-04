import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'nested_forward_ref_example.freezed.dart';
part 'nested_forward_ref_example.g.dart';

/// Nested schema references are always lazy, so models that refer to each
/// other need no annotation.
@luthor
@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String username,
    List<Comment>? comments,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

/// Self-references through lists, maps and nullable fields validate every
/// level.
@luthor
@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required String id,
    required String text,
    List<Comment>? replies,
    Comment? parent,
    Map<String, Comment>? mentions,
    User? user,
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
    case ValidationFailure(:final errors):
      print('Validation failed:');
      errors.forEach((key, value) {
        print('$key: $value');
      });
    case ValidationSuccess(:final data):
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

  // Errors in nested levels are reported at their full path.
  final invalid = $CommentValidate({
    'id': '1',
    'text': 'Root comment',
    'replies': [
      {
        'id': '2',
        'text': 'Reply',
        'replies': [
          {'id': '3', 'text': 42},
        ],
      },
    ],
  });
  print(invalid.errors);
}
