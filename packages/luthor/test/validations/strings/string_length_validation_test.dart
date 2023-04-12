import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test(
    'should return true if the string length equal to length specified',
    () {
      final result = l.string().length(3).validate('abc');
      expect(result.isValid, isTrue);
      expect(result.message, isNull);
    },
  );

  test(
    'should return false if the string length is less than or greater than length specified',
    () {
      final lessThenResult = l.string().length(3).validate('ab');
      expect(lessThenResult.isValid, isFalse);
      expect(lessThenResult.message, 'value must be exactly 3 characters long');

      final greaterThenResult = l.string().length(3).validate('abcd');
      expect(greaterThenResult.isValid, isFalse);
      expect(
        greaterThenResult.message,
        'value must be exactly 3 characters long',
      );
    },
  );
}
