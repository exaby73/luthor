import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a map', () {
    final result = l.map().validateValue({});

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, {});
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is not a map', () {
    final result = l.map().validateValue('a');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a Map']);
    }
  });

  test('should return true when value is null', () {
    final result = l.map().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().map().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });

  test('should use custom message when message is provided', () {
    final result = l.map(message: 'Custom map error').validateValue('not a map');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Custom map error']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l.map(messageFn: () => 'Dynamic map error').validateValue('not a map');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic map error']);
    }
  });

  test('should prioritize custom message over messageFn when both are provided', () {
    final result = l.map(
      message: 'Static message',
      messageFn: () => 'Dynamic message'
    ).validateValue('not a map');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Static message']);
    }
  });

  test('should handle null return from messageFn and fallback to default', () {
    final result = l.map(messageFn: () => null).validateValue('not a map');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a Map']);
    }
  });
}
