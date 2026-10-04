import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'utils/matchers.dart';

void main() {
  group('Given string modifiers', () {
    test('When validating representative valid values then they pass', () {
      expect(l.string().contains('ut').validate('luthor').isValid, isTrue);
      expect(
        l.string().cuid().validate('ckckf3qew000001l3f8gh4r6r').isValid,
        isTrue,
      );
      expect(
        l.string().cuid2().validate('tz4a98xxat96iws9zmbrgj3a').isValid,
        isTrue,
      );
      expect(
        l.string().dateTime().validate('2026-06-17T12:00:00Z').isValid,
        isTrue,
      );
      expect(l.string().email().validate('dev@example.com').isValid, isTrue);
      expect(l.string().emoji().validate('🔥').isValid, isTrue);
      expect(l.string().endsWith('or').validate('luthor').isValid, isTrue);
      expect(
        l.string().ip(version: IpVersion.v4).validate('127.0.0.1').isValid,
        isTrue,
      );
      expect(l.string().length(6).validate('luthor').isValid, isTrue);
      expect(l.string().max(6).validate('luthor').isValid, isTrue);
      expect(l.string().min(6).validate('luthor').isValid, isTrue);
      expect(
        l.string().regex(RegExp('^luth')).validate('luthor').isValid,
        isTrue,
      );
      expect(l.string().startsWith('lut').validate('luthor').isValid, isTrue);
      expect(
        l
            .string()
            .uri(allowedSchemes: ['mailto'])
            .validate('mailto:dev@example.com')
            .isValid,
        isTrue,
      );
      expect(
        l
            .string()
            .url(allowedSchemes: ['https'])
            .validate('https://example.com')
            .isValid,
        isTrue,
      );
      expect(
        l
            .string()
            .uuid()
            .validate('550e8400-e29b-41d4-a716-446655440000')
            .isValid,
        isTrue,
      );
    });

    test('When validating invalid values then each reports its code and '
        'default message', () {
      expect(l.string().contains('x').validate('abc').issues, [
        isIssue(
          code: IssueCode.missingSubstring,
          message: 'value does not contain "x"',
          params: {'substring': 'x'},
        ),
      ]);
      expect(l.string().startsWith('x').validate('abc').issues, [
        isIssue(
          code: IssueCode.missingPrefix,
          message: 'value does not start with "x"',
          params: {'prefix': 'x'},
        ),
      ]);
      expect(l.string().endsWith('x').validate('abc').issues, [
        isIssue(
          code: IssueCode.missingSuffix,
          message: 'value does not end with "x"',
          params: {'suffix': 'x'},
        ),
      ]);
      expect(l.string().length(1).validate('abc').issues, [
        isIssue(
          code: IssueCode.invalidLength,
          message: 'value must be exactly 1 character long',
          params: {'length': 1},
        ),
      ]);
      expect(l.string().max(2).validate('abc').issues, [
        isIssue(
          code: IssueCode.tooLong,
          message: 'value must not be more than 2 characters long',
          params: {'max': 2},
        ),
      ]);
      expect(l.string().min(4).validate('abc').issues, [
        isIssue(
          code: IssueCode.tooShort,
          message: 'value must be at least 4 characters long',
          params: {'min': 4},
        ),
      ]);
      expect(l.string().email().validate('abc').issues, [
        isIssue(
          code: IssueCode.invalidEmail,
          message: 'value must be a valid email address',
        ),
      ]);
      expect(l.string().uuid().validate('abc').issues, [
        isIssue(
          code: IssueCode.invalidUuid,
          message: 'value must be a valid uuid',
        ),
      ]);
      expect(l.string().cuid().validate('abc').issues, [
        isIssue(
          code: IssueCode.invalidCuid,
          message: 'value must be a valid cuid',
        ),
      ]);
      expect(l.string().cuid2().validate('ABC').issues, [
        isIssue(
          code: IssueCode.invalidCuid2,
          message: 'value must be a valid cuid2',
        ),
      ]);
      expect(l.string().emoji().validate('abc').issues, [
        isIssue(
          code: IssueCode.invalidEmoji,
          message: 'value must be a valid emoji',
        ),
      ]);
      expect(l.string().dateTime().validate('abc').issues, [
        isIssue(
          code: IssueCode.invalidDateTime,
          message: 'value must be a valid date',
        ),
      ]);
      expect(l.string().ip().validate('abc').issues, [
        isIssue(
          code: IssueCode.invalidIp,
          message: 'value must be a valid IP address',
          params: {'version': null},
        ),
      ]);
    });

    test('When a scheme list is set then the message names the schemes', () {
      expect(
        l.string().url(allowedSchemes: ['https']).validate('http://x.com'),
        isInvalidWith(['value must be a valid URL. Allowed scheme is https']),
      );
      expect(
        l.string().uri(allowedSchemes: ['a', 'b']).validate('c:x'),
        isInvalidWith(['value must be a valid uri. Allowed schemes are a, b']),
      );
    });
  });

  group('Given a regex modifier', () {
    test('When the pattern has flags then they apply', () {
      final validator = l.string().regex(RegExp('^abc', caseSensitive: false));

      expect(validator.validate('ABCdef').isValid, isTrue);
    });

    test('When the value does not match then the pattern is in the params', () {
      expect(l.string().regex(RegExp(r'^\d+$')).validate('x').issues, [
        isIssue(
          code: IssueCode.invalidPattern,
          message: 'value must match the pattern ^\\d+\$',
          params: {'pattern': r'^\d+$'},
        ),
      ]);
    });

    test('When the pattern is unanchored then a partial match passes', () {
      expect(
        l.string().regex(RegExp('[a-z]+')).validate('123abc').isValid,
        isTrue,
      );
    });
  });
}
