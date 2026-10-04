import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'utils/matchers.dart';

void main() {
  group('Given a schema with required and optional fields', () {
    late SchemaValidator schema;

    setUp(() {
      schema = l.schema({
        'email': l.string().email().required(),
        'displayName': l.string().min(2),
        'age': l.int().min(18),
      });
    });

    test('When required data is valid and optional data is missing then it '
        'passes', () {
      expect(
        schema.validate({'email': 'dev@example.com'}),
        isValidWith({'email': 'dev@example.com'}),
      );
    });

    test('When an optional field is present and null then it passes and is '
        'kept', () {
      expect(
        schema.validate({'email': 'dev@example.com', 'age': null}),
        isValidWith({'email': 'dev@example.com', 'age': null}),
      );
    });

    group('When required data is missing and optional data is invalid', () {
      late ValidationResult<Map<String, Object?>?> result;

      setUp(() {
        result = schema.validate({'displayName': 'x', 'age': 17});
      });

      test('Then each field reports its error under its key', () {
        expect(
          result,
          hasErrors({
            'email': ['email is required'],
            'displayName': ['displayName must be at least 2 characters long'],
            'age': ['age must be greater than or equal to 18'],
          }),
        );
      });

      test('Then the issues carry the field path and field name', () {
        expect(
          result.issues.first,
          isIssue(
            code: IssueCode.required,
            path: ['email'],
            fieldName: 'email',
          ),
        );
      });
    });
  });

  group('Given a schema with nested objects', () {
    late SchemaValidator schema;

    setUp(() {
      schema = l.schema({
        'profile': l.schema({
          'email': l.string().email().required(),
        }).required(),
      });
    });

    test('When nested data is invalid then the error is at its dot path', () {
      final result = schema.validate({
        'profile': {'email': 'not-an-email'},
      });

      expect(
        result.getError('profile.email'),
        'email must be a valid email address',
      );
    });

    test('When the nested map has dynamic type arguments then the errors '
        'have the same shape', () {
      final typed = schema.validate({'profile': <String, Object?>{}});
      final untyped = schema.validate({'profile': <dynamic, dynamic>{}});

      expect(untyped.errors, typed.errors);
      expect(untyped.errors, {
        'profile.email': ['email is required'],
      });
    });

    test('When a required nested schema is missing then it is required', () {
      expect(
        schema.validate(<String, Object?>{}),
        hasErrors({
          'profile': ['profile is required'],
        }),
      );
    });

    test('When the nested value is not a map then the message names the '
        'field', () {
      expect(
        schema.validate({'profile': 'str'}),
        hasErrors({
          'profile': ['profile must be a map'],
        }),
      );
    });
  });

  group('Given a schema with a custom type message', () {
    test('When the value is not a map then the custom message is used', () {
      expect(
        l.schema({}, message: 'expected an object').validate(5),
        isInvalidWith(['expected an object']),
      );
      expect(
        l
            .schema(
              {},
              messageBuilder: (issue) => '${issue.params['expected']} needed',
            )
            .validate(5),
        isInvalidWith(['map needed']),
      );
    });
  });

  group('Given unknown keys in the input', () {
    late Map<String, Object?> input;

    setUp(() {
      input = {'a': 1, 'evil': true};
    });

    test('When the schema is default then unknown keys are stripped', () {
      expect(l.schema({'a': l.int()}).validate(input), isValidWith({'a': 1}));
    });

    test('When the schema is passthrough then unknown keys are kept', () {
      expect(
        l.schema({'a': l.int()}).passthrough().validate(input),
        isValidWith({'a': 1, 'evil': true}),
      );
    });

    test('When the schema is strict then each unknown key is an issue', () {
      final result = l.schema({'a': l.int()}).strict().validate({
        'a': 1,
        'evil': true,
        'extra': 2,
      });

      expect(result.issues, [
        isIssue(
          code: IssueCode.unrecognizedKey,
          path: ['evil'],
          message: 'evil is not an allowed key',
          params: {'key': 'evil'},
        ),
        isIssue(code: IssueCode.unrecognizedKey, path: ['extra']),
      ]);
    });
  });

  group('Given a custom validator on a schema', () {
    test('When it fails at the root then the error is object-level', () {
      final result = l
          .schema({'a': l.int()})
          .custom((data) => false, message: 'bad')
          .validate({'a': 1});

      expect(
        result,
        hasErrors({
          '': ['bad'],
        }),
      );
      expect(result.getError(''), 'bad');
    });

    test('When a nested schema fails then its error is at the nested path', () {
      final result = l
          .schema({
            'range': l
                .schema({'a': l.int(), 'b': l.int()})
                .custom((data) => false, message: 'bad range'),
          })
          .validate({
            'range': {'a': 1, 'b': 0},
          });

      expect(
        result,
        hasErrors({
          'range': ['bad range'],
        }),
      );
    });

    test('When a child field has the same key as the parent then the errors '
        'do not collide', () {
      final result = l
          .schema({
            'a': l
                .schema({'a': l.string().required()})
                .custom((data) => false, message: 'parent custom'),
          })
          .validate({'a': <String, Object?>{}});

      expect(
        result,
        hasErrors({
          'a.a': ['a is required'],
        }),
      );
    });

    test('When the child is a failing nested schema then validation does not '
        'throw', () {
      final result = l
          .schema({
            'a': l
                .schema({
                  'a': l.schema({'x': l.int().required()}).required(),
                })
                .custom((data) => false, message: 'parent custom'),
          })
          .validate({
            'a': {'a': <String, Object?>{}},
          });

      expect(
        result,
        hasErrors({
          'a.a.x': ['x is required'],
        }),
      );
    });

    test('When a field is named [DEFAULT] then it is an ordinary field', () {
      final result = l
          .schema({'[DEFAULT]': l.int()})
          .custom((data) => false, message: 'object')
          .validate({'[DEFAULT]': 'x'});

      expect(
        result,
        hasErrors({
          '[DEFAULT]': ['[DEFAULT] must be an integer'],
        }),
      );
    });

    test('When the children are valid then the function receives the typed '
        'output', () {
      final result = l
          .schema({'a': l.int().required(), 'b': l.int().required()})
          .custom((data) => (data['a']! as int) < (data['b']! as int))
          .validate({'a': 2, 'b': 1});

      expect(result.issues, [isIssue(code: IssueCode.custom, path: [])]);
    });
  });

  group('Given a valid schema validated directly', () {
    test('When validated then the result is a success', () {
      expect(l.schema({'a': l.int()}).validate({'a': 1}).isValid, isTrue);
    });

    test('When validated with a name then every field error is kept', () {
      final result = l
          .schema({'a': l.int(), 'b': l.int()})
          .withName('a')
          .validate({'a': 'x', 'b': 'y'});

      expect(
        result,
        hasErrors({
          'a': ['a must be an integer'],
          'b': ['b must be an integer'],
        }),
      );
    });
  });

  group('Given a schema custom validator', () {
    late SchemaValidator schema;

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

    test('When fields differ then the field error is reported', () {
      expect(
        schema.validate({'password': 'secret', 'confirmPassword': 'other'}),
        hasErrors({
          'confirmPassword': ['passwords must match'],
        }),
      );
    });

    test('When fields match then it passes', () {
      expect(
        schema.validate({'password': 'secret', 'confirmPassword': 'secret'}),
        isValidWith({'password': 'secret', 'confirmPassword': 'secret'}),
      );
    });
  });

  group('Given a schema custom validator reused after a schema validation', () {
    late StringValidator<String?> confirm;

    setUp(() {
      confirm = l.string().customWithSchema(
        (value, data) => value == data['password'],
        message: 'mismatch',
      );
      l.schema({'password': l.string(), 'confirm': confirm}).validate({
        'password': 'abc',
        'confirm': 'abc',
      });
    });

    test('When validated outside a schema then it sees empty data, not the '
        'earlier data', () {
      expect(confirm.validate('abc'), isInvalidWith(['mismatch']));
    });
  });

  group('Given a schema custom validator inside a list', () {
    test('When the list is a schema field then it sees the schema data', () {
      final schema = l.schema({
        'password': l.string(),
        'list': l.list(
          l.string().customWithSchema(
            (value, data) => value == data['password'],
            message: 'mismatch',
          ),
        ),
      });

      expect(
        schema.validate({
          'password': 'a',
          'list': ['a', 'b'],
        }),
        hasErrors({
          'list.1': ['mismatch'],
        }),
      );
    });
  });

  group('Given a schema custom validator in a nested schema', () {
    late SchemaValidator schema;

    setUp(() {
      schema = l.schema({
        'password': l.string(),
        'inner': l.schema({
          'confirm': l.string().customWithSchema(
            (value, data) => value == data.root['password'],
            message: 'mismatch',
          ),
          'sibling': l.string().customWithSchema(
            (value, data) => data['confirm'] == value,
          ),
        }),
      });
    });

    test('When it reads the root data then it sees the outer fields', () {
      expect(
        schema.validate({
          'password': 'a',
          'inner': {'confirm': 'b'},
        }),
        hasErrors({
          'inner.confirm': ['mismatch'],
        }),
      );
    });

    test('When it reads its schema data then it sees the nested siblings', () {
      expect(
        schema.validate({
          'password': 'a',
          'inner': {'confirm': 'a', 'sibling': 'a'},
        }).isValid,
        isTrue,
      );
    });
  });

  group('Given validateSchema with fromJson', () {
    late SchemaValidator schema;

    setUp(() {
      schema = l.schema({'email': l.string().email().required()});
    });

    test('When validation succeeds then the converted data is returned', () {
      final ValidationResult<Account> result = schema.validateSchema({
        'email': 'dev@example.com',
        'unknown': 1,
      }, fromJson: Account.fromJson);

      expect(result, isValidWith(const Account('dev@example.com')));
    });

    test('When validation fails then fromJson is not called', () {
      var called = false;

      final result = schema.validateSchema(
        {'email': 'bad'},
        fromJson: (json) {
          called = true;
          return const Account('x');
        },
      );

      expect(called, isFalse);
      expect(
        result,
        hasErrors({
          'email': ['email must be a valid email address'],
        }),
      );
    });

    test(
      'When fromJson throws then the error is an issue, not an exception',
      () {
        final optional = l.schema({'email': l.string()});

        final result = optional.validateSchema(
          <String, Object?>{},
          fromJson: Account.fromJson,
        );

        expect(result.issues, [
          isIssue(
            code: IssueCode.fromJsonFailed,
            path: [],
            message: 'value could not be converted',
          ),
        ]);
        expect(result.issues.single.params['error'], isA<TypeError>());
      },
    );

    test(
      'When fromJson returns null for a nullable model then it succeeds',
      () {
        final result = schema.validateSchema<Account?>({
          'email': 'dev@example.com',
        }, fromJson: (_) => null);

        expect(result, isValidWith(null));
      },
    );

    test('When the input is not a map then a type issue is returned', () {
      expect(
        schema.validateSchema('nope', fromJson: Account.fromJson),
        isInvalidWith(['value must be a map']),
      );
    });

    test('When the input is null then a required issue is returned', () {
      expect(
        schema.validateSchema(null, fromJson: Account.fromJson),
        isInvalidWith(['value is required']),
      );
    });
  });

  group('Given validate without fromJson', () {
    test('When the data is valid then it is typed as a map', () {
      final ValidationResult<Map<String, Object?>> result = l
          .schema({'name': l.string()})
          .required()
          .validate({'name': 'x'});

      expect(result, isValidWith({'name': 'x'}));
    });
  });
}

final class Account {
  const Account(this.email);

  factory Account.fromJson(Map<String, Object?> json) {
    return Account(json['email']! as String);
  }

  final String email;

  @override
  bool operator ==(Object other) => other is Account && other.email == email;

  @override
  int get hashCode => email.hashCode;
}
