import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test(
    'should return true if the string length is less than or equal to maxLength',
    () {
      final result = l.string().max(3).validateValue('abc');

      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, 'abc');
        case SingleValidationError(data: _, errors: _):
          fail('should not have errors');
      }
    },
  );

  test('should return false if the string length is less than minLength', () {
    final result = l.string().max(3).validateValue('abcd');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must not be more than 3 characters long']);
    }
  });

  test('should return true when the value is null', () {
    final result = l.string().max(3).validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().max(3).required().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
    expect(result.isValid, isFalse);
    expect(result.data, isNull);
    expect(result.errors, ['value is required']);
  });

  test('should use custom message when message is provided', () {
    final result = l.string().max(3, message: 'Too long').validateValue('abcd');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Too long']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l
        .string()
        .max(3, messageFn: () => 'Dynamic length error')
        .validateValue('abcd');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic length error']);
    }
  });

  test(
    'should prioritize custom message over messageFn when both are provided',
    () {
      final result = l
          .string()
          .max(3, message: 'Static message', messageFn: () => 'Dynamic message')
          .validateValue('abcd');

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['Static message']);
      }
    },
  );

  test('should handle null return from messageFn and fallback to default', () {
    final result = l
        .string()
        .max(3, messageFn: () => null)
        .validateValue('abcd');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must not be more than 3 characters long']);
    }
  });
}
