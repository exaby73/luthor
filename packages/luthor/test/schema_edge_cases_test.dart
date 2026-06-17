import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'utils/matchers.dart';

void main() {
  group('Given a schema validator used as a single-value validator', () {
    test('When value is not a map then validation fails', () {
      expect(
        l.schema({'email': l.string()}).validateValue('not-map'),
        isSingleError<String>(['value must be a map']),
      );
    });

    test('When field name is provided then non-map errors use that field', () {
      expect(
        l
            .schema({'email': l.string()})
            .validateValueWithFieldName('profile', 'not-map'),
        isSingleError<String>(['value must be a map']),
      );
    });
  });

  group('Given fromJson conversion', () {
    late bool didConvert;
    late SchemaValidationResult<Account> result;

    group('When schema validation fails', () {
      setUp(() {
        didConvert = false;
        result = l
            .schema({'email': l.string().email().required()})
            .validateSchema<Account>(
              {'email': 'bad'},
              fromJson: (json) {
                didConvert = true;
                return const Account();
              },
            );
      });

      test('Then converter is not called and error data is null', () {
        expect(didConvert, isFalse);
        expect(result.data, isNull);
        expect(
          result,
          isSchemaError<Account>({
            'email': ['email must be a valid email address'],
          }),
        );
      });
    });
  });

  group('Given a schema custom validator outside schema validation', () {
    test('When no schema data is available then validation succeeds', () {
      final result = l
          .customWithSchema((value, data) => false)
          .validateValue('anything');

      expect(result.isValid, isTrue);
    });
  });
}

class Account {
  const Account();
}
