import 'package:luthor/src/validation.dart';

typedef CustomValidator = bool Function(Object? value);
typedef SchemaCustomValidator =
    bool Function(Object? value, Map<String, Object?> data);

class CustomValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;
  final CustomValidator customValidator;

  CustomValidation(
    this.customValidator, {
    String? message,
    String? Function()? messageFn,
  }) : customMessage = message,
       customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    try {
      return customValidator(value);
    } catch (e, s) {
      // ignore: avoid_print
      print(e);
      // ignore: avoid_print
      print(s);
      return false;
    }
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} does not pass custom validation';

  @override
  Map<String, List<String>>? get errors => null;
}
