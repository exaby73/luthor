import 'package:luthor/src/validation.dart';

class ListMinValidation extends Validation {
  final int minLength;
  final String? customMessage;
  String? Function()? customMessageFn;

  ListMinValidation({
    required this.minLength,
    String? message,
    String? Function()? messageFn,
  })  : customMessage = message,
        customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    if (value is! List?) return false;
    if (value == null) return true;
    return value.length >= minLength;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    if (customMessageFn != null) {
      final m = customMessageFn!();
      if (m != null) return m;
    }
    return '${fieldName ?? 'value'} must have at least $minLength items';
  }

  @override
  Map<String, List<String>>? get errors => null;
}
