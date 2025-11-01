import 'package:luthor/luthor.dart';

class SchemaValidation extends Validation {
  Map<String, dynamic>? failedMessage;
  final Map<String, ValidatorReference> validatorSchema;

  SchemaValidation(this.validatorSchema);

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return validate(fieldName, value);
  }

  bool validate(
    String? fieldName,
    Object? value, [
    Set<SchemaValidation>? validatingSchemas,
  ]) {
    failedMessage = null;

    if (value == null) return true;
    if (value is! Map) {
      failedMessage ??= {};
      failedMessage![fieldName ?? '[DEFAULT]'] = ['value must be a map'];
      return false;
    }

    // Always use a set for cycle detection, even if not provided
    final currentSchemas = validatingSchemas ?? <SchemaValidation>{};

    for (final entry in validatorSchema.entries) {
      final name = entry.key;
      // Resolve the ValidatorReference to a Validator only when needed
      final validator = entry.value.resolve();
      final fieldValue = value[name];

      // Set schema data for any SchemaCustomValidation instances
      validator.setSchemaDataForValidations(value.cast<String, Object?>());

      // Check if the field is missing from input
      final fieldExists = value.containsKey(name);

      // Check if this validator requires the field
      final hasRequiredValidation = validator.hasRequiredValidation;

      // Skip validation for missing optional fields
      if (!fieldExists && !hasRequiredValidation) {
        continue;
      }

      final sv = validator.schemaValidation;
      bool isCycle = false;
      if (sv != null) {
        for (final validatingSchema in currentSchemas) {
          // Compare the reference schemas directly for cycle detection
          // Both are Map<String, ValidatorReference>, so we can compare them
          if (identical(validatingSchema.validatorSchema, sv.validatorSchema)) {
            isCycle = true;
            break;
          }
        }
      }

      if (isCycle) {
        continue;
      }

      if (fieldValue is Map<String, Object?>) {
        final result = validator.validateSchemaWithFieldName(
          name,
          fieldValue,
          validatingSchemas: currentSchemas,
        );

        if (result case SchemaValidationError(data: _, errors: final errors)) {
          failedMessage ??= {};
          (failedMessage!.putIfAbsent(name, () => {}) as Map).addAll(errors);
        }
      } else {
        failedMessage ??= {};
        final result = validator.validateValueWithFieldName(
          name,
          fieldValue,
          validatingSchemas: currentSchemas,
        );

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
