import 'package:luthor/src/validation.dart';

class IntMinValidation extends Validation {
  int minValue;
  String? customMessage;

  IntMinValidation({
    required this.minValue,
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! int) return false;

    return value >= minValue;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    return '${fieldName ?? 'value'} must be greater than or equal to $minValue';
  }

  @override
  Map<String, List<String>>? get errors => null;
}
