import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is null', () {
    final result = l.nullValue().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is not null', () {
    final result = l.nullValue().validateValue(1);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be null']);
    }
  });

  test('should use custom message when message is provided', () {
    final result = l
        .nullValue(message: 'Custom null error')
        .validateValue('not null');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Custom null error']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l
        .nullValue(messageFn: () => 'Dynamic null error')
        .validateValue('not null');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic null error']);
    }
  });

  test(
    'should prioritize custom message over messageFn when both are provided',
    () {
      final result = l
          .nullValue(
            message: 'Static message',
            messageFn: () => 'Dynamic message',
          )
          .validateValue('not null');

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['Static message']);
      }
    },
  );

  test('should handle null return from messageFn and fallback to default', () {
    final result = l.nullValue(messageFn: () => null).validateValue('not null');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be null']);
    }
  });
}
