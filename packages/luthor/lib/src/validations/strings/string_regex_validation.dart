import 'package:luthor/src/validation.dart';

class StringRegexValidation extends Validation {
  final String pattern;
  String? customMessage;
  String? Function()? customMessageFn;

  StringRegexValidation(
    this.pattern, {
    String? message,
    String? Function()? messageFn,
  }) : customMessage = message,
       customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;
    return RegExp(pattern).hasMatch(value);
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must match regex';

  @override
  Map<String, List<String>>? get errors => null;
}
