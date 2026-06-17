import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'utils/matchers.dart';

void main() {
  group('Given a schema with required and optional fields', () {
    late Validator schema;
    late Map<String, Object?> value;
    late SchemaValidationResult<Map<String, Object?>> result;

    setUp(() {
      schema = l.schema({
        'email': l.string().email().required(),
        'displayName': l.string().min(2),
        'age': l.int().min(18),
      });
    });

    group('When required data is valid and optional data is missing', () {
      setUp(() {
        value = {'email': 'dev@example.com'};
        result = schema.validateSchema(value);
      });

      test('Then schema validation succeeds', () {
        expect(result, isA<SchemaValidationSuccess<Map<String, Object?>>>());
      });
    });

    group('When required data is missing and optional data is invalid', () {
      setUp(() {
        value = {'displayName': 'x', 'age': 17};
        result = schema.validateSchema(value);
      });

      test('Then schema validation fails with field errors', () {
        expect(
          result,
          isSchemaError<Map<String, Object?>>({
            'email': ['email is required'],
            'displayName': ['displayName must be at least 2 characters long'],
            'age': ['age must be greater than or equal to 18'],
          }),
        );
      });
    });
  });

  group('Given a schema with custom schema validation', () {
    late Validator schema;
    late SchemaValidationResult<Map<String, Object?>> result;

    setUp(() {
      schema = l.schema({
        'password': l.string().required(),
        'confirmPassword': l
            .string()
            .customWithSchema(
              (value, data) => value == data['password'],
              message: 'passwords must match',
            )
            .required(),
      });
    });

    group('When fields do not satisfy cross-field validation', () {
      setUp(() {
        result = schema.validateSchema({
          'password': 'secret',
          'confirmPassword': 'different',
        });
      });

      test('Then schema validation reports the custom field error', () {
        expect(
          result,
          isSchemaError<Map<String, Object?>>({
            'confirmPassword': ['passwords must match'],
          }),
        );
      });
    });
  });

  group('Given a schema with nested objects', () {
    late Validator schema;
    late SchemaValidationError<Map<String, Object?>> result;

    setUp(() {
      schema = l.schema({
        'profile': l.schema({
          'email': l.string().email().required(),
        }).required(),
      });
    });

    group('When nested data is invalid', () {
      setUp(() {
        result =
            schema.validateSchema<Map<String, Object?>>({
                  'profile': {'email': 'not-an-email'},
                })
                as SchemaValidationError<Map<String, Object?>>;
      });

      test('Then nested errors are available by dot notation', () {
        expect(
          result.getError('profile.email'),
          'email must be a valid email address',
        );
      });
    });
  });

  group('Given a schema with map key and value validators', () {
    late Validator schema;
    late SchemaValidationResult<Map<String, Object?>> result;

    setUp(() {
      schema = l.schema({
        'labels': l.map(
          keyValidator: l.string().startsWith('x-'),
          valueValidator: l.string().min(2),
        ),
      });
    });

    group('When map keys and values are invalid', () {
      setUp(() {
        result = schema.validateSchema({
          'labels': {'bad': 'x'},
        });
      });

      test('Then structured map errors stay under the schema field', () {
        expect(
          result,
          isSchemaError<Map<String, Object?>>({
            'labels': {
              'keys': {
                'bad': ['value does not start with "x-"'],
              },
              'values': {
                'bad': ['value must be at least 2 characters long'],
              },
            },
          }),
        );
      });
    });
  });

  group('Given a field-named map validator with non-string keys', () {
    late SingleValidationResult<Map<int, String>> result;

    group('When key validation fails', () {
      setUp(() {
        result = l.map(keyValidator: l.string()).validateValueWithFieldName(
          'labels',
          {1: 'one'},
        );
      });

      test('Then validation returns flattened errors instead of throwing', () {
        expect(
          result,
          isSingleError<Map<int, String>>(['keys.1: value must be a string']),
        );
      });
    });
  });

  group('Given a list with item validators', () {
    late SingleValidationResult<List<Object?>> result;

    group('When every item matches at least one validator', () {
      setUp(() {
        final values = <Object?>['dev@example.com', 1];
        result = l
            .list(validators: [l.string().email(), l.int().min(1)])
            .validateValue(values);
      });

      test('Then list validation succeeds', () {
        expect(result.isValid, isTrue);
      });
    });

    group('When an item matches no validator', () {
      setUp(() {
        final values = <Object?>['dev@example.com', 0];
        result = l
            .list(validators: [l.string().email(), l.int().min(1)])
            .validateValue(values);
      });

      test('Then list validation fails', () {
        expect(
          result,
          isSingleError<List<Object?>>([
            'value must be a list or does not match the validations',
          ]),
        );
      });
    });
  });

  group('Given a recursive schema reference', () {
    late Validator nodeSchema;
    late SchemaValidationResult<Map<String, Object?>> result;

    setUp(() {
      nodeSchema = l.schema({
        'name': l.string().required(),
        'children': l.list(validators: [forwardRef(() => nodeSchema)]),
      });
    });

    group('When validating nested children', () {
      setUp(() {
        result = nodeSchema.validateSchema({
          'name': 'root',
          'children': [
            {'name': 'child', 'children': <Object?>[]},
          ],
        });
      });

      test('Then validation completes successfully', () {
        expect(result.isValid, isTrue);
      });
    });
  });

  group('Given fromJson conversion', () {
    late SchemaValidationResult<Account> result;

    group('When schema validation succeeds', () {
      setUp(() {
        result = l
            .schema({'email': l.string().email().required()})
            .validateSchema<Account>({
              'email': 'dev@example.com',
            }, fromJson: Account.fromJson);
      });

      test('Then converted data is returned', () {
        expect(result, isA<SchemaValidationSuccess<Account>>());
        expect(result.data!.email, 'dev@example.com');
      });
    });
  });
}

class Account {
  final String email;

  Account({required this.email});

  factory Account.fromJson(Map<String, Object?> json) {
    return Account(email: json['email']! as String);
  }
}
