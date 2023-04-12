import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is an int', () {
    final result = l.int().validate(1);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false when value is a double', () {
    final result = l.int().validate(1.1);
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be an integer');
  });

  test('should return false when value is not an int', () {
    final result = l.int().validate('a');
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be an integer');
  });

  test('should return true when value is null', () {
    final result = l.int().validate(null);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().int().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });
}
