import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test(
    'should return true if the int is greater than or equal to minValue',
    () {
      final result = l.int().min(3).validateValue(4);

      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, 4);
        case SingleValidationError(data: _, errors: _):
          fail('should not have errors');
      }
    },
  );

  test('should return false if the int is less than minValue', () {
    final result = l.int().min(3).validateValue(2);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be greater than or equal to 3']);
    }
  });

  test('should return true when the value is null', () {
    final result = l.int().min(3).validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.int().min(3).required().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });

  test('should use custom message when message is provided', () {
    final result = l.int().min(3, message: 'Too low').validateValue(2);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Too low']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l.int()
        .min(3, messageFn: () => 'Dynamic min error')
        .validateValue(2);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic min error']);
    }
  });

  test(
    'should prioritize custom message over messageFn when both are provided',
    () {
      final result = l.int()
          .min(3, message: 'Static message', messageFn: () => 'Dynamic message')
          .validateValue(2);

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['Static message']);
      }
    },
  );

  test('should handle null return from messageFn and fallback to default', () {
    final result = l.int().min(3, messageFn: () => null).validateValue(2);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be greater than or equal to 3']);
    }
  });
}
