import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid bool', () {
    final result = l.bool().validate(true);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false when value is not a valid bool', () {
    final result = l.bool().validate('user');

    result.when(
      error: (message) {
        expect(message, 'value must be a bool');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().bool().validate(null);

    result.when(
      error: (message) {
        expect(message, 'value is required');
      },
      success: (_) => fail('should not be success'),
    );
  });
}
