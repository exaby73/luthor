import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  group('Given single validation results', () {
    test(
      'When result is success then status and string output describe success',
      () {
        final result = SingleValidationSuccess(data: 'value');

        expect(result.isValid, isTrue);
        expect(result.toString(), 'SingleValidationSuccess(data: value)');
      },
    );

    test(
      'When result is error then status and string output describe failure',
      () {
        final result = SingleValidationError(data: 'value', errors: ['bad']);

        expect(result.isValid, isFalse);
        expect(
          result.toString(),
          'SingleValidationError(data: value, errors: [bad])',
        );
      },
    );
  });

  group('Given schema validation results', () {
    test(
      'When result is success then status and string output describe success',
      () {
        final result = SchemaValidationSuccess(data: {'ok': true});

        expect(result.isValid, isTrue);
        expect(result.toString(), 'SchemaValidationSuccess(data: {ok: true})');
      },
    );

    test(
      'When result is error then status and string output describe failure',
      () {
        final result = SchemaValidationError(
          data: {'ok': false},
          errors: {
            'field': ['bad'],
          },
        );

        expect(result.isValid, isFalse);
        expect(
          result.toString(),
          'SchemaValidationError(data: {ok: false}, errors: {field: [bad]})',
        );
      },
    );

    test('When requesting missing error key then null is returned', () {
      final result = SchemaValidationError(errors: <String, dynamic>{});

      expect(result.getError('missing'), isNull);
    });

    test('When requesting a non-list error key then StateError is thrown', () {
      final result = SchemaValidationError(errors: {'field': 'bad'});

      expect(() => result.getError('field'), throwsStateError);
    });
  });
}
