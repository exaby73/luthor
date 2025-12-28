import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'fixtures/annotated_model.dart';
import 'fixtures/json_key_model.dart';
import 'fixtures/list_model.dart';
import 'fixtures/nested_model.dart';
import 'fixtures/simple_model.dart';

void main() {
  group('Schema Generation Tests', () {
    test('should generate schema variable with correct name', () {
      expect($SimpleModelSchema, isA<Validator>());
    });

    test('should generate SchemaKeys with correct field names', () {
      expect(SimpleModelSchemaKeys.name, equals('name'));
      expect(SimpleModelSchemaKeys.age, equals('age'));
      expect(SimpleModelSchemaKeys.isActive, equals('isActive'));
      expect(SimpleModelSchemaKeys.score, equals('score'));
      expect(SimpleModelSchemaKeys.optionalField, equals('optionalField'));
    });

    test('should generate ErrorKeys with correct field names', () {
      expect(SimpleModelErrorKeys.name, equals('name'));
      expect(SimpleModelErrorKeys.age, equals('age'));
      expect(SimpleModelErrorKeys.isActive, equals('isActive'));
      expect(SimpleModelErrorKeys.score, equals('score'));
    });

    test('should generate validate function with correct name', () {
      final result = $SimpleModelValidate({});
      expect(result, isA<SchemaValidationResult<SimpleModel>>());
    });

    test('should generate validateSelf extension method', () {
      final validData = {
        'name': 'Test Name',
        'age': 25,
        'isActive': true,
        'score': 85.5,
      };

      switch ($SimpleModelValidate(validData)) {
        case SchemaValidationSuccess(data: final model):
          final selfResult = model.validateSelf();
          expect(selfResult, isA<SchemaValidationResult<SimpleModel>>());
        case SchemaValidationError(errors: final errors):
          fail('Should not have validation errors: $errors');
      }
    });
  });

  group('Basic Type Validation Tests', () {
    test('should validate required string field', () {
      final result = $SimpleModelValidate({});

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation errors for missing required fields');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('name'));
      }
    });

    test('should validate required int field', () {
      final result = $SimpleModelValidate({});

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation errors for missing required fields');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('age'));
      }
    });

    test('should validate required bool field', () {
      final result = $SimpleModelValidate({});

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation errors for missing required fields');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('isActive'));
      }
    });

    test('should validate required double field', () {
      final result = $SimpleModelValidate({});

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation errors for missing required fields');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('score'));
      }
    });

    test('should allow optional field to be missing', () {
      final data = {'name': 'Test', 'age': 25, 'isActive': true, 'score': 85.5};

      final result = $SimpleModelValidate(data);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          expect(result.data, isA<SimpleModel>());
        case SchemaValidationError(errors: _):
          fail('Should not have errors for missing optional field');
      }
    });

    test('should validate correct types', () {
      final validData = {
        'name': 'Test Name',
        'age': 25,
        'isActive': true,
        'score': 85.5,
      };

      final result = $SimpleModelValidate(validData);

      switch (result) {
        case SchemaValidationSuccess(data: final model):
          expect(model.name, equals('Test Name'));
          expect(model.age, equals(25));
          expect(model.isActive, isTrue);
          expect(model.score, equals(85.5));
        case SchemaValidationError(errors: final errors):
          fail('Should not have validation errors: $errors');
      }
    });

    test('should reject incorrect types', () {
      final invalidData = {
        'name': 123, // should be string
        'age': 'twenty-five', // should be int
        'isActive': 'yes', // should be bool
        'score': 'high', // should be double
      };

      final result = $SimpleModelValidate(invalidData);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation errors for wrong types');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('name'));
          expect(errors.keys, contains('age'));
          expect(errors.keys, contains('isActive'));
          expect(errors.keys, contains('score'));
      }
    });
  });

  group('Annotation Validation Tests', () {
    test('should validate @IsEmail annotation', () {
      final data = {
        'email': 'invalid-email',
        'password': 'password123',
        'age': 25,
        'score': 50.0,
        'uuid': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
      };

      final result = $AnnotatedModelValidate(data);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation error for invalid email');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('email'));
      }
    });

    test('should validate @HasMin and @HasMax for string', () {
      final dataMin = {
        'email': 'test@example.com',
        'password': 'short', // min is 8
        'age': 25,
        'score': 50.0,
        'uuid': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
      };

      final result = $AnnotatedModelValidate(dataMin);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation error for string too short');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('password'));
      }
    });

    test('should validate @HasMin and @HasMax for int', () {
      final dataOutOfRange = {
        'email': 'test@example.com',
        'password': 'password123',
        'age': 15, // min is 18
        'score': 50.0,
        'uuid': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
      };

      final result = $AnnotatedModelValidate(dataOutOfRange);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation error for int out of range');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('age'));
      }
    });

    test('should validate @HasMinDouble and @HasMaxDouble', () {
      final dataOutOfRange = {
        'email': 'test@example.com',
        'password': 'password123',
        'age': 25,
        'score': 150.0, // max is 100.0
        'uuid': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
      };

      final result = $AnnotatedModelValidate(dataOutOfRange);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation error for double out of range');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('score'));
      }
    });

    test('should validate @StartsWith annotation', () {
      final data = {
        'email': 'test@example.com',
        'password': 'password123',
        'age': 25,
        'score': 50.0,
        'uuid': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'website': 'http://example.com', // should start with https://
      };

      final result = $AnnotatedModelValidate(data);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail(
            'Should have validation error for string not starting with https://',
          );
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('website'));
      }
    });

    test('should validate @EndsWith annotation', () {
      final data = {
        'email': 'test@example.com',
        'password': 'password123',
        'age': 25,
        'score': 50.0,
        'uuid': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'domain': 'example.org', // should end with .com
      };

      final result = $AnnotatedModelValidate(data);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation error for string not ending with .com');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('domain'));
      }
    });

    test('should validate @Contains annotation', () {
      final data = {
        'email': 'test@example.com',
        'password': 'password123',
        'age': 25,
        'score': 50.0,
        'uuid': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'testField': 'production', // should contain 'test'
      };

      final result = $AnnotatedModelValidate(data);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation error for string not containing test');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('testField'));
      }
    });

    test('should validate @IsUuid annotation', () {
      final data = {
        'email': 'test@example.com',
        'password': 'password123',
        'age': 25,
        'score': 50.0,
        'uuid': 'not-a-uuid',
      };

      final result = $AnnotatedModelValidate(data);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation error for invalid UUID');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('uuid'));
      }
    });

    test('should pass with all valid annotations', () {
      final validData = {
        'email': 'test@example.com',
        'password': 'password123',
        'age': 25,
        'score': 50.0,
        'uuid': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'website': 'https://example.com',
        'domain': 'example.com',
        'testField': 'test data',
      };

      final result = $AnnotatedModelValidate(validData);

      switch (result) {
        case SchemaValidationSuccess(data: final model):
          expect(model.email, equals('test@example.com'));
          expect(model.password, equals('password123'));
        case SchemaValidationError(errors: final errors):
          fail('Should not have validation errors: $errors');
      }
    });
  });

  group('@JsonKey Tests', () {
    test('should respect @JsonKey annotation in SchemaKeys', () {
      expect(JsonKeyModelSchemaKeys.userName, equals('user_name'));
      expect(JsonKeyModelSchemaKeys.userEmail, equals('user_email'));
      expect(JsonKeyModelSchemaKeys.normalField, equals('normalField'));
    });

    test('should respect @JsonKey annotation in ErrorKeys', () {
      expect(JsonKeyModelErrorKeys.userName, equals('user_name'));
      expect(JsonKeyModelErrorKeys.userEmail, equals('user_email'));
      expect(JsonKeyModelErrorKeys.normalField, equals('normalField'));
    });

    test('should validate using JSON key names', () {
      final data = {
        'user_name': 'testuser',
        'user_email': 'test@example.com',
        'normalField': 'value',
      };

      final result = $JsonKeyModelValidate(data);

      switch (result) {
        case SchemaValidationSuccess(data: final model):
          expect(model.userName, equals('testuser'));
          expect(model.userEmail, equals('test@example.com'));
        case SchemaValidationError(errors: final errors):
          fail('Should not have validation errors: $errors');
      }
    });

    test('should validate email with @JsonKey field', () {
      final data = {
        'user_name': 'testuser',
        'user_email': 'invalid-email',
        'normalField': 'value',
      };

      final result = $JsonKeyModelValidate(data);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation error for invalid email');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('user_email'));
      }
    });
  });

  group('Nested Schema Tests', () {
    test('should generate nested ErrorKeys', () {
      expect(NestedModelErrorKeys.id, equals('id'));
      expect(NestedModelErrorKeys.user.name, equals('user.name'));
      expect(NestedModelErrorKeys.user.age, equals('user.age'));
    });

    test('should validate nested schema', () {
      final validData = {
        'id': 'test-id',
        'user': {
          'name': 'John Doe',
          'age': 30,
          'isActive': true,
          'score': 95.5,
        },
      };

      final result = $NestedModelValidate(validData);

      switch (result) {
        case SchemaValidationSuccess(data: final model):
          expect(model.id, equals('test-id'));
          expect(model.user.name, equals('John Doe'));
          expect(model.user.age, equals(30));
        case SchemaValidationError(errors: final errors):
          fail('Should not have validation errors: $errors');
      }
    });

    test('should validate nested schema with errors', () {
      final invalidData = {
        'id': 'test-id',
        'user': {
          'name': 'John Doe',
          // Missing required fields
        },
      };

      final result = $NestedModelValidate(invalidData);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation errors for nested schema');
        case SchemaValidationError(errors: final errors):
          // Nested schema errors are reported under the parent key
          expect(errors.keys, contains('user'));
          expect(errors['user'], isNotEmpty);
      }
    });

    test('should generate auto-schema for nested SimpleModel', () {
      expect($SimpleModelSchema, isA<Validator>());
    });
  });

  group('List Validation Tests', () {
    test('should validate list of strings', () {
      final validData = {
        'stringList': ['a', 'b', 'c'],
        'intList': [1, 2, 3],
      };

      final result = $ListModelValidate(validData);

      switch (result) {
        case SchemaValidationSuccess(data: final model):
          expect(model.stringList, equals(['a', 'b', 'c']));
          expect(model.intList, equals([1, 2, 3]));
        case SchemaValidationError(errors: final errors):
          fail('Should not have validation errors: $errors');
      }
    });

    test('should validate list of ints', () {
      final invalidData = {
        'stringList': ['a', 'b'],
        'intList': ['not', 'numbers'],
      };

      final result = $ListModelValidate(invalidData);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('Should have validation error for invalid list items');
        case SchemaValidationError(errors: final errors):
          expect(errors.keys, contains('intList'));
      }
    });

    test('should allow optional list to be missing', () {
      final data = {
        'stringList': ['a', 'b'],
        'intList': [1, 2],
      };

      final result = $ListModelValidate(data);

      switch (result) {
        case SchemaValidationSuccess(data: _):
          expect(result.data, isA<ListModel>());
        case SchemaValidationError(errors: _):
          fail('Should not have errors for missing optional list');
      }
    });
  });
}
