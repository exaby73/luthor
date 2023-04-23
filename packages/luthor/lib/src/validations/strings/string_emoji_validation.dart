import 'package:luthor/src/validation.dart';

class StringEmojiValidation extends Validation {
  String? customMessage;

  StringEmojiValidation({
    String? message,
  }) : customMessage = message;

  static const String _regex =
      r'''(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])''';

  @override
  bool call(String? fieldName, dynamic value) {
    this.fieldName = fieldName;

    if (value == null) return true;
    return RegExp(_regex).hasMatch(value as String);
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a valid emoji';
}
