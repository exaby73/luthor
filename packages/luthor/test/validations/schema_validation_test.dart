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

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false for an invalid email', () {
    final result = schema.validate({
      'email': 'abc',
      'password': 'password',
    });

    result.when(
      error: (message) {
        expect(message, 'email must be a valid email address');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return false for an invalid password', () {
    final result = schema.validate({
      'email': 'user@example.com',
      'password': 1,
    });

    result.when(
      error: (message) {
        expect(message, 'password must be a string');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return false for an invalid nested schema', () {
    final result = nestedSchema.validate({
      'address': {
        'city': 'New York',
      },
    });

    result.when(
      error: (message) {
        expect(message, 'address.state is required');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return false for an invalid nested schema', () {
    final result = nestedSchema.validate({
      'address': {
        'city': 'New York',
        'state': 1,
      },
    });

    result.when(
      error: (message) {
        expect(message, 'address.state must be a string');
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return true for a valid nested schema', () {
    final result = nestedSchema.validate({
      'address': {
        'city': 'New York',
        'state': 'NY',
      },
    });
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });
}
