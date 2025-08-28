import 'package:luthor/src/validation.dart';

class NullValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;

  NullValidation({String? message, String? Function()? messageFn})
    : customMessage = message,
      customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value == null;
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must be null';

  @override
  Map<String, List<String>>? get errors => null;
}
