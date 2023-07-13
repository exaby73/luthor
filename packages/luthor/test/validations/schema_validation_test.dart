import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

class Sample {
  final String? email;
  final String? password;

  Sample({
    this.email,
    this.password,
  });

  factory Sample.fromJson(Map<String, dynamic> json) {
    return Sample(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }
}

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

  test(
    'should return an instance of object when fromJson is passed',
    () {
      const data = {
        'email': 'user@example.com',
        'password': 'password',
      };
      final result = schema.validateSchema(data, fromJson: Sample.fromJson);

      switch (result) {
        case SchemaValidationSuccess(data: final data):
          expect(data, isA<Sample>());
          expect(data.email, 'user@example.com');
          expect(data.password, 'password');
        case SchemaValidationError(data: _, errors: _):
          fail('should not have errors');
      }
    },
  );

  group('Issues', () {
    test('#41', () {
      final result = nestedSchema.validateSchema({});

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('should not be a success');
        case SchemaValidationError(data: _, errors: final errors):
          expect(errors, {
            'address': ['address is required'],
          });
      }
    });

    test('#47', () {
      const json = {
        'email': 'user@example.com',
      };
      final result = schema.validateSchema(json, fromJson: Sample.fromJson);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('should not be a success');
        case SchemaValidationError(data: final data, errors: final errors):
          expect(errors, {
            'password': ['password is required'],
          });
          expect(data, null);
      }
    });
  });
}
