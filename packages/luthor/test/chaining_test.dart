import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'utils/matchers.dart';

void main() {
  group('Given a reusable string validator', () {
    late StringValidator<String?> base;

    setUp(() {
      base = l.string();
    });

    test('When adding modifiers then the original validator is unchanged', () {
      final email = base.email();
      final uuid = base.uuid();

      expect(base.validate('not-an-email').isValid, isTrue);
      expect(email.validate('not-an-email').isValid, isFalse);
      expect(uuid.validate('not-a-uuid').isValid, isFalse);
    });

    test('When marking it required then the original stays optional', () {
      base.required();

      expect(base.validate(null).isValid, isTrue);
    });

    group('When naming it with withName', () {
      late StringValidator<String?> named;

      setUp(() {
        named = base.withName('email');
      });

      test('Then a new validator is returned', () {
        expect(identical(named, base), isFalse);
      });

      test('Then the original keeps no name', () {
        expect(base.name, isNull);
      });

      test('Then the new validator uses the name in messages', () {
        expect(named.validate(1), isInvalidWith(['email must be a string']));
      });
    });
  });

  test('When renaming a named validator then the earlier handle keeps its '
      'name', () {
    final a = l.int().withName('a');

    a.withName('b');

    expect(a.validate('x'), isInvalidWith(['a must be an integer']));
  });

  group('Given modifiers chained in any order', () {
    test('When required comes first then type modifiers still chain', () {
      final validator = l.string().required().min(3);

      expect(
        validator.validate('ab'),
        isInvalidWith(['value must be at least 3 characters long']),
      );
      expect(validator.validate(null), isInvalidWith(['value is required']));
    });

    test('When base modifiers come first then type modifiers still chain', () {
      expect(l.int().required().max(3).validate(4).isValid, isFalse);
      expect(
        l.string().withName('mail').email().validate('x'),
        isInvalidWith(['mail must be a valid email address']),
      );
      expect(
        l.string().custom((value) => value.isNotEmpty).min(2).validate('a'),
        isInvalidWith(['value must be at least 2 characters long']),
      );
    });

    test('When required is placed anywhere then the result is the same', () {
      final early = l.string().required().email().withName('e');
      final late = l.string().email().withName('e').required();

      expect(early.validate(null).messages, late.validate(null).messages);
      expect(early.validate('x').messages, late.validate('x').messages);
    });
  });

  group('Given custom validators', () {
    test('When the function returns false then a custom issue is reported', () {
      final result = l.string().custom((value) => value == 'ok').validate('no');

      expect(result.issues, [
        isIssue(
          code: IssueCode.custom,
          message: 'value does not pass custom validation',
        ),
      ]);
    });

    test(
      'When the function throws then the value fails without rethrowing',
      () {
        expect(
          l.any().custom((value) => throw StateError('boom')).validate('x'),
          isInvalidWith(['value does not pass custom validation']),
        );
      },
    );

    test('When the value is null and optional then the function is not '
        'called', () {
      var called = false;

      final result = l
          .string()
          .custom((value) {
            called = true;
            return false;
          })
          .validate(null);

      expect(result.isValid, isTrue);
      expect(called, isFalse);
    });

    test('When the function receives the value then it is typed', () {
      expect(
        l.int().custom((value) => value.isEven).validate(3).isValid,
        isFalse,
      );
    });
  });

  group('Given negative length bounds', () {
    test(
      'When building min, max or length then an ArgumentError is thrown',
      () {
        expect(() => l.string().min(-1), throwsArgumentError);
        expect(() => l.string().max(-1), throwsArgumentError);
        expect(() => l.string().length(-1), throwsArgumentError);
      },
    );
  });
}
