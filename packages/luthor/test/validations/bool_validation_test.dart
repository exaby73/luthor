import 'package:band_core/band_core.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid bool', () {
    final result = b.bool().validate(true);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false when value is not a valid bool', () {
    final result = b.bool().validate('user');
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be a bool');
  });

  test('should return false if the value is null with required()', () {
    final result = b.required().bool().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });
}
