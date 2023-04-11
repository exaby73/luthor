import 'package:band_core/src/validation.dart';

class NullValidation extends Validation {
  String? customMessage;

  NullValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String fieldName, dynamic value) {
    this.fieldName = fieldName;
    return value == null;
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be null';
}
