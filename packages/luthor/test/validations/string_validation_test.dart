import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a string', () {
    final result = l.string().validateValue('a');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'a');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is not a string', () {
    final result = l.string().validateValue(1);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a string']);
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().string().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
