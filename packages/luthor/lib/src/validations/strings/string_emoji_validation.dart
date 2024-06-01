import 'package:luthor/src/validation.dart';

class StringEmojiValidation extends Validation {
  String? customMessage;

  StringEmojiValidation({
    String? message,
  }) : customMessage = message;

  static const String _regex =
      r'''^(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])+$''';

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;
    return RegExp(_regex).hasMatch(value);
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a valid emoji';

  @override
  Map<String, List<String>>? get errors => null;
}
