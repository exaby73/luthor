import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return the custom message when provided', () {
    final result = l.string(message: 'custom message').validateValue(1);

    result.when(
      error: (errors) {
        expect(errors, ['custom message']);
      },
      success: (_) => fail('should not be success'),
    );
  });

  group('validateWithFieldName', () {
    test('should have the fieldName in the error message', () {
      final result =
          l.required().string().validateValueWithFieldName('name', null);

      result.when(
        error: (errors) {
          expect(errors, ['name is required']);
        },
        success: (_) => fail('should not be success'),
      );
    });
  });
}
