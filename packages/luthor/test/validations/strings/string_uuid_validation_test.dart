import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid uuid', () {
    final result =
        l.string().uuid().validateValue('b058f7f6-e1e1-11ed-b5ea-0242ac120002');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'b058f7f6-e1e1-11ed-b5ea-0242ac120002');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is not a valid uuid', () {
    final result = l.string().uuid().validateValue('user');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a valid uuid']);
    }
  });

  test('should return true when value is null', () {
    final result = l.string().uuid().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().uuid().required().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
