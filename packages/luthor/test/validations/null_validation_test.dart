import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is null', () {
    final result = l.nullValue().validate(null);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false when value is not null', () {
    final result = l.nullValue().validate(1);
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be null');
  });
}
