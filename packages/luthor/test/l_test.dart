import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return the custom message when provided', () {
    final result = l.string(message: 'custom message').validate(1);
    expect(result.isValid, isFalse);
    expect(result.message, 'custom message');
  });

  group('validateWithFieldName', () {
    test('should have the fieldName in the error message', () {
      final result = l.required().string().validateWithFieldName('name', null);
      expect(result.isValid, isFalse);
      expect(result.message, 'name is required');
    });
  });
}
