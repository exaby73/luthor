import 'package:luthor/src/validation.dart';

class AnyValidation extends Validation {
  String? customMessage;

  AnyValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return true;
  }

  @override
  String get message =>
      throw StateError('AnyValidation does not have a message');

  @override
  Map<String, List<String>>? get errors => null;
}
