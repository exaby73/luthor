import 'package:band_core/band_core.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is an int', () {
    final result = b.int().validate(1);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false when value is a floating point', () {
    final result = b.int().validate(1.1);
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be an integer');
  });

  test('should return false when value is not an int', () {
    final result = b.int().validate('a');
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be an integer');
  });

  test('should return true when value is null', () {
    final result = b.int().validate(null);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false if the value is null with required()', () {
    final result = b.required().int().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });
}
