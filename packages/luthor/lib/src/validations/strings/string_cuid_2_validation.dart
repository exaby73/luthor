import 'package:luthor/src/validation.dart';

class StringCuid2Validation extends Validation {
  String? customMessage;

  StringCuid2Validation({
    String? message,
  }) : customMessage = message;

  static const String _regex = r'''^[a-z][a-z0-9]*$''';

  @override
  bool call(String? fieldName, dynamic value) {
    this.fieldName = fieldName;

    if (value == null) return true;
    return RegExp(_regex).hasMatch(value as String);
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a valid cuid2';
}
