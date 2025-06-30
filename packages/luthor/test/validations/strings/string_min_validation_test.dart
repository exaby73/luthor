import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test(
    'should return true if the string length is greater than or equal to minLength',
    () {
      final result = l.string().min(3).validateValue('abc');

      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, 'abc');
        case SingleValidationError(data: _, errors: _):
          fail('should not have errors');
      }
    },
  );

  test('should return false if the string length is less than minLength', () {
    final result = l.string().min(3).validateValue('ab');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be at least 3 characters long']);
    }
  });

  test('should return true when the value is null', () {
    final result = l.string().min(3).validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().min(3).required().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
