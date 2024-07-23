import 'package:luthor/src/validation.dart';

class StringLengthValidation extends Validation {
  int length;
  String? customMessage;

  StringLengthValidation({
    required this.length,
    String? message,
  })  : assert(length >= 0, 'minLength must be greater than or equal to 0'),
        customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;
    return value.length == length;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    return '${fieldName ?? 'value'} must be exactly '
        '$length character${length != 1 ? 's' : ''} long';
  }

  @override
  Map<String, List<String>>? get errors => null;

  @override
  String toString() =>
      'StringLengthValidation{message: $message, length: $length}';

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'string_length',
      'message': message,
      'length': length,
    };
  }
}
