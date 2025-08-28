import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when custom validator passes', () {
    final result = l
        .custom((value) {
          return value! as bool;
        })
        .validateValue(true);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, true);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when custom validator fails', () {
    final result = l
        .custom((value) {
          return !(value! as bool);
        })
        .validateValue(true);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value does not pass custom validation']);
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l
        .required()
        .custom((value) {
          return true;
        })
        .validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });

  test('should use custom message when message is provided', () {
    final result = l
        .custom(
          (value) => false,
          message: 'Custom validation failed',
        )
        .validateValue('test');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Custom validation failed']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l
        .custom(
          (value) => false,
          messageFn: () => 'Dynamic validation error',
        )
        .validateValue('test');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic validation error']);
    }
  });

  test('should prioritize custom message over messageFn when both are provided', () {
    final result = l
        .custom(
          (value) => false,
          message: 'Static message',
          messageFn: () => 'Dynamic message',
        )
        .validateValue('test');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Static message']);
    }
  });

  test('should handle null return from messageFn and fallback to default', () {
    final result = l
        .custom(
          (value) => false,
          messageFn: () => null,
        )
        .validateValue('test');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value does not pass custom validation']);
    }
  });
}
