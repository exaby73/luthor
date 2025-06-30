import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true if the string contains the string specified', () {
    final result = l.string().contains('b').validateValue('abc');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'abc');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return true when the value is null', () {
    final result = l.string().contains('ab').validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test(
    'should return error if the string does not end with the string specified',
    () {
      final result = l.string().contains('ac').validateValue('abc');

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not have data');
        case SingleValidationError(data: _, errors: _):
          expect(result.errors, ['value does not contain "ac"']);
      }
    },
  );
}
