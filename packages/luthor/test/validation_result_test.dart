import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  group('SchemaValidationError', () {
    final schema = l.schema({
      'value': l.int().required(),
      'nested': l.schema({'value': l.string().required()}).required(),
    });

    test('should return null if no errors', () {
      final result = schema.validateSchema({
        'value': 1,
        'nested': {'value': 'string'},
      });

      expect(result, isA<SchemaValidationSuccess>());
    });

    test('should return errors if any', () {
      final result = schema.validateSchema({
        'value': null,
        'nested': {'value': null},
      });

      expect(result, isA<SchemaValidationError>());
      expect((result as SchemaValidationError).errors, {
        'value': ['value is required'],
        'nested': {
          'value': ['value is required'],
        },
      });
    });

    test('getErrror should return null if no errors', () {
      final result = schema.validateSchema({
        'value': 1,
        'nested': {'value': null},
      });

      expect(result, isA<SchemaValidationError>());
      expect((result as SchemaValidationError).getError('value'), isNull);
    });

    test('getError should return the error message', () {
      final result = schema.validateSchema({
        'value': null,
        'nested': {'value': null},
      });

      expect(result, isA<SchemaValidationError>());
      expect(
        (result as SchemaValidationError).getError('value'),
        'value is required',
      );
    });

    test('getError should return the nested error message', () {
      final result = schema.validateSchema({
        'value': null,
        'nested': {'value': null},
      });

      expect(result, isA<SchemaValidationError>());
      expect(
        (result as SchemaValidationError).getError('nested.value'),
        'value is required',
      );
    });
  });
}
