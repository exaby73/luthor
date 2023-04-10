import 'package:band_core/src/b.dart';
import 'package:test/test.dart';

void main() {
  group('validateWithFieldName', () {
    test('should have the fieldName in the error message', () {
      final result = b.required().string().validateWithFieldName('name', null);
      expect(result.isValid, isFalse);
      expect(result.message, 'name is required');
    });
  });
}
