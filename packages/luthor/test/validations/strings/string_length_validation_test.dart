import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true if the string length equal to length specified', () {
    final result = l.string().length(3).validateValue('abc');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'abc');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return true when the value is null', () {
    final result = l.string().length(3).validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test(
    'should return false if the string length is less than or greater than length specified',
    () {
      final lessThenResult = l.string().length(3).validateValue('ab');

      switch (lessThenResult) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['value must be exactly 3 characters long']);
      }

      final greaterThenResult = l.string().length(3).validateValue('abcd');

      switch (greaterThenResult) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['value must be exactly 3 characters long']);
      }
    },
  );

  test('should use custom message when message is provided', () {
    final result = l.string().length(3, message: 'Wrong length').validateValue('ab');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Wrong length']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l.string().length(3, messageFn: () => 'Dynamic length error').validateValue('ab');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic length error']);
    }
  });

  test('should prioritize custom message over messageFn when both are provided', () {
    final result = l.string().length(3, 
      message: 'Static message',
      messageFn: () => 'Dynamic message'
    ).validateValue('ab');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Static message']);
    }
  });

  test('should handle null return from messageFn and fallback to default', () {
    final result = l.string().length(3, messageFn: () => null).validateValue('ab');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be exactly 3 characters long']);
    }
  });
}
