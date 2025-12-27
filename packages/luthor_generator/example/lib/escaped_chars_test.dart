// Test case for escaped characters in message strings
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'escaped_chars_test.freezed.dart';
part 'escaped_chars_test.g.dart';

@luthor
@freezed
abstract class EscapedCharsTest with _$EscapedCharsTest {
  const factory EscapedCharsTest({
    // Test various escaped characters in message strings
    @HasMin(5, message: 'Must be at least 5 characters\nPlease try again')
    required String field1,
    @HasMax(10, message: 'Line 1\nLine 2\tTabbed')
    required String field2,
    @IsEmail(message: 'Invalid email\r\nPlease check')
    required String field3,
    @MatchRegex(r'^\d+$', message: 'Must contain only digits\nNo letters allowed')
    required String field4,
  }) = _EscapedCharsTest;

  factory EscapedCharsTest.fromJson(Map<String, dynamic> json) =>
      _$EscapedCharsTestFromJson(json);
}

void main() {
  print('Testing escaped characters in validation messages...');
  
  final result = $EscapedCharsTestValidate({
    'field1': 'abc',  // Too short
    'field2': 'this is way too long',  // Too long
    'field3': 'not-an-email',  // Invalid email
    'field4': 'abc123',  // Contains letters
  });

  switch (result) {
    case SchemaValidationError(errors: final errors):
      print('Validation errors (as expected):');
      errors.forEach((key, value) {
        print('  $key: $value');
      });
    case SchemaValidationSuccess():
      print('Unexpected success');
  }
}
