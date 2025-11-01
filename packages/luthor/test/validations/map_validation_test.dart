import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a map', () {
    final result = l.map().validateValue({});

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, {});
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is not a map', () {
    final result = l.map().validateValue('a');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a Map']);
    }
  });

  test('should return true when value is null', () {
    final result = l.map().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.required().map().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });

  test('should use custom message when message is provided', () {
    final result = l
        .map(message: 'Custom map error')
        .validateValue('not a map');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Custom map error']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l
        .map(messageFn: () => 'Dynamic map error')
        .validateValue('not a map');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic map error']);
    }
  });

  test(
    'should prioritize custom message over messageFn when both are provided',
    () {
      final result = l
          .map(message: 'Static message', messageFn: () => 'Dynamic message')
          .validateValue('not a map');

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['Static message']);
      }
    },
  );

  test('should handle null return from messageFn and fallback to default', () {
    final result = l.map(messageFn: () => null).validateValue('not a map');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a Map']);
    }
  });

  group('key and value validators', () {
    test('should validate map keys with keyValidator', () {
      final result = l.map(keyValidator: l.string().required()).validateValue({
        'key1': 123,
        'key2': 456,
      });

      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, {'key1': 123, 'key2': 456});
        case SingleValidationError(data: _, errors: _):
          fail('should not have errors for valid string keys');
      }
    });

    test('should fail validation when keys are invalid', () {
      final result = l.map(keyValidator: l.int().required()).validateValue({
        'key1': 123,
        'key2': 456,
      });

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should have errors for invalid int keys');
        case SingleValidationError(data: _, errors: final errors):
          // Errors are flattened to a list, should contain key validation errors
          expect(errors, isNotEmpty);
          // Check that errors mention keys
          final errorStr = errors.join(' ');
          expect(errorStr.contains('key') || errorStr.contains('int'), true);
      }
    });

    test('should validate map values with valueValidator', () {
      final result = l.map(valueValidator: l.int().required()).validateValue({
        'key1': 123,
        'key2': 456,
      });

      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, {'key1': 123, 'key2': 456});
        case SingleValidationError(data: _, errors: _):
          fail('should not have errors for valid int values');
      }
    });

    test('should fail validation when values are invalid', () {
      final result = l.map(valueValidator: l.int().required()).validateValue({
        'key1': 'invalid',
        'key2': 456,
      });

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should have errors for invalid int values');
        case SingleValidationError(data: _, errors: final errors):
          // Errors are flattened to a list, should contain value validation errors
          expect(errors, isNotEmpty);
          // Check that errors mention key1 or contain validation error
          final errorStr = errors.join(' ');
          expect(
            errorStr.contains('key1') || errorStr.contains('integer'),
            true,
          );
      }
    });

    test('should validate both keys and values', () {
      final result = l
          .map(
            keyValidator: l.string().required(),
            valueValidator: l.int().required(),
          )
          .validateValue({'key1': 123, 'key2': 456});

      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, {'key1': 123, 'key2': 456});
        case SingleValidationError(data: _, errors: _):
          fail('should not have errors for valid keys and values');
      }
    });

    test('should handle nullable value types', () {
      final result = l
          .map(keyValidator: l.string().required(), valueValidator: l.int())
          .validateValue({'key1': 123, 'key2': null});

      switch (result) {
        case SingleValidationSuccess(data: _):
          expect(result.data, {'key1': 123, 'key2': null});
        case SingleValidationError(data: _, errors: _):
          fail('should allow null values when validator is nullable');
      }
    });

    test('should fail when nullable value validator requires non-null', () {
      final result = l
          .map(
            keyValidator: l.string().required(),
            valueValidator: l.int().required(),
          )
          .validateValue({'key1': 123, 'key2': null});

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should have errors when required() is used');
        case SingleValidationError(data: _, errors: final errors):
          // Errors are flattened to a list, should contain value validation errors
          expect(errors, isNotEmpty);
          // Check that errors mention key2 or required
          final errorStr = errors.join(' ');
          expect(
            errorStr.contains('key2') || errorStr.contains('required'),
            true,
          );
      }
    });

    test('should handle collision when map has a key named "keys"', () {
      final result = l
          .map(
            keyValidator: l.string().required(),
            valueValidator: l.int().required(),
          )
          .validateValue({
            'keys':
                'invalid', // This should not collide with key validation errors
            'key1': 123,
          });

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should have errors for invalid string value at "keys" key');
        case SingleValidationError(data: _, errors: final errors):
          // Errors should be structured correctly without collision
          expect(errors, isNotEmpty);
          // The error for the 'keys' map key should appear in the flattened list
          final errorStr = errors.join(' ');
          // Should contain error about the 'keys' key's value being invalid
          expect(
            errorStr.contains('keys') || errorStr.contains('integer'),
            true,
          );
      }
    });

    test('should handle collision when map has a key named "values"', () {
      final result = l
          .map(
            keyValidator: l.string().required(),
            valueValidator: l.int().required(),
          )
          .validateValue({
            'values':
                'invalid', // This should not collide with nested value errors structure
            'key1': 123,
          });

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should have errors for invalid string value at "values" key');
        case SingleValidationError(data: _, errors: final errors):
          // Errors should be structured correctly without collision
          expect(errors, isNotEmpty);
          // The error for the 'values' map key should appear in the flattened list
          final errorStr = errors.join(' ');
          // Should contain error about the 'values' key's value being invalid
          expect(
            errorStr.contains('values') || errorStr.contains('integer'),
            true,
          );
      }
    });

    group('error structure verification', () {
      test(
        'should structure key validation errors as {"keys": {"key1": ["errors"]}}',
        () {
          final validator = l.schema({
            'mapField': l.map(keyValidator: l.int().required()),
          });

          final result = validator.validateSchema({
            'mapField': {'key1': 'value1', 'key2': 'value2'},
          });

          switch (result) {
            case SchemaValidationSuccess(data: _):
              fail('should have errors for invalid string keys');
            case SchemaValidationError(errors: final errors):
              expect(errors, isA<Map>());
              expect(errors.containsKey('mapField'), true);
              final mapFieldErrors = errors['mapField'] as Map;
              expect(mapFieldErrors.containsKey('keys'), true);
              final keysErrors = mapFieldErrors['keys'] as Map;
              expect(keysErrors, isA<Map>());
              expect(keysErrors.containsKey('key1'), true);
              expect(keysErrors.containsKey('key2'), true);
              expect(keysErrors['key1'], isA<List>());
              expect(keysErrors['key2'], isA<List>());
          }
        },
      );

      test(
        'should structure value validation errors as {"values": {"key1": ["errors"]}}',
        () {
          final validator = l.schema({
            'mapField': l.map(valueValidator: l.int().required()),
          });

          final result = validator.validateSchema({
            'mapField': {'key1': 'invalid', 'key2': 123},
          });

          switch (result) {
            case SchemaValidationSuccess(data: _):
              fail('should have errors for invalid string values');
            case SchemaValidationError(errors: final errors):
              expect(errors, isA<Map>());
              expect(errors.containsKey('mapField'), true);
              final mapFieldErrors = errors['mapField'] as Map;
              expect(mapFieldErrors.containsKey('values'), true);
              final valuesErrors = mapFieldErrors['values'] as Map;
              expect(valuesErrors, isA<Map>());
              expect(valuesErrors.containsKey('key1'), true);
              expect(valuesErrors['key1'], isA<List>());
              // key2 should not have errors since it's valid
              expect(valuesErrors.containsKey('key2'), false);
          }
        },
      );

      test('should structure both key and value errors correctly', () {
        final validator = l.schema({
          'mapField': l.map(
            keyValidator: l.int().required(),
            valueValidator: l.string().required(),
          ),
        });

        final result = validator.validateSchema({
          'mapField': {
            'key1': 123,
          }, // key 'key1' is invalid (should be int), value 123 is invalid (should be string)
        });

        switch (result) {
          case SchemaValidationSuccess(data: _):
            fail('should have errors for invalid keys and values');
          case SchemaValidationError(errors: final errors):
            expect(errors, isA<Map>());
            expect(errors.containsKey('mapField'), true);
            final mapFieldErrors = errors['mapField'] as Map;
            // Should have both 'keys' and 'values'
            expect(mapFieldErrors.containsKey('keys'), true);
            expect(mapFieldErrors.containsKey('values'), true);

            final keysErrors = mapFieldErrors['keys'] as Map;
            final valuesErrors = mapFieldErrors['values'] as Map;

            // Key validation error structure
            expect(keysErrors, isA<Map>());
            expect(keysErrors.containsKey('key1'), true);
            expect(keysErrors['key1'], isA<List>());

            // Value validation error structure
            expect(valuesErrors, isA<Map>());
            expect(valuesErrors.containsKey('key1'), true);
            expect(valuesErrors['key1'], isA<List>());
        }
      });

      test('should handle collision with "keys" and "values" map keys', () {
        final validator = l.schema({
          'mapField': l.map(
            keyValidator: l.string().required(),
            valueValidator: l.int().required(),
          ),
        });

        final result = validator.validateSchema({
          'mapField': {
            'keys': 'invalid', // Should appear in values.errors['keys']
            'values': 'invalid', // Should appear in values.errors['values']
            'validKey': 456,
          },
        });

        switch (result) {
          case SchemaValidationSuccess(data: _):
            fail('should have errors for invalid values');
          case SchemaValidationError(errors: final errors):
            expect(errors, isA<Map>());
            expect(errors.containsKey('mapField'), true);
            final mapFieldErrors = errors['mapField'] as Map;

            // Should have 'values' nested structure (not 'keys' since all keys are valid strings)
            expect(mapFieldErrors.containsKey('values'), true);
            final valuesErrors = mapFieldErrors['values'] as Map;

            // The 'keys' and 'values' map keys should appear in the nested structure
            expect(valuesErrors.containsKey('keys'), true);
            expect(valuesErrors.containsKey('values'), true);
            expect(valuesErrors['keys'], isA<List>());
            expect(valuesErrors['values'], isA<List>());

            // 'validKey' should not have errors
            expect(valuesErrors.containsKey('validKey'), false);
        }
      });
    });
  });
}
