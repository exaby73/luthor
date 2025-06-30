import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true if the string length equal to length specified', () {
    final result = l.string().length(3).validateValue('abc');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'abc');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return true when the value is null', () {
    final result = l.string().length(3).validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test(
    'should return false if the string length is less than or greater than length specified',
    () {
      final lessThenResult = l.string().length(3).validateValue('ab');

      switch (lessThenResult) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['value must be exactly 3 characters long']);
      }

      final greaterThenResult = l.string().length(3).validateValue('abcd');

      switch (greaterThenResult) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['value must be exactly 3 characters long']);
      }
    },
  );
}
