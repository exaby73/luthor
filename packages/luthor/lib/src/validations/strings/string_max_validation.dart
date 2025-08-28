import 'package:luthor/src/validation.dart';

class StringMaxValidation extends Validation {
  int maxLength;
  String? customMessage;
  String? Function()? customMessageFn;

  StringMaxValidation({
    required this.maxLength,
    String? message,
    String? Function()? messageFn,
  }) : assert(maxLength >= 0, 'minLength must be greater than or equal to 0'),
       customMessage = message,
       customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    this.fieldName = fieldName;
    if (value == null) return true;
    if (value is! String) return false;
    return value.length <= maxLength;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    if (customMessageFn != null) {
      final m = customMessageFn!();
      if (m != null) return m;
    }
    return '${fieldName ?? 'value'} must not be more than '
        '$maxLength character${maxLength != 1 ? 's' : ''} long';
  }

  @override
  Map<String, List<String>>? get errors => null;
}
