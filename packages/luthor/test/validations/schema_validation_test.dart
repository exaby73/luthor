import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  final schema = l.schema({
    'email': l.string().email().required(),
    'password': l.string().required(),
  });

  final nestedSchema = l.schema({
    'address': l.schema({
      'city': l.string().required(),
      'state': l.string().required(),
    }).required(),
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

  test('should return false for an invalid nested schema', () {
    final result = nestedSchema.validate({
      'address': {
        'city': 'New York',
      },
    });
    expect(result.isValid, isFalse);
    expect(result.message, 'address.state is required');
  });

  test('should return false for an invalid nested schema', () {
    final result = nestedSchema.validate({
      'address': {
        'city': 'New York',
        'state': 1,
      },
    });
    expect(result.isValid, isFalse);
    expect(result.message, 'address.state must be a string');
  });

  test('should return true for a valid nested schema', () {
    final result = nestedSchema.validate({
      'address': {
        'city': 'New York',
        'state': 'NY',
      },
    });
    expect(result.isValid, isTrue);
    expect(result.message, isNull);
  });
}
