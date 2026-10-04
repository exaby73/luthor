import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'utils/matchers.dart';

void main() {
  tearDown(() {
    l.messageBuilder = null;
  });

  group('Given a per-validation message', () {
    test('When the validation fails then the message replaces the default', () {
      expect(
        l.string().email(message: 'bad email').validate('nope'),
        isInvalidWith(['bad email']),
      );
    });

    test('When a message builder is also set then the message wins', () {
      expect(
        l
            .string()
            .email(message: 'bad email', messageBuilder: (_) => 'ignored')
            .validate('nope'),
        isInvalidWith(['bad email']),
      );
    });

    test('When set on the type then it replaces the type message', () {
      expect(
        l.int(message: 'whole numbers only').validate('x'),
        isInvalidWith(['whole numbers only']),
      );
      expect(
        l.string().required(message: 'needed').validate(null),
        isInvalidWith(['needed']),
      );
    });
  });

  group('Given a per-validation message builder', () {
    late ValidationIssue received;
    late ValidationResult<String?> result;

    setUp(() {
      result = l
          .string()
          .withName('password')
          .min(
            8,
            messageBuilder: (issue) {
              received = issue;
              return 'need ${issue.params['min']} for ${issue.fieldName}';
            },
          )
          .validate('short');
    });

    test('Then the builder output is the message', () {
      expect(result, isInvalidWith(['need 8 for password']));
    });

    test('Then the builder receives the issue with the default message', () {
      expect(
        received,
        isIssue(
          code: IssueCode.tooShort,
          path: [],
          message: 'password must be at least 8 characters long',
          params: {'min': 8},
          fieldName: 'password',
        ),
      );
    });

    test('Then the built message is stored on the issue', () {
      expect(result.issues.single.code, IssueCode.tooShort);
      expect(result.issues.single.message, 'need 8 for password');
    });
  });

  group('Given a global message builder', () {
    setUp(() {
      l.messageBuilder = (issue) => switch (issue.code) {
        IssueCode.required => '${issue.fieldName ?? 'Wert'} fehlt',
        _ => issue.message,
      };
    });

    test('When an issue has a translated code then it is translated', () {
      expect(
        l.string().required().validate(null),
        isInvalidWith(['Wert fehlt']),
      );
    });

    test('When the builder falls back then the default message is kept', () {
      expect(l.string().validate(1), isInvalidWith(['value must be a string']));
    });

    test('When a per-validation message is set then it wins', () {
      expect(
        l.string().required(message: 'local').validate(null),
        isInvalidWith(['local']),
      );
    });

    test('When a per-validation builder is set then it wins', () {
      expect(
        l.string().required(messageBuilder: (_) => 'local').validate(null),
        isInvalidWith(['local']),
      );
    });
  });

  group('Given the ip modifier', () {
    test('When a message builder is set then it is used', () {
      expect(
        l.string().ip(messageBuilder: (_) => 'custom ip').validate('nope'),
        isInvalidWith(['custom ip']),
      );
    });

    test('When a version is set then the default message names it', () {
      expect(
        l.string().ip(version: IpVersion.v4).validate('nope'),
        isInvalidWith(['value must be a valid IPv4 address']),
      );
    });
  });
}
