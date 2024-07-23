import 'package:luthor/src/validation.dart';

class StringValidation extends Validation {
  String? customMessage;

  StringValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value is String?;
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a string';

  @override
  Map<String, List<String>>? get errors => null;

  @override
  String toString() => 'StringValidation{message: $message}';

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'string',
      'message': message,
    };
  }
}
