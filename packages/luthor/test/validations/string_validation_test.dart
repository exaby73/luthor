import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a string', () {
    final result = l.string().validate('a');
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false when value is not a string', () {
    final result = l.string().validate(1);

    result.when(
      error: (message) {
        expect(message, 'value must be a string');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().string().validate(null);

    result.when(
      error: (message) {
        expect(message, 'value is required');
      },
      success: (_) => fail('should not be success'),
    );
  });
}
