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
}
