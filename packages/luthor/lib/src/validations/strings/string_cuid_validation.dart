import 'package:luthor/src/validation.dart';

class StringCuidValidation extends Validation {
  String? customMessage;

  StringCuidValidation({
    String? message,
  }) : customMessage = message;

  static const String _regex = r'''c[^\s-]{8,}$''';

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;
    return RegExp(_regex, caseSensitive: false).hasMatch(value);
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a valid cuid';

  @override
  Map<String, List<String>>? get errors => null;

  @override
  String toString() => 'StringCuidValidation{message: $message}';

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'string_cuid',
      'message': message,
    };
  }
}
