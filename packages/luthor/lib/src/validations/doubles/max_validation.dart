import 'package:luthor/src/validation.dart';

class DoubleMaxValidation extends Validation {
  double maxValue;
  String? customMessage;

  DoubleMaxValidation({
    required this.maxValue,
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! double) return false;

    return value <= maxValue;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    return '${fieldName ?? 'value'} must be less than or equal to $maxValue';
  }

  @override
  Map<String, List<String>>? get errors => null;
}
