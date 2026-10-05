import 'dart:typed_data';

import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'utils/matchers.dart';

void main() {
  group('Given a list of schemas', () {
    late SchemaValidator schema;

    setUp(() {
      schema = l.schema({
        'items': l.list(l.schema({'id': l.int().required()}).required()),
      });
    });

    test('When one element is invalid then the error is at its index', () {
      final result = schema.validate({
        'items': [
          {'id': 1},
          {'id': 'x'},
        ],
      });

      expect(
        result,
        hasErrors({
          'items.1.id': ['id must be an integer'],
        }),
      );
      expect(result.getError('items.1.id'), 'id must be an integer');
    });

    test('When every element is valid then the output is a typed list', () {
      final result = schema.validate({
        'items': [
          {'id': 1, 'extra': true},
        ],
      });

      expect(
        result,
        isValidWith({
          'items': [
            {'id': 1},
          ],
        }),
      );
    });
  });

  group('Given a list field in a schema', () {
    test('When the value is not a list then the message names the field', () {
      expect(
        l.schema({'tags': l.list(l.string())}).validate({'tags': 5}),
        hasErrors({
          'tags': ['tags must be a list'],
        }),
      );
    });

    test('When an element fails then its message uses the list field name', () {
      expect(
        l.schema({'tags': l.list(l.string().min(3))}).validate({
          'tags': ['abc', 'a'],
        }),
        hasErrors({
          'tags.1': ['tags must be at least 3 characters long'],
        }),
      );
    });
  });

  group('Given a list element validator', () {
    test('When the element validator is optional then null elements pass', () {
      final ValidationResult<List<int?>?> result = l.list(l.int()).validate([
        1,
        null,
      ]);

      expect(result, isValidWith([1, null]));
    });

    test('When the element validator is required then null elements fail', () {
      final result = l.list(l.int().required()).validate([1, null]);

      expect(result.issues, [
        isIssue(code: IssueCode.required, path: [1]),
      ]);
    });

    test(
      'When the element validator accepts anything then any element passes',
      () {
        expect(l.list(l.any()).validate([Object, null, 1]).isValid, isTrue);
      },
    );

    test(
      'When the elements are valid then the output has the element type',
      () {
        final result = l.list(l.string().required()).required().validate([
          'a',
          'b',
        ]);

        final List<String> data = switch (result) {
          ValidationSuccess(:final data) => data,
          ValidationFailure() => [],
        };

        expect(data, ['a', 'b']);
      },
    );
  });

  group('Given a union of validators', () {
    late UnionValidator<Object?> union;

    setUp(() {
      union = l.union([l.string().email(), l.int().min(1)]);
    });

    test('When the value passes an option then it passes', () {
      expect(union.validate('dev@example.com'), isValidWith('dev@example.com'));
      expect(union.validate(2), isValidWith(2));
    });

    group('When the value passes no option', () {
      late ValidationResult<Object?> result;

      setUp(() {
        result = union.validate(0);
      });

      test('Then one invalidUnion issue is reported', () {
        expect(result.issues, [
          isIssue(
            code: IssueCode.invalidUnion,
            path: [],
            message: 'value does not match any allowed option',
          ),
        ]);
      });

      test('Then the issue holds the issues of each option', () {
        final optionIssues =
            result.issues.single.params['issues']!
                as List<List<ValidationIssue>>;

        expect(optionIssues, [
          [isIssue(code: IssueCode.invalidType)],
          [isIssue(code: IssueCode.tooSmall)],
        ]);
      });
    });

    test(
      'When used as list elements then each element may match any option',
      () {
        final list = l.list(union);

        expect(list.validate(['dev@example.com', 1]).isValid, isTrue);
        expect(
          list.validate(['dev@example.com', 0]),
          hasErrors({
            '1': ['value does not match any allowed option'],
          }),
        );
      },
    );

    test('When the value is null then the union is optional', () {
      expect(union.validate(null), isValidWith(null));
      expect(
        union.required().validate(null),
        isInvalidWith(['value is required']),
      );
    });

    test('When created without options then it throws', () {
      expect(() => l.union([]), throwsArgumentError);
    });
  });

  group('Given allowed values', () {
    late OneOfValidator<String, String?> role;

    setUp(() {
      role = l.oneOf(['admin', 'member']);
    });

    test('When the value is allowed then it passes', () {
      expect(role.validate('admin'), isValidWith('admin'));
    });

    test('When the value is not allowed then a notOneOf issue is reported', () {
      expect(role.validate('owner').issues, [
        isIssue(
          code: IssueCode.notOneOf,
          message: 'value must be one of: admin, member',
          params: {
            'allowed': ['admin', 'member'],
          },
        ),
      ]);
    });

    test('When values are JsonValue integers then equal numbers map to the '
        'allowed value', () {
      final result = l.oneOf([1, 2]).required().validate(1.0);

      expect(result, isValidWith(1));
      expect(result, isA<ValidationSuccess<int>>());
    });

    test('When created without values then it throws', () {
      expect(() => l.oneOf(<String>[]), throwsArgumentError);
    });
  });

  group('Given a map with key and value validators', () {
    late MapValidator<int, String, Map<int, String>?> map;

    setUp(() {
      map = l.map(
        keyValidator: l.int().required(),
        valueValidator: l.string().required(),
      );
    });

    group('When both the key and the value fail', () {
      late ValidationResult<Map<int, String>?> result;

      setUp(() {
        result = map.validate({'k': 1});
      });

      test('Then the key error is at the map path', () {
        expect(
          result.issues.first,
          isIssue(
            code: IssueCode.invalidKey,
            path: [],
            message: 'value has an invalid key "k"',
          ),
        );
        expect(result.issues.first.params['key'], 'k');
      });

      test('Then the value error is at the key path', () {
        expect(
          result.issues.last,
          isIssue(code: IssueCode.invalidType, path: ['k']),
        );
      });

      test('Then the key issue holds the key validator issues', () {
        expect(result.issues.first.params['issues'], [
          isIssue(
            code: IssueCode.invalidType,
            message: 'key must be an integer',
          ),
        ]);
      });
    });

    test('When a custom check also fails then the entry errors are kept', () {
      final result = l
          .map(valueValidator: l.int())
          .custom((_) => false, message: 'C')
          .validate({'a': 'x'});

      expect(
        result,
        hasErrors({
          'a': ['value must be an integer'],
        }),
      );
    });

    test('When keys differ only by type then their paths stay distinct', () {
      final result = l.map(valueValidator: l.int()).validate({
        1: 'x',
        '1': 'y',
      });

      expect(result.issues.map((issue) => issue.path), [
        [1],
        ['1'],
      ]);
    });

    test('When the map is a schema field then errors nest under the field '
        'whatever the map type arguments', () {
      final schema = l.schema({'m': l.map(valueValidator: l.int())});

      final typed = schema.validate({
        'm': <String, Object?>{'a': 'x'},
      });
      final untyped = schema.validate({
        'm': <dynamic, dynamic>{'a': 'x'},
      });

      expect(
        typed,
        hasErrors({
          'm.a': ['m must be an integer'],
        }),
      );
      expect(untyped.errors, typed.errors);
    });

    test('When the entries are valid then the output is a typed map', () {
      expect(map.validate({1: 'one'}), isValidWith({1: 'one'}));
      expect(
        map.validate({1: 'one'}),
        isA<ValidationSuccess<Map<int, String>?>>(),
      );
    });
  });

  group('Given a map without a value validator', () {
    test('When an int value has the wrong type then the message reads '
        '"an int"', () {
      expect(
        l.map<String, int>().validate({'a': 'x'}).getError('a'),
        'value must be an int',
      );
    });

    test('When an Object value is null then the message reads "an Object"', () {
      expect(
        l.map<String, Object>().validate({'a': null}).getError('a'),
        'value must be an Object',
      );
    });

    test('When an enum value has the wrong type then the message uses the '
        'article of the enum name', () {
      expect(
        l.map<String, Answer>().validate({'a': 'x'}).getError('a'),
        'value must be an Answer',
      );
      expect(
        l.map<String, Element>().validate({'a': 'x'}).getError('a'),
        'value must be an Element',
      );
    });

    test('When a String value has the wrong type then the message reads '
        '"a String"', () {
      expect(
        l.map<String, String>().validate({'a': 1}).getError('a'),
        'value must be a String',
      );
    });

    test('When a type name starts with a "you" sound then the message reads '
        '"a"', () {
      expect(
        l.map<String, Uri>().validate({'a': 1}).getError('a'),
        'value must be a Uri',
      );
      expect(
        l.map<String, Uint8List>().validate({'a': 1}).getError('a'),
        'value must be a Uint8List',
      );
    });

    test('When a type name starts with an initialism then the message reads '
        'the first letter aloud', () {
      expect(
        l.map<String, HTTPStatus>().validate({'a': 1}).getError('a'),
        'value must be an HTTPStatus',
      );
      expect(
        l.map<String, UTFText>().validate({'a': 1}).getError('a'),
        'value must be a UTFText',
      );
    });
  });
}

enum Answer { yes }

enum Element { fire }

enum HTTPStatus { ok }

enum UTFText { eight }
