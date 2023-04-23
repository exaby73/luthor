import 'package:luthor/src/validation.dart';

class StringCuidValidation extends Validation {
  String? customMessage;

  StringCuidValidation({
    String? message,
  }) : customMessage = message;

  static const String _regex = r'''c[^\s-]{8,}$''';

  @override
  bool call(String? fieldName, dynamic value) {
    this.fieldName = fieldName;

    if (value == null) return true;
    return RegExp(_regex, caseSensitive: false).hasMatch(value as String);
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a valid cuid';
}
