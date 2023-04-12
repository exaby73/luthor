import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid date', () {
    final result = l.string().dateTime().validate(DateTime.now().toString());
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false when value is not a valid date', () {
    final result = l.string().dateTime().validate('user');
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be a valid date');
  });

  test('should return true when value is null', () {
    final result = l.string().dateTime().validate(null);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().dateTime().required().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });
}
