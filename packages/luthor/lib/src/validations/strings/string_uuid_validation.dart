import 'package:luthor/src/validation.dart';

class StringUuidValidation extends Validation {
  String? customMessage;

  StringUuidValidation({
    String? message,
  }) : customMessage = message;

  static const String _regex =
      r'''^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$''';

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;
    return RegExp(_regex, caseSensitive: false).hasMatch(value);
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a valid uuid';

  @override
  Map<String, List<String>>? get errors => null;
}
