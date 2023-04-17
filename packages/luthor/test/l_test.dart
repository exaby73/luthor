import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return the custom message when provided', () {
    final result = l.string(message: 'custom message').validate(1);

    result.when(
      error: (message) {
        expect(message, 'custom message');
      },
      success: (_) => fail('should not be success'),
    );
  });

  group('validateWithFieldName', () {
    test('should have the fieldName in the error message', () {
      final result = l.required().string().validateWithFieldName('name', null);

      result.when(
        error: (message) {
          expect(message, 'name is required');
        },
        success: (_) => fail('should not be success'),
      );
    });
  });
}
