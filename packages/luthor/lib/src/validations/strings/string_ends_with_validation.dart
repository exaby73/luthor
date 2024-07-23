import 'package:luthor/src/validation.dart';

class StringEndsWithValidation extends Validation {
  String string;
  String? customMessage;

  StringEndsWithValidation(
    this.string, {
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;
    return value.endsWith(string);
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} does not end with "$string"';

  @override
  Map<String, List<String>>? get errors => null;

  @override
  String toString() {
    return 'StringEndsWithValidation{message: $message, string: $string}';
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'string_ends_with',
      'message': message,
      'string': string,
    };
  }
}
