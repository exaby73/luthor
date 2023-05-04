import 'package:luthor/src/validation.dart';

class StringDateTimeValidation extends Validation {
  String? customMessage;

  StringDateTimeValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    this.fieldName = fieldName;

    if (value == null) return true;
    if (value is! String) return false;

    final date = DateTime.tryParse(value);
    return date != null;
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a valid date';

  @override
  Map<String, List<String>>? get errors => null;
}
