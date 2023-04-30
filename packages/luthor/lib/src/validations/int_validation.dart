import 'package:luthor/src/validation.dart';

class IntValidation extends Validation {
  String? customMessage;

  IntValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value is int?;
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be an integer';

  @override
  Map<String, List<String>>? get errors => null;
}
