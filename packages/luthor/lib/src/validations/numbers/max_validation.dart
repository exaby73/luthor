import 'package:luthor/src/validation.dart';

class NumberMaxValidation extends Validation {
  num maxValue;
  String? customMessage;
  String? Function()? customMessageFn;

  NumberMaxValidation({
    required this.maxValue,
    String? message,
    String? Function()? messageFn,
  }) : customMessage = message,
       customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! num) return false;

    return value <= maxValue;
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must be less than or equal to $maxValue';

  @override
  Map<String, List<String>>? get errors => null;
}
