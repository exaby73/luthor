import 'package:luthor/luthor.dart';

class ListValidation extends Validation {
  final List<ValidatorReference>? validators;
  final String? customMessage;
  String? Function()? customMessageFn;

  ListValidation({
    this.validators,
    String? message,
    String? Function()? messageFn,
  }) : customMessage = message,
       customMessageFn = messageFn;

  bool _isValid(
    Validator validation,
    dynamic e, [
    Set<SchemaValidation>? validatingSchemas,
    int depth = 0,
  ]) {
    // Maximum depth limit to prevent stack overflow while allowing deep structures
    const maxDepth = 1024;

    if (e is Map<String, Object?>) {
      if (validatingSchemas == null) {
        return validation.validateSchema(e).isValid;
      }

      final sv = validation.schemaValidation;
      if (sv != null) {
        for (final validatingSchema in validatingSchemas) {
          if (identical(validatingSchema.validatorSchema, sv.validatorSchema)) {
            // Cycle detected - check depth limit
            if (depth >= maxDepth) {
              // Reached maximum depth, assume valid to prevent stack overflow
              return true;
            }
            // Validate this level with empty set to allow deeper validation
            // but increment depth to track recursion depth
            return _isValid(validation, e, <SchemaValidation>{}, depth + 1);
          }
        }
        if (validatingSchemas.contains(sv)) {
          // Cycle detected - check depth limit
          if (depth >= maxDepth) {
            // Reached maximum depth, assume valid to prevent stack overflow
            return true;
          }
          // Validate this level with empty set to allow deeper validation
          // but increment depth to track recursion depth
          return _isValid(validation, e, <SchemaValidation>{}, depth + 1);
        }
      }

      return validation
          .validateSchema(e, validatingSchemas: validatingSchemas)
          .isValid;
    }

    return validation.validateValue(e).isValid;
  }

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return validate(fieldName, value);
  }

  bool validate(
    String? fieldName,
    Object? value, [
    Set<SchemaValidation>? validatingSchemas,
    int depth = 0,
  ]) {
    if (value is! List?) return false;
    if (value == null) return true;
    if (validators == null) return true;

    for (final e in value) {
      if (!validators!.any((v) {
        // Resolve ValidatorReference to Validator
        final validator = v.resolve();
        // When validating a Map that might be a schema, increment depth
        final nextDepth = e is Map<String, Object?> ? depth + 1 : depth;
        return _isValid(validator, e, validatingSchemas, nextDepth);
      })) {
        return false;
      }
    }

    return true;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    if (customMessageFn != null) {
      final m = customMessageFn!();
      if (m != null) return m;
    }
    final m = '${fieldName ?? 'value'} must be a list';
    if (validators == null) return m;
    return '$m or does not match the validations';
  }

  @override
  Map<String, List<String>>? get errors => null;
}
