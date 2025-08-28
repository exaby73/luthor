import 'package:luthor/src/validation.dart';

class StringValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;

  StringValidation({String? message, String? Function()? messageFn})
    : customMessage = message,
      customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value is String?;
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must be a string';

  @override
  Map<String, List<String>>? get errors => null;
}
