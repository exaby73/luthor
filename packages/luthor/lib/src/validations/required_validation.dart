import 'package:luthor/src/validation.dart';

class RequiredValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;

  RequiredValidation({String? message, String? Function()? messageFn})
    : customMessage = message,
      customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value != null;
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} is required';

  @override
  Map<String, List<String>>? get errors => null;
}
