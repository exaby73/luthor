import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'signup_form.freezed.dart';
part 'signup_form.g.dart';

// Schema custom validation function for password confirmation
bool passwordsMatch(Object? value, Map<String, Object?> data) {
  return value == data['password'];
}

// Another example for numeric comparison
bool isGreaterThanMinAge(Object? value, Map<String, Object?> data) {
  if (value is int && data['minAge'] is int) {
    return value > (data['minAge'] as int);
  }
  return false;
}

@luthor
@freezed
abstract class SignupForm with _$SignupForm {
  const factory SignupForm({
    @IsEmail() required String email,
    @HasMin(8) required String password,
    @WithSchemaCustomValidator(passwordsMatch, message: 'Passwords must match')
    required String confirmPassword,
    required int minAge,
    @WithSchemaCustomValidator(isGreaterThanMinAge, message: 'Max age must be greater than min age')
    required int maxAge,
  }) = _SignupForm;

  factory SignupForm.fromJson(Map<String, dynamic> json) =>
      _$SignupFormFromJson(json);
}

void main() {
  // Test valid data
  final validData = {
    'email': 'user@example.com',
    'password': 'password123',
    'confirmPassword': 'password123',
    'minAge': 18,
    'maxAge': 65,
  };

  print('=== Valid Data Test ===');
  final validResult = $SignupFormValidate(validData);
  switch (validResult) {
    case SchemaValidationSuccess(data: final data):
      print('✅ Validation passed: $data');
    case SchemaValidationError(errors: final errors):
      print('❌ Unexpected validation failure: $errors');
  }

  // Test invalid data - mismatched passwords
  final invalidPasswordData = {
    'email': 'user@example.com',
    'password': 'password123',
    'confirmPassword': 'different_password',
    'minAge': 18,
    'maxAge': 65,
  };

  print('\n=== Invalid Password Test ===');
  final invalidPasswordResult = $SignupFormValidate(invalidPasswordData);
  switch (invalidPasswordResult) {
    case SchemaValidationSuccess(data: final data):
      print('❌ Unexpected validation pass: $data');
    case SchemaValidationError(errors: final errors):
      print('✅ Validation failed as expected: $errors');
      final errorResult = invalidPasswordResult as SchemaValidationError;
      print('Password confirmation error: ${errorResult.getError(SignupFormErrorKeys.confirmPassword)}');
  }

  // Test invalid data - age comparison
  final invalidAgeData = {
    'email': 'user@example.com',
    'password': 'password123',
    'confirmPassword': 'password123',
    'minAge': 65,
    'maxAge': 18, // maxAge < minAge (should fail)
  };

  print('\n=== Invalid Age Test ===');
  final invalidAgeResult = $SignupFormValidate(invalidAgeData);
  switch (invalidAgeResult) {
    case SchemaValidationSuccess(data: final data):
      print('❌ Unexpected validation pass: $data');
    case SchemaValidationError(errors: final errors):
      print('✅ Validation failed as expected: $errors');
      final errorResult = invalidAgeResult as SchemaValidationError;
      print('Max age error: ${errorResult.getError(SignupFormErrorKeys.maxAge)}');
  }

  // Test using SchemaKeys for type-safe field access
  print('\n=== Schema Keys Test ===');
  print('Email key: ${SignupFormSchemaKeys.email}');
  print('Password key: ${SignupFormSchemaKeys.password}');
  print('Confirm password key: ${SignupFormSchemaKeys.confirmPassword}');
}