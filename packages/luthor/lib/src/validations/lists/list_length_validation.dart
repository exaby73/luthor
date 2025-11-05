import 'package:luthor/src/validation.dart';

class ListLengthValidation extends Validation {
  final int length;
  final String? customMessage;
  String? Function()? customMessageFn;

  ListLengthValidation({
    required this.length,
    String? message,
    String? Function()? messageFn,
  })  : customMessage = message,
        customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    if (value is! List?) return false;
    if (value == null) return true;
    return value.length == length;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    if (customMessageFn != null) {
      final m = customMessageFn!();
      if (m != null) return m;
    }
    return '${fieldName ?? 'value'} must have exactly $length items';
  }

  @override
  Map<String, List<String>>? get errors => null;
}
