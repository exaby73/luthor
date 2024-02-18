import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when custom validator passes', () {
    final result = l.custom((value) {
      return value! as bool;
    }).validateValue(true);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, true);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when custom validator fails', () {
    final result = l.custom((value) {
      return !(value! as bool);
    }).validateValue(true);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value does not pass custom validation']);
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().custom((value) {
      return true;
    }).validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
