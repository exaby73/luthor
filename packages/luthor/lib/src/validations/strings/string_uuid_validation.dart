import 'package:luthor/src/validation.dart';

class StringUuidValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;

  StringUuidValidation({String? message, String? Function()? messageFn})
    : customMessage = message,
      customMessageFn = messageFn;

  static const String _regex =
      r'''^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$''';
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
      '${fieldName ?? 'value'} must be a valid uuid';

  @override
  Map<String, List<String>>? get errors => null;
}
