import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test(
    'should return true if the string ends with the string specified',
    () {
      final result = l.string().endsWith('bc').validateValue('abc');

      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, 'abc');
        case SingleValidationError(data: _, errors: _):
          fail('should not have errors');
      }
    },
  );

  test(
    'should return true when the value is null',
    () {
      final result = l.string().endsWith('ab').validateValue(null);

      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, isNull);
        case SingleValidationError(data: _, errors: _):
          fail('should not have errors');
      }
    },
  );

  test(
      'should return error if the string does not end with the string specified',
      () {
    final result = l.string().endsWith('ab').validateValue('abc');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not have data');
      case SingleValidationError(data: _, errors: _):
        expect(result.errors, ['value does not end with "ab"']);
    }
  });
}
