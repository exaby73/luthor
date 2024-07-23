import 'package:luthor/src/validation.dart';

class StringMinValidation extends Validation {
  int minLength;
  String? customMessage;

  StringMinValidation({
    required this.minLength,
    String? message,
  })  : assert(minLength >= 0, 'minLength must be greater than or equal to 0'),
        customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;

    return value.length >= minLength;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    return '${fieldName ?? 'value'} must be at least '
        '$minLength character${minLength != 1 ? 's' : ''} long';
  }

  @override
  Map<String, List<String>>? get errors => null;

  @override
  String toString() =>
      'StringMinValidation{message: $message, minLength: $minLength}';

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'string_min',
      'message': message,
      'minLength': minLength,
    };
  }
}
