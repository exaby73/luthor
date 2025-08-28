import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is an double', () {
    final result = l.double().validateValue(1.1);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 1.1);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is an int', () {
    final result = l.double().validateValue(1);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a double']);
    }
  });

  test('should return false when value is not an double', () {
    final result = l.double().validateValue('a');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a double']);
    }
  });

  test('should return true when value is null', () {
    final result = l.double().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().double().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });

  test('should use custom message when message is provided', () {
    final result = l.double(message: 'Custom double error').validateValue('not a double');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Custom double error']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l.double(messageFn: () => 'Dynamic double error').validateValue('not a double');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic double error']);
    }
  });

  test('should prioritize custom message over messageFn when both are provided', () {
    final result = l.double(
      message: 'Static message',
      messageFn: () => 'Dynamic message'
    ).validateValue('not a double');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Static message']);
    }
  });

  test('should handle null return from messageFn and fallback to default', () {
    final result = l.double(messageFn: () => null).validateValue('not a double');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a double']);
    }
  });
}
