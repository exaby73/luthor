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
    const data = {
      'email': 'user@example.com',
      'password': 'password',
    };
    final result = schema.validateSchema(data);

    switch (result) {
      case SchemaValidationSuccess(data: _):
        expect(result.data, data);
      case SchemaValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false for an invalid email', () {
    const data = {
      'email': 'abc',
      'password': 'password',
    };
    final result = schema.validateSchema(data);

    switch (result) {
      case SchemaValidationSuccess(data: _):
        fail('should not be a success');
      case SchemaValidationError(data: _, errors: final errors):
        expect(result.data, data);
        expect(errors, {
          'email': ['email must be a valid email address']
        });
    }
  });

  test('should return false for an invalid password and email', () {
    const data = {
      'email': 1,
      'password': 1,
    };
    final result = schema.validateSchema(data);

    switch (result) {
      case SchemaValidationSuccess(data: _):
        fail('should not be a success');
      case SchemaValidationError(data: _, errors: final errors):
        expect(result.data, data);
        expect(errors, {
          'email': [
            'email must be a string',
            'email must be a valid email address',
          ],
          'password': ['password must be a string']
        });
    }
  });

  test('should return false for an invalid nested schema', () {
    const data = {
      'address': {
        'city': 'New York',
      },
    };
    final result = nestedSchema.validateSchema(data);

    switch (result) {
      case SchemaValidationSuccess(data: _):
        fail('should not be a success');
      case SchemaValidationError(data: _, errors: final errors):
        expect(result.data, data);
        expect(errors, {
          'address': {
            'state': ['state is required'],
          }
        });
    }
  });

  test('should return false for an invalid nested schema', () {
    const data = {
      'address': {
        'city': 'New York',
        'state': 1,
      },
    };
    final result = nestedSchema.validateSchema(data);

    switch (result) {
      case SchemaValidationSuccess(data: _):
        fail('should not be a success');
      case SchemaValidationError(data: _, errors: final errors):
        expect(result.data, data);
        expect(errors, {
          'address': {
            'state': ['state must be a string'],
          }
        });
    }
  });

  test('should return true for a valid nested schema', () {
    const data = {
      'address': {
        'city': 'New York',
        'state': 'NY',
      },
    };
    final result = nestedSchema.validateSchema(data);

    switch (result) {
      case SchemaValidationSuccess(data: _):
        expect(result.data, data);
      case SchemaValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });
}
