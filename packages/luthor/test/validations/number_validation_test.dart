import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is an int', () {
    final result = l.number().validateValue(1);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return true when value is a floating point', () {
    final result = l.number().validateValue(1.1);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false when value is not a number', () {
    final result = l.number().validateValue('a');

    result.when(
      error: (errors) {
        expect(errors, ['value must be a number']);
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return true when value is null', () {
    final result = l.number().validateValue(null);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().number().validateValue(null);

    result.when(
      error: (errors) {
        expect(errors, ['value is required']);
      },
      success: (_) => fail('should not be success'),
    );
  });
}
