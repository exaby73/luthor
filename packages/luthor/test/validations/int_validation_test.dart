import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is an int', () {
    final result = l.int().validate(1);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false when value is a double', () {
    final result = l.int().validate(1.1);

    result.when(
      error: (message) {
        expect(message, 'value must be an integer');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return false when value is not an int', () {
    final result = l.int().validate('a');

    result.when(
      error: (message) {
        expect(message, 'value must be an integer');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return true when value is null', () {
    final result = l.int().validate(null);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().int().validate(null);

    result.when(
      error: (message) {
        expect(message, 'value is required');
      },
      success: (_) => fail('should not be success'),
    );
  });
}
