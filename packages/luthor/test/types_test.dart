import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'utils/matchers.dart';

void main() {
  group('Given each type validator', () {
    test('When validating a value of its type then the value is the data', () {
      expect(l.string().validate('luthor'), isValidWith('luthor'));
      expect(l.int().validate(1), isValidWith(1));
      expect(l.double().validate(1.5), isValidWith(1.5));
      expect(l.num().validate(2), isValidWith(2));
      expect(l.bool().validate(false), isValidWith(false));
      expect(l.any().validate('anything'), isValidWith('anything'));
      expect(l.nullValue().validate(null), isValidWith(null));
      expect(l.list(l.any()).validate([1, 'a']), isValidWith([1, 'a']));
      expect(l.map().validate({'a': 1}), isValidWith({'a': 1}));
    });

    test('When validating null then the optional validator accepts it', () {
      expect(l.string().validate(null), isValidWith(null));
      expect(l.int().validate(null), isValidWith(null));
      expect(l.double().validate(null), isValidWith(null));
      expect(l.num().validate(null), isValidWith(null));
      expect(l.bool().validate(null), isValidWith(null));
      expect(l.any().validate(null), isValidWith(null));
      expect(l.file().validate(null), isValidWith(null));
      expect(l.list(l.any()).validate(null), isValidWith(null));
      expect(l.map().validate(null), isValidWith(null));
      expect(l.schema({}).validate(null), isValidWith(null));
    });

    test('When validating a value of another type then the default type '
        'message is returned', () {
      expect(l.string().validate(1), isInvalidWith(['value must be a string']));
      expect(
        l.int().validate('1'),
        isInvalidWith(['value must be an integer']),
      );
      expect(
        l.double().validate('1'),
        isInvalidWith(['value must be a double']),
      );
      expect(l.num().validate('1'), isInvalidWith(['value must be a number']));
      expect(
        l.bool().validate('true'),
        isInvalidWith(['value must be a bool']),
      );
      expect(l.nullValue().validate(1), isInvalidWith(['value must be null']));
      expect(
        l.list(l.any()).validate('a'),
        isInvalidWith(['value must be a list']),
      );
      expect(l.map().validate('a'), isInvalidWith(['value must be a map']));
      expect(l.file().validate('a'), isInvalidWith(['value must be a file']));
    });

    test('When the type check fails then it reports an invalidType issue', () {
      final result = l.string().validate(1);

      expect(result.issues, [
        isIssue(
          code: IssueCode.invalidType,
          path: [],
          params: {'expected': 'string'},
        ),
      ]);
    });
  });

  group('Given the exported validator types', () {
    test(
      'When annotating variables with them then the factory results fit',
      () {
        final IntValidator<int?> age = l.int();
        final DoubleValidator<double> price = l.double().required();
        final NumValidator<num?> score = l.num();
        final StringValidator name = l.string();
        final SchemaValidator user = l.schema({'age': age, 'name': name});
        final ListValidator<num?, List<num?>?> scores = l.list(score);

        expect(price.validate(1.5), isValidWith(1.5));
        expect(user.validate({'age': 1}).isValid, isTrue);
        expect(scores.validate([1, 2.5]).isValid, isTrue);
      },
    );
  });

  group('Given required validators', () {
    test('When validating null then the required message is returned', () {
      expect(
        l.string().required().validate(null),
        isInvalidWith(['value is required']),
      );
      expect(
        l.file().required().validate(null),
        isInvalidWith(['value is required']),
      );
      expect(
        l.any().required().validate(null),
        isInvalidWith(['value is required']),
      );
    });

    test('When the value is null then it reports a required issue', () {
      expect(l.int().required().validate(null).issues, [
        isIssue(code: IssueCode.required, path: []),
      ]);
    });

    test('When validating a present value then it passes', () {
      expect(l.string().required().validate('x'), isValidWith('x'));
    });
  });

  group('Given a type validator with modifiers', () {
    test('When the type check fails then the modifiers are skipped', () {
      expect(
        l.int().min(1).max(3).validate('5'),
        isInvalidWith(['value must be an integer']),
      );
      expect(
        l.string().email().min(3).validate(5),
        isInvalidWith(['value must be a string']),
      );
    });

    test('When several modifiers fail then each one is reported', () {
      expect(
        l.string().email().min(10).validate('nope'),
        isInvalidWith([
          'value must be a valid email address',
          'value must be at least 10 characters long',
        ]),
      );
    });
  });

  group('Given required validators with typed output', () {
    test('When the value is valid then the data has the non-null type', () {
      final result = l.string().required().validate(_untyped('luthor'));

      final String data = switch (result) {
        ValidationSuccess(:final data) => data,
        ValidationFailure() => '',
      };

      expect(data, 'luthor');
    });

    test('When the validator is optional then the data is nullable', () {
      final ValidationResult<int?> result = l.int().validate(null);

      expect(result, isValidWith(null));
    });
  });
}

Object? _untyped(Object? value) => value;
