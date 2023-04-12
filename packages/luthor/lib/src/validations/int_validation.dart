import 'package:luthor/src/validation.dart';

class IntValidation extends Validation {
  String? customMessage;

  IntValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, dynamic value) {
    this.fieldName = fieldName;
    return value is int?;
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be an integer';
}
