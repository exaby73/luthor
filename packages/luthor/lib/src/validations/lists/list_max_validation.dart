import 'package:luthor/src/validation.dart';

class ListMaxValidation extends Validation {
  final int maxLength;
  final String? customMessage;
  String? Function()? customMessageFn;

  ListMaxValidation({
    required this.maxLength,
    String? message,
    String? Function()? messageFn,
  })  : customMessage = message,
        customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    if (value is! List?) return false;
    if (value == null) return true;
    return value.length <= maxLength;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    if (customMessageFn != null) {
      final m = customMessageFn!();
      if (m != null) return m;
    }
    return '${fieldName ?? 'value'} must have at most $maxLength items';
  }

  @override
  Map<String, List<String>>? get errors => null;
}
