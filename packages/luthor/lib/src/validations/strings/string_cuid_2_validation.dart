import 'package:luthor/src/validation.dart';

class StringCuid2Validation extends Validation {
  String? customMessage;

  StringCuid2Validation({
    String? message,
  }) : customMessage = message;

  static const String _regex = r'''^[a-z][a-z0-9]*$''';

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;
    return RegExp(_regex).hasMatch(value);
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a valid cuid2';

  @override
  Map<String, List<String>>? get errors => null;
}
