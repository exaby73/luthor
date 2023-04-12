import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid uri', () {
    final result = l.string().uri().validate('https://dart.dev');
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return true when value is a valid uri and matches the scheme',
      () {
    final result = l.string().uri(['https']).validate('https://dart.dev');
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test(
    'should return false when value is a valid uri but does not match the scheme',
    () {
      final result = l.string().uri(['https']).validate('http://dart.dev');
      expect(result.isValid, isFalse);
      expect(
        result.message,
        'value must be a valid uri. Allowed scheme is https',
      );
    },
  );

  test('should return false when value is not a valid uri', () {
    final result = l.string().uri().validate(':hello');
    expect(result.isValid, isFalse);
    expect(result.message, 'value must be a valid uri');
  });

  test('should return true when value is null', () {
    final result = l.string().uri().validate(null);
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().uri().required().validate(null);
    expect(result.isValid, isFalse);
    expect(result.message, 'value is required');
  });
}
