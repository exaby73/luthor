import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test(
    'should return true if the double is less than or equal to maxValue',
    () {
      final result = l.double().max(3.0).validateValue(2.0);

      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, 2.0);
        case SingleValidationError(data: _, errors: _):
          fail('should not have errors');
      }
    },
  );

  test(
    'should return false if the double is greater than maxValue',
    () {
      final result = l.double().max(3.0).validateValue(4.0);

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['value must be less than or equal to 3.0']);
      }
    },
  );

  test(
    'should return true when the value is null',
    () {
      final result = l.double().max(3.0).validateValue(null);

      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, isNull);
        case SingleValidationError(data: _, errors: _):
          fail('should not have errors');
      }
    },
  );

  test(
    'should return false if the value is null with required()',
    () {
      final result = l.double().max(3.0).required().validateValue(null);

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['value is required']);
      }
    },
  );
}
