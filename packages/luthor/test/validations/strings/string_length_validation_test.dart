import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test(
    'should return true if the string length equal to length specified',
    () {
      final result = l.string().length(3).validateValue('abc');
      expect(result.isValid, isTrue);

      result.whenOrNull(
        error: (_) => fail('should not be error'),
      );
    },
  );

  test(
    'should return true when the value is null',
    () {
      final result = l.string().length(3).validateValue(null);
      expect(result.isValid, isTrue);

      result.whenOrNull(
        error: (_) => fail('should not be error'),
      );
    },
  );

  test(
    'should return false if the string length is less than or greater than length specified',
    () {
      final lessThenResult = l.string().length(3).validateValue('ab');

      lessThenResult.when(
        error: (errors) {
          expect(errors, ['value must be exactly 3 characters long']);
        },
        success: (_) => fail('should not be success'),
      );

      final greaterThenResult = l.string().length(3).validateValue('abcd');

      greaterThenResult.when(
        error: (errors) {
          expect(errors, ['value must be exactly 3 characters long']);
        },
        success: (_) => fail('should not be success'),
      );
    },
  );
}
