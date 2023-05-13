import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid bool', () {
    final result = l.bool().validateValue(true);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, true);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is not a valid bool', () {
    final result = l.bool().validateValue('user');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a bool']);
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().bool().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
