import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'auto_generation_test.freezed.dart';
part 'auto_generation_test.g.dart';

// External class without @luthor annotation but compatible for auto-generation
@freezed
abstract class ExternalUser with _$ExternalUser {
  const factory ExternalUser({
    required String name,
    required String email,
    int? age,
  }) = _ExternalUser;

  factory ExternalUser.fromJson(Map<String, dynamic> json) =>
      _$ExternalUserFromJson(json);
}

// Class with @luthor annotation that references ExternalUser
@luthor
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    required ExternalUser user,
    ExternalUser? user2,
    List<ExternalUser>? friends,
    required List<String> tags,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

void main() {
  final json = {
    'id': 1,
    'user': {'name': 'John Doe', 'email': 'john@example.com', 'age': 30},
    // 'user2': null, // Test omitting nullable field
    'friends': [
      {'name': 'Jane Smith', 'email': 'jane@example.com'},
    ],
    'tags': ['developer', 'flutter'],
    'createdAt': '2021-01-01T00:00:00Z',
    'updatedAt': null, // Test nullable DateTime
  };

  final result = $UserProfileValidate(json);
  switch (result) {
    case SchemaValidationSuccess(data: final data):
      print('Success: $data');
    case SchemaValidationError(errors: final errors):
      print('Validation errors:');
      errors.forEach((key, value) {
        print('$key: $value');
      });
  }
}
