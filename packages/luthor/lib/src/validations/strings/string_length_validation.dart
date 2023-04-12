import 'package:luthor/src/validation.dart';

class StringLengthValidation extends Validation {
  int length;
  String? customMessage;

  StringLengthValidation({
    required this.length,
    String? message,
  })  : assert(length >= 0, 'minLength must be greater than or equal to 0'),
        customMessage = message;

  @override
  bool call(String? fieldName, covariant String? value) {
    this.fieldName = fieldName;
    return value != null && value.length == length;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    return '${fieldName ?? 'value'} must be exactly '
        '$length character${length != 1 ? 's' : ''} long';
  }
}
