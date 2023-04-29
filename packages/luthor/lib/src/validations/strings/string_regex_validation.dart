import 'package:luthor/src/validation.dart';

class StringRegexValidation extends Validation {
  RegExp regex;
  String? customMessage;

  StringRegexValidation({
    required this.regex,
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, dynamic value) {
    this.fieldName = fieldName;

    if (value == null) return true;
    return regex.hasMatch(value as String);
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must match regex';
}
