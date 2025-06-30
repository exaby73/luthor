import 'package:luthor/src/validation.dart';

class NumberValidation extends Validation {
  String? customMessage;

  NumberValidation({String? message}) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value is num?;
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a number';

  @override
  Map<String, List<String>>? get errors => null;
}
