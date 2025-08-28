import 'package:luthor/src/validation.dart';

class StringEndsWithValidation extends Validation {
  String string;
  String? customMessage;
  String? Function()? customMessageFn;

  StringEndsWithValidation(
    this.string, {
    String? message,
    String? Function()? messageFn,
  }) : customMessage = message,
       customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;
    return value.endsWith(string);
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} does not end with "$string"';

  @override
  Map<String, List<String>>? get errors => null;
}
