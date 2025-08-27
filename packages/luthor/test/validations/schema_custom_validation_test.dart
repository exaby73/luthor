import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

bool passwordConfirmationValidator(Object? value, Map<String, Object?> data) {
  return value == data['password'];
}

bool ageComparisonValidator(Object? value, Map<String, Object?> data) {
  if (value is int && data['minAge'] is int) {
    return value > (data['minAge']! as int);
  }
  return false;
}

bool conditionalRequiredValidator(Object? value, Map<String, Object?> data) {
  final requireField = data['requireField'] as bool? ?? false;
  if (requireField) {
    return value != null && value.toString().isNotEmpty;
  }
  return true;
}

void main() {
  group('Schema Custom Validation Tests', () {
    test('should pass when schema custom validator returns true', () {
      final schema = l.schema({
        'password': l.string().required(),
        'confirmPassword': l
            .string()
            .customWithSchema(passwordConfirmationValidator)
            .required(),
      });

      final result = schema.validateSchema({
        'password': 'password123',
        'confirmPassword': 'password123',
      });

      switch (result) {
        case SchemaValidationSuccess(data: final data):
          final resultData = data as Map<String, dynamic>;
          expect(resultData['password'], 'password123');
          expect(resultData['confirmPassword'], 'password123');
        case SchemaValidationError(errors: final errors):
          fail('should not have errors: $errors');
      }
    });

    test('should fail when schema custom validator returns false', () {
      final schema = l.schema({
        'password': l.string().required(),
        'confirmPassword': l
            .string()
            .customWithSchema(passwordConfirmationValidator)
            .required(),
      });

      final result = schema.validateSchema({
        'password': 'password123',
        'confirmPassword': 'different_password',
      });

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('should not be a success');
        case SchemaValidationError(errors: final errors):
          expect(errors['confirmPassword'], ['confirmPassword does not pass schema custom validation']);
      }
    });

    test('should use custom message when provided', () {
      final schema = l.schema({
        'password': l.string().required(),
        'confirmPassword': l
            .string()
            .customWithSchema(
              passwordConfirmationValidator,
              message: 'Passwords must match',
            )
            .required(),
      });

      final result = schema.validateSchema({
        'password': 'password123',
        'confirmPassword': 'different_password',
      });

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('should not be a success');
        case SchemaValidationError(errors: final errors):
          expect(errors['confirmPassword'], ['Passwords must match']);
      }
    });

    test('should work with numeric comparisons', () {
      final schema = l.schema({
        'minAge': l.int().required(),
        'maxAge': l
            .int()
            .customWithSchema(
              ageComparisonValidator,
              message: 'Max age must be greater than min age',
            )
            .required(),
      });

      final validResult = schema.validateSchema({
        'minAge': 18,
        'maxAge': 65,
      });

      switch (validResult) {
        case SchemaValidationSuccess(data: final data):
          final resultData = data as Map<String, dynamic>;
          expect(resultData['minAge'], 18);
          expect(resultData['maxAge'], 65);
        case SchemaValidationError(errors: final errors):
          fail('should not have errors: $errors');
      }

      final invalidResult = schema.validateSchema({
        'minAge': 65,
        'maxAge': 18,
      });

      switch (invalidResult) {
        case SchemaValidationSuccess(data: _):
          fail('should not be a success');
        case SchemaValidationError(errors: final errors):
          expect(errors['maxAge'], ['Max age must be greater than min age']);
      }
    });

    test('should work with conditional validation based on other fields', () {
      final schema = l.schema({
        'requireField': l.boolean().required(),
        'conditionalField': l
            .string()
            .customWithSchema(
              conditionalRequiredValidator,
              message: 'Field is required when requireField is true',
            ),
      });

      final validResult1 = schema.validateSchema({
        'requireField': false,
        'conditionalField': null,
      });

      switch (validResult1) {
        case SchemaValidationSuccess(data: final data):
          final resultData = data as Map<String, dynamic>;
          expect(resultData['requireField'], false);
          expect(resultData['conditionalField'], null);
        case SchemaValidationError(errors: final errors):
          fail('should not have errors: $errors');
      }

      final validResult2 = schema.validateSchema({
        'requireField': true,
        'conditionalField': 'some value',
      });

      switch (validResult2) {
        case SchemaValidationSuccess(data: final data):
          final resultData = data as Map<String, dynamic>;
          expect(resultData['requireField'], true);
          expect(resultData['conditionalField'], 'some value');
        case SchemaValidationError(errors: final errors):
          fail('should not have errors: $errors');
      }

      final invalidResult = schema.validateSchema({
        'requireField': true,
        'conditionalField': null,
      });

      switch (invalidResult) {
        case SchemaValidationSuccess(data: _):
          fail('should not be a success');
        case SchemaValidationError(errors: final errors):
          expect(errors['conditionalField'], ['Field is required when requireField is true']);
      }
    });

    test('should work with multiple schema custom validations on same field', () {
      final schema = l.schema({
        'password': l.string().required(),
        'minAge': l.int().required(),
        'confirmPassword': l
            .string()
            .customWithSchema(
              passwordConfirmationValidator,
              message: 'Passwords must match',
            )
            .required(),
        'maxAge': l
            .int()
            .customWithSchema(
              ageComparisonValidator,
              message: 'Max age must be greater than min age',
            )
            .required(),
      });

      final result = schema.validateSchema({
        'password': 'password123',
        'confirmPassword': 'different_password',
        'minAge': 65,
        'maxAge': 18,
      });

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('should not be a success');
        case SchemaValidationError(errors: final errors):
          expect(errors['confirmPassword'], ['Passwords must match']);
          expect(errors['maxAge'], ['Max age must be greater than min age']);
      }
    });

    test('should combine with other validations', () {
      final schema = l.schema({
        'password': l.string().min(8).required(),
        'confirmPassword': l
            .string()
            .min(8)
            .customWithSchema(
              passwordConfirmationValidator,
              message: 'Passwords must match',
            )
            .required(),
      });

      final result = schema.validateSchema({
        'password': 'short',
        'confirmPassword': 'diff',
      });

      switch (result) {
        case SchemaValidationSuccess(data: _):
          fail('should not be a success');
        case SchemaValidationError(errors: final errors):
          expect(errors['password'], ['password must be at least 8 characters long']);
          expect(errors['confirmPassword'], [
            'confirmPassword must be at least 8 characters long',
            'Passwords must match',
          ]);
      }
    });

    test('should handle null values correctly', () {
      final schema = l.schema({
        'password': l.string(),
        'confirmPassword': l
            .string()
            .customWithSchema(passwordConfirmationValidator),
      });

      final result = schema.validateSchema({
        'password': null,
        'confirmPassword': null,
      });

      switch (result) {
        case SchemaValidationSuccess(data: final data):
          final resultData = data as Map<String, dynamic>;
          expect(resultData['password'], null);
          expect(resultData['confirmPassword'], null);
        case SchemaValidationError(errors: final errors):
          fail('should not have errors: $errors');
      }
    });
  });
}
