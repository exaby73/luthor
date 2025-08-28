import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value match regex', () {
    final result = l
        .string()
        .regex(r'^luthor(?:_(annotation|generator))?$')
        .validateValue('luthor');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'luthor');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test("should return false when value didn't match regex", () {
    final result = l
        .string()
        .regex(r'^luthor(?:_(annotation|generator))?$')
        .validateValue('bad value');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must match regex']);
    }
  });

  test('should return true when value is null', () {
    final result = l.string().regex('pattern').validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().regex('pattern').required().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });

  test('should use custom message when message is provided', () {
    final result = l.string().regex('pattern', message: 'Pattern mismatch').validateValue('bad value');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Pattern mismatch']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l.string().regex('pattern', messageFn: () => 'Dynamic regex error').validateValue('bad value');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic regex error']);
    }
  });

  test('should prioritize custom message over messageFn when both are provided', () {
    final result = l.string().regex('pattern',
      message: 'Static message',
      messageFn: () => 'Dynamic message'
    ).validateValue('bad value');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Static message']);
    }
  });

  test('should handle null return from messageFn and fallback to default', () {
    final result = l.string().regex('pattern', messageFn: () => null).validateValue('bad value');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must match regex']);
    }
  });
}
