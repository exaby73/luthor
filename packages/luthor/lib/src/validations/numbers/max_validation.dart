import 'package:luthor/src/validation.dart';

class NumberMaxValidation extends Validation {
  num maxValue;
  String? customMessage;

  NumberMaxValidation({
    required this.maxValue,
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! num) return false;

    return value <= maxValue;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    return '${fieldName ?? 'value'} must be less than or equal to $maxValue';
  }

  @override
  Map<String, List<String>>? get errors => null;

  @override
  String toString() =>
      'NumberMaxValidation{message: $message, maxValue: $maxValue}';

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'number_max',
      'maxValue': maxValue,
      'message': message,
    };
  }
}
