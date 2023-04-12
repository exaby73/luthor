import 'package:band_core/src/validation.dart';

class RequiredValidation extends Validation {
  String? customMessage;

  RequiredValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String fieldName, dynamic value) {
    this.fieldName = fieldName;
    return value != null && value != '';
  }

  @override
  String get message => customMessage ?? '${fieldName ?? 'value'} is required';
}
