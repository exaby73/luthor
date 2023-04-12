import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is an int', () {
    final result = l.number().validate(1);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return true when value is a floating point', () {
    final result = l.number().validate(1.1);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false when value is not a number', () {
    final result = l.number().validate('a');
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be a number');
  });

  test('should return true when value is null', () {
    final result = l.number().validate(null);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().number().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });
}
