import 'package:luthor/src/validation.dart';

class AnyValidation extends Validation {
  String? customMessage;

  AnyValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, dynamic value) {
    this.fieldName = fieldName;
    return true;
  }

  @override
  String get message =>
      throw StateError('AnyValidation does not have a message');
}
