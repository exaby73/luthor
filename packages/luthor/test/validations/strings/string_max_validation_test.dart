import 'package:band_core/band_core.dart';
import 'package:test/test.dart';

void main() {
  test(
    'should return true if the string length is less than or equal to maxLength',
    () {
      final result = b.string().max(3).validate('abc');
      expect(result.isValid, isTrue);
      expect(result.message, isNull);
    },
  );

  test(
    'should return false if the string length is less than minLength',
    () {
      final result = b.string().max(3).validate('abcd');
      expect(result.isValid, isFalse);
      expect(result.message, 'value must not be more than 3 characters long');
    },
  );
}
