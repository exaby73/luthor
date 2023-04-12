import 'package:band_core/src/validation.dart';

class StringMinValidation extends Validation {
  int minLength;
  String? customMessage;

  StringMinValidation({
    required this.minLength,
    String? message,
  })  : assert(minLength >= 0, 'minLength must be greater than or equal to 0'),
        customMessage = message;

  @override
  bool call(String fieldName, covariant String? value) {
    this.fieldName = fieldName;
    return value != null && value.length >= minLength;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    return '${fieldName ?? 'value'} must be at least '
        '$minLength character${minLength != 1 ? 's' : ''} long';
  }
}
