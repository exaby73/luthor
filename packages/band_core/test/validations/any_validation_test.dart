import 'package:band_core/band_core.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is any value', () {
    final result = b.any().validate('user');
    expect(result.isValid, isTrue);
  });

  test('should return true when value is null', () {
    final result = b.any().validate(null);
    expect(result.isValid, isTrue);
  });

  test('should return false if the value is null with required()', () {
    final result = b.bool().required().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });
}
