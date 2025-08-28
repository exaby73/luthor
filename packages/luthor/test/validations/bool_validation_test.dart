import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid bool', () {
    final result = l.boolean().validateValue(true);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, true);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is not a valid bool', () {
    final result = l.boolean().validateValue('user');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a bool']);
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().boolean().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });

  test('should use custom message when message is provided', () {
    final result = l.boolean(message: 'Custom boolean error').validateValue('not a bool');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Custom boolean error']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l.boolean(messageFn: () => 'Dynamic boolean error').validateValue('not a bool');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic boolean error']);
    }
  });

  test('should prioritize custom message over messageFn when both are provided', () {
    final result = l.boolean(
      message: 'Static message', 
      messageFn: () => 'Dynamic message'
    ).validateValue('not a bool');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Static message']);
    }
  });

  test('should use messageFn over default message when only messageFn is provided', () {
    final result = l.boolean(messageFn: () => 'Function message').validateValue('not a bool');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Function message']);
    }
  });

  test('should handle null return from messageFn and fallback to default', () {
    final result = l.boolean(messageFn: () => null).validateValue('not a bool');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a bool']);
    }
  });
}
