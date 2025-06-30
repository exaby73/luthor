import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  group('validateValue', () {
    test('should return the custom message when provided', () {
      final result = l.string(message: 'custom message').validateValue(1);

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['custom message']);
      }
    });
  });

  group('validateWithFieldName', () {
    test('should have the fieldName in the error message', () {
      final result = l.required().string().validateValueWithFieldName(
        'name',
        null,
      );

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['name is required']);
      }
    });
  });
}
