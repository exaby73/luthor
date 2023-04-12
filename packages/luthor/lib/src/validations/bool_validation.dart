import 'package:luthor/src/validation.dart';

class BoolValidation extends Validation {
  String? customMessage;

  BoolValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, dynamic value) {
    this.fieldName = fieldName;
    return value is bool?;
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a bool';
}
