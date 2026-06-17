import 'dart:typed_data';

import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'utils/matchers.dart';

void main() {
  group('Given reusable validators', () {
    test(
      'When adding string modifiers then the original validator is unchanged',
      () {
        final validator = l.string();

        final emailValidator = validator.email();
        final uuidValidator = validator.uuid();

        expect(validator.validateValue('not-an-email').isValid, isTrue);
        expect(emailValidator.validateValue('not-an-email').isValid, isFalse);
        expect(uuidValidator.validateValue('not-a-uuid').isValid, isFalse);
      },
    );

    test(
      'When adding number modifiers then the original validator is unchanged',
      () {
        final validator = l.number();

        final minimumValidator = validator.min(3);
        final maximumValidator = validator.max(10);

        expect(validator.validateValue(1).isValid, isTrue);
        expect(minimumValidator.validateValue(1).isValid, isFalse);
        expect(maximumValidator.validateValue(11).isValid, isFalse);
      },
    );

    test(
      'When adding int modifiers then the original validator is unchanged',
      () {
        final validator = l.int();

        final minimumValidator = validator.min(3);
        final maximumValidator = validator.max(10);

        expect(validator.validateValue(1).isValid, isTrue);
        expect(minimumValidator.validateValue(1).isValid, isFalse);
        expect(maximumValidator.validateValue(11).isValid, isFalse);
      },
    );

    test(
      'When adding double modifiers then the original validator is unchanged',
      () {
        final validator = l.double();

        final minimumValidator = validator.min(3);
        final maximumValidator = validator.max(10);

        expect(validator.validateValue(1.5).isValid, isTrue);
        expect(minimumValidator.validateValue(1.5).isValid, isFalse);
        expect(maximumValidator.validateValue(11.5).isValid, isFalse);
      },
    );
  });

  group('Given single-value validators', () {
    group('When values match their declared type', () {
      test('Then valid results are returned', () {
        expect(l.any().validateValue(Object()).isValid, isTrue);
        expect(l.boolean().validateValue(false).isValid, isTrue);
        expect(l.double().validateValue(1.2).isValid, isTrue);
        expect(l.file().validateValue(Uint8List.fromList([1])).isValid, isTrue);
        expect(l.int().validateValue(1).isValid, isTrue);
        expect(l.list().validateValue(<Object?>[]).isValid, isTrue);
        expect(l.map().validateValue(<String, Object?>{}).isValid, isTrue);
        expect(l.nullValue().validateValue(null).isValid, isTrue);
        expect(l.number().validateValue(1.2).isValid, isTrue);
        expect(l.string().validateValue('value').isValid, isTrue);
      });
    });

    group('When values violate required type constraints', () {
      test('Then invalid results include the default message', () {
        expect(
          l.boolean().validateValue('false'),
          isSingleError<String>(['value must be a bool']),
        );
        expect(
          l.double().validateValue(1),
          isSingleError<int>(['value must be a double']),
        );
        expect(
          l.int().validateValue(1.2),
          isSingleError<double>(['value must be an integer']),
        );
        expect(
          l.map().validateValue('value'),
          isSingleError<String>(['value must be a Map']),
        );
        expect(
          l.string().validateValue(1),
          isSingleError<int>(['value must be a string']),
        );
      });
    });

    group('When values are nullable but marked required', () {
      test('Then null fails with the required message', () {
        expect(
          l.string().required().validateValue(null),
          isSingleError<Object?>(['value is required']),
        );
      });
    });

    group('When custom messages are configured', () {
      test('Then explicit message wins over messageFn', () {
        expect(
          l
              .string()
              .email(message: 'bad email', messageFn: () => 'ignored')
              .validateValue('nope'),
          isSingleError<String>(['bad email']),
        );
      });

      test('Then null messageFn falls back to default message', () {
        expect(
          l.string().min(3, messageFn: () => null).validateValue('ab'),
          isSingleError<String>(['value must be at least 3 characters long']),
        );
      });
    });
  });

  group('Given string modifiers', () {
    test(
      'When validating representative values then expected outcomes are returned',
      () {
        expect(
          l.string().contains('ut').validateValue('luthor').isValid,
          isTrue,
        );
        expect(
          l.string().cuid().validateValue('ckckf3qew000001l3f8gh4r6r').isValid,
          isTrue,
        );
        expect(
          l.string().cuid2().validateValue('tz4a98xxat96iws9zmbrgj3a').isValid,
          isTrue,
        );
        expect(
          l.string().dateTime().validateValue('2026-06-17T12:00:00Z').isValid,
          isTrue,
        );
        expect(
          l.string().email().validateValue('dev@example.com').isValid,
          isTrue,
        );
        expect(l.string().emoji().validateValue('🔥').isValid, isTrue);
        expect(
          l.string().endsWith('or').validateValue('luthor').isValid,
          isTrue,
        );
        expect(
          l
              .string()
              .ip(version: IpVersion.v4)
              .validateValue('127.0.0.1')
              .isValid,
          isTrue,
        );
        expect(l.string().length(6).validateValue('luthor').isValid, isTrue);
        expect(l.string().max(6).validateValue('luthor').isValid, isTrue);
        expect(l.string().min(6).validateValue('luthor').isValid, isTrue);
        expect(
          l.string().regex('^luth').validateValue('luthor').isValid,
          isTrue,
        );
        expect(
          l.string().startsWith('lut').validateValue('luthor').isValid,
          isTrue,
        );
        expect(
          l
              .string()
              .uri(allowedSchemes: ['mailto'])
              .validateValue('mailto:dev@example.com')
              .isValid,
          isTrue,
        );
        expect(
          l
              .string()
              .url(allowedSchemes: ['https'])
              .validateValue('https://example.com')
              .isValid,
          isTrue,
        );
        expect(
          l
              .string()
              .uuid()
              .validateValue('550e8400-e29b-41d4-a716-446655440000')
              .isValid,
          isTrue,
        );
      },
    );
  });
}
