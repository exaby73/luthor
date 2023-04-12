import 'package:band_core/band_core.dart';
import 'package:test/test.dart';

void main() {
  final schema = b.schema({
    'email': b.email().required(),
    'password': b.string().required(),
  });

  test('should return true for a valid schema', () {
    final result = schema.validate({
      'email': 'user@example.com',
      'password': 'password',
    });
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });

  test('should return false for an invalid email', () {
    final result = schema.validate({
      'email': 'abc',
      'password': 'password',
    });
    expect(result.isValid, isFalse);
    expect(result.message, 'email must be a valid email address');
  });

  test('should return false for an invalid password', () {
    final result = schema.validate({
      'email': 'user@example.com',
      'password': 1,
    });
    expect(result.isValid, isFalse);
    expect(result.message, 'password must be a string');
  });
}
