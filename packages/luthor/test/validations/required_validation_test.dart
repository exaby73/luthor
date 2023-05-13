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
}
