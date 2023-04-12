import 'package:band_core/band_core.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid email', () {
    final result = b.email().validate('user@example.com');
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false when value is not a valid email', () {
    final result = b.email().validate('user');
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be a valid email address');
  });

  test('should return false if the value is null with required()', () {
    final result = b.required().email().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });
}
