import 'package:luthor/src/validation.dart';

class NumberValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;

  NumberValidation({String? message, String? Function()? messageFn})
    : customMessage = message,
      customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value is num?;
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must be a number';

  @override
  Map<String, List<String>>? get errors => null;
}
