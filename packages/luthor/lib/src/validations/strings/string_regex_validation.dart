import 'package:luthor/src/validation.dart';

class StringRegexValidation extends Validation {
  final String pattern;
  String? customMessage;

  StringRegexValidation(
    this.pattern, {
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, dynamic value) {
    this.fieldName = fieldName;

    if (value == null) return true;
    return RegExp(pattern).allMatches(value as String).isNotEmpty;
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must match regex';
}
