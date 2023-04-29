import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value matches regex', () {
    final result =
        l.string().regex(RegExp('https://pub.dev/packages/luthor')).validate('https://pub.dev/packages/luthor');
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test("should return false when value didn't match regex", () {
    final result = l.string().regex(RegExp('https://pub.dev/packages/luthor')).validate('not valid string');

    result.when(
      error: (message) {
        expect(message, 'value must match regex');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return true when value is null', () {
    final result = l.string().regex(RegExp('luthor')).validate(null);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().regex(RegExp('luthor')).required().validate(null);

    result.when(
      error: (message) {
        expect(message, 'value is required');
      },
      success: (_) => fail('should not be success'),
    );
  });
}
