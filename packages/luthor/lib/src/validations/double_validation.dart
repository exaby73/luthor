import 'package:luthor/src/validation.dart';

class DoubleValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;

  DoubleValidation({String? message, String? Function()? messageFn})
    : customMessage = message,
      customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value is double?;
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must be a double';

  @override
  Map<String, List<String>>? get errors => null;
}
