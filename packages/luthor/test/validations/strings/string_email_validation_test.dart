import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid email', () {
    final result = l.string().email().validate('user@example.com');
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false when value is not a valid email', () {
    final result = l.string().email().validate('user');
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be a valid email address');
  });

  test('should return true when value is null', () {
    final result = l.string().email().validate(null);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().email().required().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });
}
