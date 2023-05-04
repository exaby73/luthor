import 'package:luthor/src/validation.dart';

class StringRegexValidation extends Validation {
  final String pattern;
  String? customMessage;

  StringRegexValidation(
    this.pattern, {
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;
    return RegExp(pattern).hasMatch(value);
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must match regex';

  @override
  Map<String, List<String>>? get errors => null;
}
