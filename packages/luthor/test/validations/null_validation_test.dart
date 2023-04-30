import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is null', () {
    final result = l.nullValue().validateValue(null);
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false when value is not null', () {
    final result = l.nullValue().validateValue(1);

    result.when(
      error: (errors) {
        expect(errors, ['value must be null']);
      },
      success: (_) => fail('should not be success'),
    );
  });
}
