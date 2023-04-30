import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is an int', () {
    final result = l.int().validateValue(1);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false when value is a double', () {
    final result = l.int().validateValue(1.1);

    result.when(
      error: (errors) {
        expect(errors, ['value must be an integer']);
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return false when value is not an int', () {
    final result = l.int().validateValue('a');

    result.when(
      error: (errors) {
        expect(errors, ['value must be an integer']);
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return true when value is null', () {
    final result = l.int().validateValue(null);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().int().validateValue(null);

    result.when(
      error: (errors) {
        expect(errors, ['value is required']);
      },
      success: (_) => fail('should not be success'),
    );
  });
}
