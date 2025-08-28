import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is an int', () {
    final result = l.number().validateValue(1);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 1);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return true when value is a floating point', () {
    final result = l.number().validateValue(1.1);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 1.1);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is not a number', () {
    final result = l.number().validateValue('a');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a number']);
    }
  });

  test('should return true when value is null', () {
    final result = l.number().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().number().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });

  test('should use custom message when message is provided', () {
    final result = l.number(message: 'Custom number error').validateValue('not a number');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Custom number error']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l.number(messageFn: () => 'Dynamic number error').validateValue('not a number');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic number error']);
    }
  });

  test('should prioritize custom message over messageFn when both are provided', () {
    final result = l.number(
      message: 'Static message',
      messageFn: () => 'Dynamic message'
    ).validateValue('not a number');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Static message']);
    }
  });

  test('should handle null return from messageFn and fallback to default', () {
    final result = l.number(messageFn: () => null).validateValue('not a number');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a number']);
    }
  });
}
