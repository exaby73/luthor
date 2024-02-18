import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test(
    'should return true if the num is greater than or equal to minValue',
    () {
      final result = l.number().min(3).validateValue(4);

      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, 4);
        case SingleValidationError(data: _, errors: _):
          fail('should not have errors');
      }
    },
  );

  test(
    'should return false if the num is less than minValue',
    () {
      final result = l.number().min(3).validateValue(2);

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['value must be greater than or equal to 3']);
      }
    },
  );

  test(
    'should return true when the value is null',
    () {
      final result = l.number().min(3).validateValue(null);

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
      final result = l.number().min(3).required().validateValue(null);

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['value is required']);
      }
    },
  );
}
