import 'package:band_core/band_core.dart';
import 'package:test/test.dart';

void main() {
  test(
    'should return true if the string length is greater or equal to minLength',
    () {
      final result = b.string().min(3).validate('abc');
      expect(result.isValid, isTrue);
      expect(result.message, isNull);
    },
  );

  test(
    'should return false if the string length is less than minLength',
    () {
      final result = b.string().min(3).validate('ab');
      expect(result.isValid, isFalse);
      expect(result.message, 'value must be at least 3 characters long');
    },
  );
}
