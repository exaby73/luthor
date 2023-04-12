import 'package:band_core/band_core.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a string', () {
    final result = b.string().validate('a');
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false when value is not a string', () {
    final result = b.string().validate(1);
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be a string');
  });

  test('should return false if the value is null with required()', () {
    final result = b.required().string().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });
}
