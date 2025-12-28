import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'fixtures/custom_validator_model.dart';

void main() {
  group('Custom Validator Tests', () {
    test('should generate schema with custom validators', () {
      expect($CustomValidatorModelSchema, isA<Validator>());
    });

    test('should validate @WithCustomValidator - valid case', () {
      final validData = {
        'customField': 'valid',
        'matchField': 'test',
        'confirmField': 'test',
      };

      final result = $CustomValidatorModelValidate(validData);

      switch (result) {
        case SchemaValidationSuccess(data: final model):
          expect(model.customField, equals('valid'));
        case SchemaValidationError(errors: final errors):
          fail('Should not have validation errors: $errors');
      }
    });

    test(
      'should validate @WithCustomValidator - invalid case with custom message',
      () {
        final invalidData = {
          'customField': 'invalid',
          'matchField': 'test',
          'confirmField': 'test',
        };

        final result = $CustomValidatorModelValidate(invalidData);

        switch (result) {
          case SchemaValidationSuccess(data: _):
            fail('Should have validation error for custom validator');
          case SchemaValidationError(errors: final errors):
            expect(errors.keys, contains('customField'));
            expect(errors['customField'], isNotNull);
            expect(errors['customField']!.first, equals('Value must be "valid"'));
        }
      },
    );

    test('should validate @WithSchemaCustomValidator - matching fields', () {
      final validData = {
        'customField': 'valid',
        'matchField': 'password123',
        'confirmField': 'password123',
      };

      final result = $CustomValidatorModelValidate(validData);

      switch (result) {
        case SchemaValidationSuccess(data: final model):
          expect(model.matchField, equals('password123'));
          expect(model.confirmField, equals('password123'));
        case SchemaValidationError(errors: final errors):
          fail('Should not have validation errors: $errors');
      }
    });

    test(
      'should validate @WithSchemaCustomValidator - non-matching fields',
      () {
        final invalidData = {
          'customField': 'valid',
          'matchField': 'password123',
          'confirmField': 'different',
        };

        final result = $CustomValidatorModelValidate(invalidData);

        switch (result) {
          case SchemaValidationSuccess(data: _):
            fail('Should have validation error for non-matching fields');
          case SchemaValidationError(errors: final errors):
            expect(errors.keys, contains('confirmField'));
            expect(errors['confirmField'], isNotNull);
            expect(errors['confirmField']!.first, equals('Fields must match'));
        }
      },
    );
  });
}
