import 'package:luthor/src/validation.dart';

class StringCuidValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;

  StringCuidValidation({String? message, String? Function()? messageFn})
    : customMessage = message,
      customMessageFn = messageFn;

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
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must be a valid cuid';

  @override
  Map<String, List<String>>? get errors => null;
}
