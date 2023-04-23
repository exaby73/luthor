import 'package:luthor/src/validation.dart';

class StringUuidValidation extends Validation {
  String? customMessage;

  StringUuidValidation({
    String? message,
  }) : customMessage = message;

  static const String _regex =
      r'''^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$''';

  @override
  bool call(String? fieldName, dynamic value) {
    this.fieldName = fieldName;

    if (value == null) return true;
    return RegExp(_regex).hasMatch(value as String);
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a valid uuid';
}
