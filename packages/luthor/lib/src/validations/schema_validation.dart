import 'package:luthor/src/validation.dart';
import 'package:luthor/src/validator.dart';

class SchemaValidation extends Validation {
  String? failedMessage;
  final Map<String, Validator> validatorSchema;

  SchemaValidation(this.validatorSchema);

  @override
  bool call(String? fieldName, covariant Map<String, dynamic> value) {
    for (final entry in validatorSchema.entries) {
      var name = entry.key;
      final validator = entry.value;
      final fieldValue = value[name];

      if (fieldName != null) {
        name = '$fieldName.$name';
      }
      
      final result = validator.validateWithFieldName(name, fieldValue);

      if (!result.isValid) {
        failedMessage = result.message;
        return false;
      }
    }

    return true;
  }

  @override
  String get message => failedMessage!;
}
