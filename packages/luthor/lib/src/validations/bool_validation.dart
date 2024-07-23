import 'package:luthor/src/validation.dart';

class BoolValidation extends Validation {
  String? customMessage;

  BoolValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value is bool?;
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a bool';

  @override
  Map<String, List<String>>? get errors => null;

  @override
  String toString() => 'BoolValidation{message: $message}';

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'bool',
      'message': message,
    };
  }
}
