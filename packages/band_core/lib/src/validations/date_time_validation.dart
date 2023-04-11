import 'package:band_core/src/validation.dart';
import 'package:band_core/src/validations/string_validation.dart';

class DateTimeValidation extends Validation {
  String? customMessage;

  DateTimeValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String fieldName, dynamic value) {
    this.fieldName = fieldName;

    if (value is DateTime) return true;

    final isString = StringValidation(message: customMessage)(fieldName, value);
    if (!isString)  return false;

    final date = DateTime.tryParse(value as String);
    return date != null;
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a valid date';
}
