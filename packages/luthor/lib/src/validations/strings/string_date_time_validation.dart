import 'package:luthor/src/validation.dart';

class StringDateTimeValidation extends Validation {
  String? customMessage;

  StringDateTimeValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String fieldName, dynamic value) {
    this.fieldName = fieldName;

    if (value == null) return true;

    final date = DateTime.tryParse(value as String);
    return date != null;
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a valid date';
}
