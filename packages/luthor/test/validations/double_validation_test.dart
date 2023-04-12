import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is an double', () {
    final result = l.double().validate(1.1);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false when value is an int', () {
    final result = l.double().validate(1);
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be a double');
  });

  test('should return false when value is not an double', () {
    final result = l.double().validate('a');
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be a double');
  });

  test('should return true when value is null', () {
    final result = l.double().validate(null);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().double().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });
}
