import 'package:luthor/src/validation.dart';

typedef CustomValidator = bool Function(Object? value);

class CustomValidation extends Validation {
  String? customMessage;
  final CustomValidator customValidator;

  CustomValidation(
    this.customValidator, {
    String? message,
  }) : customMessage = message;

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
      '${fieldName ?? 'value'} does not pass custom validation';

  @override
  Map<String, List<String>>? get errors => null;
}
