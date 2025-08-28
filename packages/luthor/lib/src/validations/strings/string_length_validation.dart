import 'package:luthor/src/validation.dart';

class StringLengthValidation extends Validation {
  int length;
  String? customMessage;
  String? Function()? customMessageFn;

  StringLengthValidation({
    required this.length,
    String? message,
    String? Function()? messageFn,
  }) : assert(length >= 0, 'minLength must be greater than or equal to 0'),
       customMessage = message,
       customMessageFn = messageFn;

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
    if (customMessageFn != null) {
      final m = customMessageFn!();
      if (m != null) return m;
    }
    return '${fieldName ?? 'value'} must be exactly '
        '$length character${length != 1 ? 's' : ''} long';
  }

  @override
  Map<String, List<String>>? get errors => null;
}
