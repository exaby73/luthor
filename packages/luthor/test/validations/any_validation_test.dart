import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is any value', () {
    final result = l.any().validate('user');
    expect(result.isValid, isTrue);
  });

  test('should return true when value is null', () {
    final result = l.any().validate(null);
    expect(result.isValid, isTrue);
  });

  test('should return false if the value is null with required()', () {
    final result = l.bool().required().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });
}
