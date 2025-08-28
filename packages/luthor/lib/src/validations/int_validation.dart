import 'package:luthor/src/validation.dart';

class IntValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;

  IntValidation({String? message, String? Function()? messageFn})
    : customMessage = message,
      customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value is int?;
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must be an integer';

  @override
  Map<String, List<String>>? get errors => null;
}
