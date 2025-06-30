import 'package:luthor/src/validation.dart';

class NullValidation extends Validation {
  String? customMessage;

  NullValidation({String? message}) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value == null;
  }

  @override
  String get message => customMessage ?? '${fieldName ?? 'value'} must be null';

  @override
  Map<String, List<String>>? get errors => null;
}
