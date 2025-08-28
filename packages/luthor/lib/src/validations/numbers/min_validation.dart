import 'package:luthor/src/validation.dart';

class NumberMinValidation extends Validation {
  num minValue;
  String? customMessage;
  String? Function()? customMessageFn;

  NumberMinValidation({
    required this.minValue,
    String? message,
    String? Function()? messageFn,
  }) : customMessage = message,
       customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! num) return false;

    return value >= minValue;
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must be greater than or equal to $minValue';

  @override
  Map<String, List<String>>? get errors => null;
}
