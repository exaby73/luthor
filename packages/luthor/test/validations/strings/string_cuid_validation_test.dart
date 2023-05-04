import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid cuid', () {
    final result = l.string().cuid().validateValue('clgtidfup000001pr8qnxasa9');
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false when value is not a valid cuid', () {
    final result = l.string().cuid().validateValue('user');

    result.when(
      error: (errors) {
        expect(errors, ['value must be a valid cuid']);
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return true when value is null', () {
    final result = l.string().cuid().validateValue(null);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().cuid().required().validateValue(null);

    result.when(
      error: (errors) {
        expect(errors, ['value is required']);
      },
      success: (_) => fail('should not be success'),
    );
  });
}
