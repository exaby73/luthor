import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is an double', () {
    final result = l.double().validate(1.1);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false when value is an int', () {
    final result = l.double().validate(1);

    result.when(
      error: (message) {
        expect(message, 'value must be a double');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return false when value is not an double', () {
    final result = l.double().validate('a');

    result.when(
      error: (message) {
        expect(message, 'value must be a double');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return true when value is null', () {
    final result = l.double().validate(null);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().double().validate(null);

    result.when(
      error: (message) {
        expect(message, 'value is required');
      },
      success: (_) => fail('should not be success'),
    );
  });
}
