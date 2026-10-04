import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'utils/matchers.dart';

void main() {
  group('Given strict Dart number types', () {
    test('When an int validator gets a double then it fails', () {
      expect(
        l.int().validate(1.5),
        isInvalidWith(['value must be an integer']),
      );
    });

    test('When a double validator gets an int then it fails', () {
      expect(l.double().validate(1), isInvalidWith(['value must be a double']));
    }, testOn: 'vm');

    test('When a num validator gets an int or a double then it passes', () {
      expect(l.num().validate(1), isValidWith(1));
      expect(l.num().validate(1.5), isValidWith(1.5));
    });
  });

  group('Given non-finite doubles', () {
    test(
      'When validated by double and num then they pass, like Dart types',
      () {
        expect(l.double().validate(double.infinity).isValid, isTrue);
        expect(l.num().validate(double.nan).isValid, isTrue);
      },
    );

    test('When finite() is present then NaN and infinity fail', () {
      expect(
        l.double().finite().validate(double.nan),
        isInvalidWith(['value must be a finite number']),
      );
      expect(l.num().finite().validate(double.negativeInfinity).issues, [
        isIssue(code: IssueCode.notFinite),
      ]);
      expect(l.num().finite().validate(1), isValidWith(1));
    });
  });

  group('Given number bounds', () {
    test('When a value is below min then a tooSmall issue is reported', () {
      final result = l.int().min(18).validate(17);

      expect(result.issues, [
        isIssue(
          code: IssueCode.tooSmall,
          message: 'value must be greater than or equal to 18',
          params: {'min': 18},
        ),
      ]);
    });

    test('When a value is above max then a tooBig issue is reported', () {
      final result = l.double().max(1.5).validate(2.0);

      expect(result.issues, [
        isIssue(
          code: IssueCode.tooBig,
          message: 'value must be less than or equal to 1.5',
          params: {'max': 1.5},
        ),
      ]);
    });

    test('When a value is within bounds then it passes', () {
      expect(l.num().min(1).max(3).validate(2.5), isValidWith(2.5));
      expect(l.int().min(1).max(1).validate(1), isValidWith(1));
    });

    test(
      'When a double bound is an int literal then it compiles and applies',
      () {
        expect(l.double().min(1).validate(0.5).isValid, isFalse);
      },
    );
  });
}
