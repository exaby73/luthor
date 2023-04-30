import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a string', () {
    final result = l.string().validateValue('a');
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false when value is not a string', () {
    final result = l.string().validateValue(1);

    result.when(
      error: (errors) {
        expect(errors, ['value must be a string']);
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().string().validateValue(null);

    result.when(
      error: (errors) {
        expect(errors, ['value is required']);
      },
      success: (_) => fail('should not be success'),
    );
  });
}
