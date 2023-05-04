import 'package:luthor/src/validation.dart';

class StringMaxValidation extends Validation {
  int maxLength;
  String? customMessage;

  StringMaxValidation({
    required this.maxLength,
    String? message,
  })  : assert(maxLength >= 0, 'minLength must be greater than or equal to 0'),
        customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    this.fieldName = fieldName;
    if (value == null) return true;
    if (value is! String) return false;
    return value.length <= maxLength;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    return '${fieldName ?? 'value'} must not be more than '
        '$maxLength character${maxLength != 1 ? 's' : ''} long';
  }

  @override
  Map<String, List<String>>? get errors => null;
}
