import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  late Validator schema;
  late Validator nestedSchema;

  setUp(() {
    schema = l.schema({
      'email': l.string().email().required(),
      'password': l.string().required(),
    });

    nestedSchema = l.schema({
      'address': l.schema({
        'city': l.string().required(),
        'state': l.string().required(),
      }).required(),
    });
  });

  test('should return true for a valid schema', () {
    final result = schema.validateSchema({
      'email': 'user@example.com',
      'password': 'password',
    });
    expect(result.isValid, isTrue);

    result.whenOrNull(
      error: (_) => fail('should not be error'),
    );
  });

  test('should return false for an invalid email', () {
    final result = schema.validateSchema({
      'email': 'abc',
      'password': 'password',
    });

    result.when(
      error: (errors) {
        expect(errors, {
          'email': ['email must be a valid email address']
        });
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return false for an invalid password and email', () {
    final result = schema.validateSchema({
      'email': 1,
      'password': 1,
    });

    result.when(
      error: (errors) {
        expect(errors, {
          'email': [
            'email must be a string',
            'email must be a valid email address'
          ],
          'password': ['password must be a string']
        });
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return false for an invalid nested schema', () {
    final result = nestedSchema.validateSchema({
      'address': {
        'city': 'New York',
      },
    });

    result.when(
      error: (errors) {
        expect(errors, {
          'address': {
            'state': ['state is required']
          }
        });
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return false for an invalid nested schema', () {
    final result = nestedSchema.validateSchema({
      'address': {
        'city': 'New York',
        'state': 1,
      },
    });

    result.when(
      error: (errors) {
        expect(errors, {
          'address': {
            'state': ['state must be a string']
          }
        });
      },
      success: (_) => fail('should not be success'),
    );
  });

  test('should return true for a valid nested schema', () {
    final result = nestedSchema.validateSchema({
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
