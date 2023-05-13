import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is an int', () {
    final result = l.number().validateValue(1);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 1);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return true when value is a floating point', () {
    final result = l.number().validateValue(1.1);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 1.1);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is not a number', () {
    final result = l.number().validateValue('a');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a number']);
    }
  });

  test('should return true when value is null', () {
    final result = l.number().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().number().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
