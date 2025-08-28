import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is an empty string', () {
    final result = l.required().validateValue('');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, '');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is null', () {
    final result = l.required().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });

  test('should return true when value is not null or empty string', () {
    final result = l.required().validateValue('a');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'a');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should use custom message when message is provided', () {
    final result = l.required(message: 'This field is mandatory').validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['This field is mandatory']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l.required(messageFn: () => 'Dynamic required error').validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic required error']);
    }
  });

  test('should prioritize custom message over messageFn when both are provided', () {
    final result = l.required(
      message: 'Static message',
      messageFn: () => 'Dynamic message'
    ).validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Static message']);
    }
  });

  test('should handle null return from messageFn and fallback to default', () {
    final result = l.required(messageFn: () => null).validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
