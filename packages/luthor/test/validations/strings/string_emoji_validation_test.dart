import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid emoji', () {
    final result = l.string().emoji().validateValue('👍');
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false when value is not a valid emoji', () {
    final result = l.string().emoji().validateValue('a');

    result.when(
      error: (errors) {
        expect(errors, ['value must be a valid emoji']);
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return true when value is null', () {
    final result = l.string().emoji().validateValue(null);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().emoji().required().validateValue(null);

    result.when(
      error: (errors) {
        expect(errors, ['value is required']);
      },
      success: (_) => fail('should not be success'),
    );
  });
}
