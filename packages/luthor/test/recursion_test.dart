import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'utils/matchers.dart';

void main() {
  tearDown(() {
    l.maxDepth = ValidatorFactory.defaultMaxDepth;
  });

  group('Given a schema whose field refers to itself', () {
    late SchemaValidator node;

    setUp(() {
      node = l.schema({
        'value': l.string().required(),
        'next': forwardRef(() => node),
      });
    });

    test('When a nested value has the wrong type then it is reported', () {
      expect(
        node.validate({
          'value': 'a',
          'next': {'value': 1},
        }),
        hasErrors({
          'next.value': ['value must be a string'],
        }),
      );
    });

    test('When a nested required value is missing then it is reported', () {
      expect(
        node.validate({'value': 'a', 'next': <String, Object?>{}}),
        hasErrors({
          'next.value': ['value is required'],
        }),
      );
    });
  });

  group('Given a schema that recurses through a list', () {
    late SchemaValidator tree;

    setUp(() {
      tree = l.schema({
        'value': l.string().required(),
        'children': l.list(forwardRef(() => tree.required())),
      });
    });

    test('When the root is invalid and a child is valid then the root error '
        'is kept', () {
      expect(
        tree.validate({
          'children': [
            {'value': 'ok'},
          ],
        }),
        hasErrors({
          'value': ['value is required'],
        }),
      );
    });

    test('When a child is invalid then the error is reported under the child '
        'only', () {
      expect(
        tree.validate({
          'value': 'r',
          'children': [
            {'value': 1},
          ],
        }),
        hasErrors({
          'children.0.value': ['value must be a string'],
        }),
      );
    });

    test('When the same schema validates twice then the results are '
        'independent', () {
      tree.validate({'value': 1});

      expect(tree.validate({'value': 'ok'}).isValid, isTrue);
    });
  });

  group('Given mutually recursive schemas', () {
    late SchemaValidator a;
    late SchemaValidator b;

    setUp(() {
      a = l.schema({'x': l.string(), 'b': forwardRef(() => b)});
      b = l.schema({'a': forwardRef(() => a)});
    });

    test('When a deep value is invalid then it is reported', () {
      expect(
        a.validate({
          'b': {
            'a': {
              'x': 'bad',
              'b': {
                'a': {'x': 5},
              },
            },
          },
        }),
        hasErrors({
          'b.a.b.a.x': ['x must be a string'],
        }),
      );
    });
  });

  group('Given deeply nested input for a recursive schema', () {
    late SchemaValidator tree;

    setUp(() {
      tree = l.schema({
        'value': l.string().required(),
        'children': l.list(forwardRef(() => tree.required())),
      });
    });

    test('When the input is deeper than the maximum depth then a tooDeep '
        'issue is returned instead of a stack overflow', () {
      final result = tree.validate(_nestedTree(100000));

      expect(result.isValid, isFalse);
      expect(result.issues.single.code, IssueCode.tooDeep);
    });

    test('When the input is deeper than the maximum depth then the guard '
        'fails closed even for valid data', () {
      l.maxDepth = 4;

      final result = tree.validate(_nestedTree(3));

      expect(result.issues, [
        isIssue(
          code: IssueCode.tooDeep,
          path: ['children', 0, 'children', 0, 'children'],
          params: {'maxDepth': 4},
        ),
      ]);
    });

    test('When the input is within the maximum depth then it is validated', () {
      l.maxDepth = 6;

      expect(tree.validate(_nestedTree(3)).isValid, isTrue);
    });

    test('When the default limit is reached by valid data then it validates '
        'without overflowing', () {
      expect(tree.validate(_nestedTree(255)).isValid, isTrue);
    });
  });

  group('Given a union that refers to itself', () {
    test('When validated then the depth guard stops the recursion', () {
      late UnionValidator<Object?> loop;
      loop = l.union([forwardRef(() => loop)]);

      expect(loop.validate(1).issues.single.params['issues'], isNotEmpty);
    });
  });
}

Map<String, Object?> _nestedTree(int depth) {
  Map<String, Object?> node = {'value': 'leaf'};
  for (var level = 0; level < depth; level++) {
    node = {
      'value': 'node',
      'children': [node],
    };
  }
  return node;
}
