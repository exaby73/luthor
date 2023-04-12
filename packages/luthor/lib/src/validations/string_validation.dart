import 'package:band_core/src/validation.dart';

class StringValidation extends Validation {
  String? customMessage;

  StringValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String fieldName, dynamic value) {
    this.fieldName = fieldName;
    return value is String?;
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a string';
}
