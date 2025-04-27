import 'package:luthor/luthor.dart';

class SchemaValidation extends Validation {
  Map<String, dynamic>? failedMessage;
  final Map<String, Validator> validatorSchema;

  SchemaValidation(this.validatorSchema);

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    failedMessage = null;

    if (value == null) return true;
    if (value is! Map) {
      failedMessage ??= {};
      failedMessage![fieldName ?? '[DEFAULT]'] = ['value must be a map'];
      return false;
    }

    for (final entry in validatorSchema.entries) {
      final name = entry.key;
      final validator = entry.value;
      final fieldValue = value[name];

      if (fieldValue is Map<String, Object?>) {
        final result = validator.validateSchemaWithFieldName(name, fieldValue);

        if (result case SchemaValidationError(data: _, errors: final errors)) {
          failedMessage ??= {};
          (failedMessage!.putIfAbsent(name, () => {}) as Map).addAll(errors);
        }
      } else {
        failedMessage ??= {};
        final result = validator.validateValueWithFieldName(name, fieldValue);

        if (result case SingleValidationError(data: _, errors: final errors)) {
          failedMessage ??= {};
          (failedMessage!.putIfAbsent(name, () => []) as List).addAll(errors);
        }
      }
    }

    return failedMessage == null;
  }

  @override
  Map<String, dynamic> get errors => failedMessage!;

  @override
  String? get message => null;
}
