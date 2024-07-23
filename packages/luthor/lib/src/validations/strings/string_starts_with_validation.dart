import 'package:luthor/src/validation.dart';

class StringStartsWithValidation extends Validation {
  String string;
  String? customMessage;

  StringStartsWithValidation(
    this.string, {
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;
    return value.startsWith(string);
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} does not start with "$string"';

  @override
  Map<String, List<String>>? get errors => null;

  @override
  String toString() {
    return 'StringStartsWithValidation{message: $message, string: $string}';
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'string_starts_with',
      'message': message,
      'string': string,
    };
  }
}
