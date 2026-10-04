import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  group('Given the numeric annotations', () {
    test('When declared with an int or a double then they hold a num', () {
      const lengthOrInt = HasMin(3);
      const decimal = HasMax(1.5);

      expect(lengthOrInt.min, 3);
      expect(decimal.max, 1.5);
    });
  });

  group('Given an annotation with a message builder', () {
    test(
      'When declared with a top-level function then it builds the message',
      () {
        const annotation = IsEmail(messageBuilder: _emailMessage);

        expect(
          annotation.messageBuilder!(
            const ValidationIssue(
              code: IssueCode.invalidEmail,
              message: 'value must be a valid email address',
              fieldName: 'email',
            ),
          ),
          'email: bad address',
        );
      },
    );
  });

  group('Given custom validator annotations', () {
    test(
      'When declared with typed top-level functions then they are const',
      () {
        const custom = WithCustomValidator(_isEven);
        const schemaCustom = WithSchemaCustomValidator(_matchesPassword);

        expect(custom.customValidator, same(_isEven));
        expect(schemaCustom.customValidator, same(_matchesPassword));
      },
    );

    test('When their functions are passed to the matching modifiers then '
        'they validate, as generated code does', () {
      final schema = l.schema({
        'count': l.int().custom(_isEven, messageBuilder: _emailMessage),
        'password': l.string(),
        'confirm': l.string().customWithSchema(_matchesPassword),
      });

      expect(
        schema.validate({'count': 3, 'password': 'a', 'confirm': 'b'}).errors,
        {
          'count': ['count: bad address'],
          'confirm': ['confirm does not pass schema custom validation'],
        },
      );
    });
  });

  group('Given the remaining annotations', () {
    test('When declared then they expose the values the generator reads', () {
      const regex = MatchRegex(r'^\d+$', caseSensitive: false);
      const ip = IsIp(version: IpVersion.v6);
      const file = IsFile(accept: _isUpload);

      expect(regex.pattern, r'^\d+$');
      expect(regex.caseSensitive, isFalse);
      expect(regex.multiLine, isFalse);
      expect(ip.version, IpVersion.v6);
      expect(isIp.version, isNull);
      expect(file.accept, same(_isUpload));
    });
  });
}

String _emailMessage(ValidationIssue issue) =>
    '${issue.fieldName}: bad address';

bool _isEven(int value) => value.isEven;

bool _matchesPassword(String value, Map<String, Object?> data) {
  return value == data['password'];
}

bool _isUpload(Object value) => value is List<int>;
