import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid email', () {
    final result = l.string().email().validate('user@example.com');
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false when value is not a valid email', () {
    final result = l.string().email().validate('user');

    result.when(
      error: (message) {
        expect(message, 'value must be a valid email address');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return true when value is null', () {
    final result = l.string().email().validate(null);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().email().required().validate(null);

    result.when(
      error: (message) {
        expect(message, 'value is required');
      },
      success: (_) => fail('should not be success'),
    );
  });
}
