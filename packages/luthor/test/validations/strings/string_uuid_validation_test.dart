import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid uuid', () {
    final result =
        l.string().uuid().validate('b058f7f6-e1e1-11ed-b5ea-0242ac120002');
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false when value is not a valid uuid', () {
    final result = l.string().uuid().validate('user');

    result.when(
      error: (message) {
        expect(message, 'value must be a valid uuid');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return true when value is null', () {
    final result = l.string().uuid().validate(null);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().uuid().required().validate(null);

    result.when(
      error: (message) {
        expect(message, 'value is required');
      },
      success: (_) => fail('should not be success'),
    );
  });
}
