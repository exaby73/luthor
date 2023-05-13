import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid cuid', () {
    final result = l.string().cuid().validateValue('clgtidfup000001pr8qnxasa9');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'clgtidfup000001pr8qnxasa9');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is not a valid cuid', () {
    final result = l.string().cuid().validateValue('user');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a valid cuid']);
    }
  });

  test('should return true when value is null', () {
    final result = l.string().cuid().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().cuid().required().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
