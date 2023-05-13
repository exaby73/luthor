import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid emoji', () {
    final result = l.string().emoji().validateValue('👍');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, '👍');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is not a valid emoji', () {
    final result = l.string().emoji().validateValue('a');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a valid emoji']);
    }
  });

  test('should return true when value is null', () {
    final result = l.string().emoji().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().emoji().required().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
