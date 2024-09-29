import 'package:luthor/src/validation.dart';

class StringCuidValidation extends Validation {
  String? customMessage;

  StringCuidValidation({
    String? message,
  }) : customMessage = message;

  static const String _regex = r'''c[^\s-]{8,}$''';
  static final _regexObject = RegExp(_regex, caseSensitive: false);

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;
    return _regexObject.hasMatch(value);
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a valid cuid';

  @override
  Map<String, List<String>>? get errors => null;
}
