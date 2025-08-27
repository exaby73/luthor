import 'package:luthor/src/validation.dart';
import 'package:luthor/src/validations/custom_validation.dart';

class SchemaCustomValidation extends Validation {
  final SchemaCustomValidator customValidator;
  final String? customMessage;
  Map<String, Object?>? _schemaData;

  SchemaCustomValidation(this.customValidator, {String? message})
      : customMessage = message;

  void setSchemaData(Map<String, Object?> data) {
    _schemaData = data;
  }

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    try {
      if (_schemaData == null) {
        // Fallback to true if no schema data is available
        return true;
      }
      return customValidator(value, _schemaData!);
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
      '${fieldName ?? 'value'} does not pass schema custom validation';

  @override
  Map<String, List<String>>? get errors => null;
}