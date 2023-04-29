import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value match regex', () {
    final result = l.string().regex(r'^luthor(?:_(annotation|generator))?$').validate('luthor');
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test("should return false when value didn't match regex", () {
    final result = l.string().regex(r'^luthor(?:_(annotation|generator))?$').validate('bad value');

    result.when(
      error: (message) {
        expect(message, 'value must match regex');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return true when value is null', () {
    final result = l.string().regex('pattern').validate(null);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().regex('pattern').required().validate(null);

    result.when(
      error: (message) {
        expect(message, 'value is required');
      },
      success: (_) => fail('should not be success'),
    );
  });
}
