import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is an int', () {
    final result = l.int().validateValue(1);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 1);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is a double', () {
    final result = l.int().validateValue(1.1);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be an integer']);
    }
    expect(result.isValid, isFalse);
    expect(result.data, 1.1);
    expect(result.errors, ['value must be an integer']);
  });

  test('should return false when value is not an int', () {
    final result = l.int().validateValue('a');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be an integer']);
    }
  });

  test('should return true when value is null', () {
    final result = l.int().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().int().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });

  test('should use custom message when message is provided', () {
    final result = l.int(message: 'Custom integer error').validateValue('not an int');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Custom integer error']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l.int(messageFn: () => 'Dynamic integer error').validateValue('not an int');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic integer error']);
    }
  });

  test('should prioritize custom message over messageFn when both are provided', () {
    final result = l.int(
      message: 'Static message',
      messageFn: () => 'Dynamic message'
    ).validateValue('not an int');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Static message']);
    }
  });

  test('should handle null return from messageFn and fallback to default', () {
    final result = l.int(messageFn: () => null).validateValue('not an int');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be an integer']);
    }
  });
}
