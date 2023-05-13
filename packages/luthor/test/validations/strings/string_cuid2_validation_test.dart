import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid cuid2', () {
    final result = l.string().cuid2().validateValue('gnu9eq6nqho8zk0cq4uev49x');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'gnu9eq6nqho8zk0cq4uev49x');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is not a valid cuid2', () {
    final result = l.string().cuid2().validateValue('@');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a valid cuid2']);
    }
  });

  test('should return true when value is null', () {
    final result = l.string().cuid2().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().cuid2().required().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
