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

  group('Given the ip modifier', () {
    test('When the address is surrounded by other text then it fails', () {
      final ip = l.string().ip();

      for (final value in [
        'abc 1.1.1.1 def',
        '1.1.1.1.1',
        '1.2.3.4/24',
        '-1.2.3.4',
        '2001:db8::1 junk',
        'gggg::1',
        '1:2:3:4:5:6:7:8:9',
        'fe80::1%eth0',
        '256.1.1.1',
        '1.2.3',
        '',
      ]) {
        expect(ip.validate(value).isValid, isFalse, reason: value);
      }
    });

    test('When v4 is required then extra octets and leading zeros fail', () {
      final ipv4 = l.string().ip(version: IpVersion.v4);

      for (final value in [
        '1.1.1.1.1',
        'x 1.2.3.4 y',
        '999.1.2.3.4',
        '01.2.3.4',
      ]) {
        expect(ipv4.validate(value).isValid, isFalse, reason: value);
      }
      expect(ipv4.validate('::1').isValid, isFalse);
    });

    test('When the address is a loopback or unspecified IPv6 address then it '
        'passes', () {
      for (final version in [null, IpVersion.v6]) {
        final ip = l.string().ip(version: version);

        for (final value in ['::1', '::', '1::', '2001:db8::1', 'fe80::1']) {
          expect(ip.validate(value).isValid, isTrue, reason: '$version $value');
        }
      }
    });

    test('When IPv6 embeds an IPv4 address then it passes', () {
      expect(l.string().ip().validate('::ffff:192.168.1.1').isValid, isTrue);
      expect(
        l
            .string()
            .ip(version: IpVersion.v6)
            .validate('1:2:3:4:5:6:7:8')
            .isValid,
        isTrue,
      );
    });
  });

  group('Given the cuid modifier', () {
    test('When the cuid is not at the start then it fails', () {
      final cuid = l.string().cuid();

      for (final value in [
        'hello cabcdefgh',
        'xyzcabcdefgh',
        '!!!!c12345678',
      ]) {
        expect(cuid.validate(value).isValid, isFalse, reason: value);
      }
    });

    test('When the cuid starts with c in either case then it passes', () {
      expect(
        l.string().cuid().validate('cjld2cjxh0000qzrmn831i7rn').isValid,
        isTrue,
      );
      expect(
        l.string().cuid().validate('Cjld2cjxh0000qzrmn831i7rn').isValid,
        isTrue,
      );
    });
  });

  group('Given the dateTime modifier', () {
    test('When the date or time is impossible then it fails', () {
      final dateTime = l.string().dateTime();

      for (final value in [
        '2023-02-30',
        '2023-13-01',
        '2023-00-10',
        '2023-02-29',
        '2023-01-01T25:00:00',
        '2023-01-01T10:60:00',
        '2023-01-01T10:00:60',
        '2023-01-01T10:00:00+25:00',
      ]) {
        expect(dateTime.validate(value).isValid, isFalse, reason: value);
      }
    });

    test(
      'When the string is not in ISO 8601 extended format then it fails',
      () {
        final dateTime = l.string().dateTime();

        for (final value in [
          '20230101',
          '2023',
          '1',
          '+002023-01-01',
          '2023-1-1',
          '2023-01-01T10',
          ' 2023-01-01',
          'abc',
        ]) {
          expect(dateTime.validate(value).isValid, isFalse, reason: value);
        }
      },
    );

    test('When the string is a valid ISO 8601 date or date-time then it '
        'passes', () {
      final dateTime = l.string().dateTime();

      for (final value in [
        '2023-01-01',
        '2024-02-29',
        '2023-01-01 10:00',
        '2023-01-01T10:00:00Z',
        '2023-01-01T10:00:00.123456+05:30',
        '2023-01-01T23:59:59-0800',
        '2023-01-01T00:00:00.000',
      ]) {
        expect(dateTime.validate(value).isValid, isTrue, reason: value);
      }
    });
  });

  group('Given the uri modifier', () {
    test('When the string has no scheme then it fails', () {
      final uri = l.string().uri();

      for (final value in [
        'not a uri',
        '',
        'hello world',
        '%zz',
        '::::',
        '/path',
      ]) {
        expect(uri.validate(value).isValid, isFalse, reason: value);
      }
    });

    test('When the string has a scheme then it passes', () {
      final uri = l.string().uri();

      for (final value in [
        'mailto:a@b.com',
        'urn:isbn:0451450523',
        'https://x.dev',
      ]) {
        expect(uri.validate(value).isValid, isTrue, reason: value);
      }
    });

    test('When allowed schemes differ in case then they still match', () {
      final uri = l.string().uri(allowedSchemes: ['HTTP']);

      expect(uri.validate('HTTP://x.com').isValid, isTrue);
      expect(uri.validate('http://x.com').isValid, isTrue);
      expect(uri.validate('ftp://x.com').isValid, isFalse);
    });
  });

  group('Given the emoji modifier', () {
    test('When the string is made of emoji then it passes', () {
      final emoji = l.string().emoji();

      for (final value in [
        '😀',
        '❤️',
        '1️⃣',
        '👍🏽',
        '👨‍👩‍👧',
        '🇺🇸',
        '🔥🔥',
        '🏴󠁧󠁢󠁳󠁣󠁴󠁿',
      ]) {
        expect(emoji.validate(value).isValid, isTrue, reason: value);
      }
    });

    test('When the string has punctuation, symbols or text then it fails', () {
      final emoji = l.string().emoji();

      for (final value in [
        '—',
        '…',
        '€',
        '→',
        '。',
        '∑',
        '★',
        'a',
        '1',
        '#',
        '',
        '😀a',
      ]) {
        expect(emoji.validate(value).isValid, isFalse, reason: value);
      }
    });
  });
}
