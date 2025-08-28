import 'package:luthor/src/validation.dart';

class BoolValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;

  BoolValidation({String? message, String? Function()? messageFn})
    : customMessage = message,
      customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value is bool?;
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must be a bool';

  @override
  Map<String, List<String>>? get errors => null;
}
