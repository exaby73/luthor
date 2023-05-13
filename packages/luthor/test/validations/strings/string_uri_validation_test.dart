import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid uri', () {
    final result = l.string().uri().validateValue('https://dart.dev');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'https://dart.dev');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return true when value is a valid uri and matches the scheme',
      () {
    final result = l
        .string()
        .uri(allowedSchemes: ['https']).validateValue('https://dart.dev');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'https://dart.dev');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test(
    'should return false when value is a valid uri but does not match the scheme',
    () {
      final result = l
          .string()
          .uri(allowedSchemes: ['https']).validateValue('http://dart.dev');

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(
            errors,
            ['value must be a valid uri. Allowed scheme is https'],
          );
      }
    },
  );

  test('should return false when value is not a valid uri', () {
    final result = l.string().uri().validateValue(':hello');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a valid uri']);
    }
  });

  test('should return true when value is null', () {
    final result = l.string().uri().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().uri().required().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
