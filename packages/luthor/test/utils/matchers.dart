import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

Matcher isSingleError<T>(List<String> errors) {
  return isA<SingleValidationError<T>>()
      .having((result) => result.isValid, 'isValid', isFalse)
      .having((result) => result.errors, 'errors', errors);
}

Matcher isSchemaError<T>(Map<String, dynamic> errors) {
  return isA<SchemaValidationError<T>>()
      .having((result) => result.isValid, 'isValid', isFalse)
      .having((result) => result.errors, 'errors', errors);
}
