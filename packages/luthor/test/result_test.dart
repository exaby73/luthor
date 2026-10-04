import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  group('Given a successful result', () {
    late ValidationResult<String> result;

    setUp(() {
      result = const ValidationSuccess('luthor');
    });

    test('Then it is valid', () {
      expect(result.isValid, isTrue);
    });

    test('Then it has no issues, messages or errors', () {
      expect(result.issues, isEmpty);
      expect(result.messages, isEmpty);
      expect(result.errors, isEmpty);
    });

    test('Then getError returns null for any path', () {
      expect(result.getError('email'), isNull);
    });

    test('Then its data is typed', () {
      final data = switch (result) {
        ValidationSuccess(:final data) => data,
        ValidationFailure() => '',
      };

      expect(data.length, 6);
    });
  });

  group('Given a failed result with nested, indexed and root issues', () {
    late ValidationResult<Map<String, Object?>> result;

    setUp(() {
      result = ValidationFailure(
        input: {'email': 'bad'},
        issues: const [
          ValidationIssue(code: IssueCode.custom, message: 'form is invalid'),
          ValidationIssue(
            code: IssueCode.invalidEmail,
            path: ['email'],
            message: 'email must be a valid email address',
          ),
          ValidationIssue(
            code: IssueCode.tooShort,
            path: ['email'],
            message: 'email must be at least 5 characters long',
            params: {'min': 5},
          ),
          ValidationIssue(
            code: IssueCode.required,
            path: ['items', 1, 'id'],
            message: 'id is required',
          ),
        ],
      );
    });

    test('Then it is not valid', () {
      expect(result.isValid, isFalse);
    });

    test('Then messages lists every message in issue order', () {
      expect(result.messages, [
        'form is invalid',
        'email must be a valid email address',
        'email must be at least 5 characters long',
        'id is required',
      ]);
    });

    test('Then the error map is keyed by error path', () {
      expect(result.errors, {
        '': ['form is invalid'],
        'email': [
          'email must be a valid email address',
          'email must be at least 5 characters long',
        ],
        'items.1.id': ['id is required'],
      });
    });

    test('Then getError returns the first message at a path', () {
      expect(result.getError('email'), 'email must be a valid email address');
      expect(result.getError('items.1.id'), 'id is required');
    });

    test('Then getError with an empty path returns object-level errors', () {
      expect(result.getError(''), 'form is invalid');
    });

    test('Then getErrors returns every message at a path', () {
      expect(result.getErrors('email'), hasLength(2));
    });

    test('Then getError returns null past a leaf, on a parent, or when '
        'missing', () {
      expect(result.getError('email.foo'), isNull);
      expect(result.getError('items'), isNull);
      expect(result.getError('missing.deep'), isNull);
    });

    test('Then the failure keeps the raw input', () {
      expect((result as ValidationFailure).input, {'email': 'bad'});
    });
  });

  group('Given an issue', () {
    const issue = ValidationIssue(
      code: IssueCode.tooSmall,
      path: ['items', 0, 'qty'],
      message: 'qty must be greater than or equal to 1',
      params: {'min': 1},
      fieldName: 'qty',
    );

    test('Then its error path joins segments with dots', () {
      expect(issue.errorPath, 'items.0.qty');
    });

    test('Then withMessage returns a copy with only the message changed', () {
      final copy = issue.withMessage('too few');

      expect(copy.message, 'too few');
      expect(copy.code, IssueCode.tooSmall);
      expect(copy.params, {'min': 1});
      expect(issue.message, 'qty must be greater than or equal to 1');
    });
  });

  test('When creating a failure without issues then it throws', () {
    expect(
      () => ValidationFailure<Object?>(input: null, issues: const []),
      throwsArgumentError,
    );
  });
}
