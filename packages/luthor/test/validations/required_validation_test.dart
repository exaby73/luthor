import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return false when value is an empty string', () {
    final result = l.required().validate('');
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });

  test('should return false when value is null', () {
    final result = l.required().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });

  test('should return true when value is not null or empty string', () {
    final result = l.required().validate('a');
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });
}
