import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid URL', () {
    final result = l.string().url().validateValue('https://dart.dev');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'https://dart.dev');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should accept any valid scheme by default', () {
    final validator = l.string().url();

    for (final url in [
      'http://example.com',
      'https://example.com',
      'ftp://example.com',
      'sftp://example.com',
      'ws://example.com',
      'wss://example.com',
    ]) {
      final result = validator.validateValue(url);
      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, url);
        case SingleValidationError(data: _, errors: _):
          fail('should not have errors for $url');
      }
    }
  });

  test(
    'should return true when value is a valid URL and matches the scheme',
    () {
      final result = l
          .string()
          .url(allowedSchemes: ['https'])
          .validateValue('https://dart.dev');

      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, 'https://dart.dev');
        case SingleValidationError(data: _, errors: _):
          fail('should not have errors');
      }
    },
  );

  test(
    'should return false when value is a valid URL but does not match the scheme',
    () {
      final result = l
          .string()
          .url(allowedSchemes: ['https'])
          .validateValue('http://dart.dev');

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, [
            'value must be a valid URL. Allowed scheme is https',
          ]);
      }
    },
  );

  test('should return false when value is not a valid URL', () {
    final result = l.string().url().validateValue('hello');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a valid URL']);
    }
  });

  test('should return false when URL contains whitespace', () {
    final result = l.string().url().validateValue(
      'https://dart.dev/path with space',
    );

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a valid URL']);
    }
  });

  test('should return false when URL has no host', () {
    final result = l.string().url().validateValue('https://');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a valid URL']);
    }
  });

  test('should return true when value is null', () {
    final result = l.string().url().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().url().required().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
