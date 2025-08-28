import 'package:luthor/src/validation.dart';
import 'package:luthor/src/validations/custom_validation.dart';

class SchemaCustomValidation extends Validation {
  final SchemaCustomValidator customValidator;
  final String? customMessage;
  String? Function()? customMessageFn;
  Map<String, Object?>? schemaData;

  SchemaCustomValidation(
    this.customValidator, {
    String? message,
    String? Function()? messageFn,
  }) : customMessage = message,
       customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    try {
      if (schemaData == null) {
        // Fallback to true if no schema data is available
        return true;
      }
      return customValidator(value, schemaData!);
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
      '${fieldName ?? 'value'} does not pass schema custom validation';

  @override
  Map<String, List<String>>? get errors => null;
}
