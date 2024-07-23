import 'package:luthor/src/validation.dart';

class RequiredValidation extends Validation {
  String? customMessage;

  RequiredValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value != null;
  }

  @override
  String get message => customMessage ?? '${fieldName ?? 'value'} is required';

  @override
  Map<String, List<String>>? get errors => null;

  @override
  String toString() => 'RequiredValidation{message: $message}';

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'required',
      'message': message,
    };
  }
}
