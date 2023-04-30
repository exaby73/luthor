import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is any value', () {
    final result = l.any().validateValue('user');
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return true when value is null', () {
    final result = l.any().validateValue(null);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.bool().required().validateValue(null);

    result.when(
      error: (message) {
        expect(message, ['value is required']);
      },
      success: (_) => fail('should not be success'),
    );
  });
}
