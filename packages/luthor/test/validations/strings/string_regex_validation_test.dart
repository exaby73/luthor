import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value match regex', () {
    final result = l
        .string()
        .regex(r'^luthor(?:_(annotation|generator))?$')
        .validateValue('luthor');
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test("should return false when value didn't match regex", () {
    final result = l
        .string()
        .regex(r'^luthor(?:_(annotation|generator))?$')
        .validateValue('bad value');

    result.when(
      error: (errors) {
        expect(errors, ['value must match regex']);
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return true when value is null', () {
    final result = l.string().regex('pattern').validateValue(null);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().regex('pattern').required().validateValue(null);

    result.when(
      error: (errors) {
        expect(errors, ['value is required']);
      },
      success: (_) => fail('should not be success'),
    );
  });
}
