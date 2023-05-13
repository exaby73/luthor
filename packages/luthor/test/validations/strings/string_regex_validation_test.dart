import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value match regex', () {
    final result = l
        .string()
        .regex(r'^luthor(?:_(annotation|generator))?$')
        .validateValue('luthor');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'luthor');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test("should return false when value didn't match regex", () {
    final result = l
        .string()
        .regex(r'^luthor(?:_(annotation|generator))?$')
        .validateValue('bad value');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must match regex']);
    }
  });

  test('should return true when value is null', () {
    final result = l.string().regex('pattern').validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().regex('pattern').required().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
