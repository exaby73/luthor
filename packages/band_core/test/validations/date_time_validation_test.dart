import 'package:band_core/band_core.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid date', () {
    final result = b.dateTime().validate(DateTime.now().toString());
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return true when value is a valid DateTime object', () {
    final result = b.dateTime().validate(DateTime.now());
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false when value is not a valid date', () {
    final result = b.dateTime().validate('user');
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be a valid date');
  });

  test('should return false if the value is null with required()', () {
    final result = b.required().dateTime().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });
}
