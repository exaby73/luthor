import 'package:luthor/src/validation.dart';
import 'package:luthor/src/validation_result.dart';
import 'package:luthor/src/validations/any_validation.dart';
import 'package:luthor/src/validations/bool_validation.dart';
import 'package:luthor/src/validations/custom_validation.dart';
import 'package:luthor/src/validations/double_validation.dart';
import 'package:luthor/src/validations/int_validation.dart';
import 'package:luthor/src/validations/list_validation.dart';
import 'package:luthor/src/validations/lists/list_length_validation.dart';
import 'package:luthor/src/validations/lists/list_max_validation.dart';
import 'package:luthor/src/validations/lists/list_min_validation.dart';
import 'package:luthor/src/validations/map_validation.dart';
import 'package:luthor/src/validations/null_validation.dart';
import 'package:luthor/src/validations/number_validation.dart';
import 'package:luthor/src/validations/required_validation.dart';
import 'package:luthor/src/validations/schema_custom_validation.dart';
import 'package:luthor/src/validations/schema_validation.dart';
import 'package:luthor/src/validations/string_validation.dart';
import 'package:luthor/src/validator_reference.dart';
import 'package:luthor/src/validators/double_validator.dart';
import 'package:luthor/src/validators/int_validator.dart';
import 'package:luthor/src/validators/list_validator.dart';
import 'package:luthor/src/validators/number_validator.dart';
import 'package:luthor/src/validators/string_validator.dart';
import 'package:meta/meta.dart';

typedef FromJson<T> = T Function(Map<String, Object?> json);

/// Base validator class.
class Validator implements ValidatorReference {
  Validator({List<Validation> initialValidations = const []})
    : validations = List.from(initialValidations);

  String? _name;

  String? get name => _name;

  @protected
  final List<Validation> validations;

  /// Resolves this validator reference (returns itself).
  @override
  Validator resolve() => this;

  Validator withName(String? name) {
    _name = name;
    return this;
  }

  /// Checks if this validator has a required validation.
  bool get hasRequiredValidation {
    return validations.any((v) => v is RequiredValidation);
  }

  /// Gets the SchemaValidation from this validator if it exists.
  SchemaValidation? get schemaValidation {
    for (final validation in validations) {
      if (validation is SchemaValidation) {
        return validation;
      }
    }
    return null;
  }

  /// Sets schema data for any SchemaCustomValidation instances in this validator
  void setSchemaDataForValidations(Map<String, Object?> data) {
    for (final validation in validations) {
      if (validation is SchemaCustomValidation) {
        validation.schemaData = data;
      }
    }
  }

  /// Validates a value against a custom validator function.
  Validator custom(
    CustomValidator customValidator, {
    String? message,
    String? Function()? messageFn,
  }) {
    final newValidations = List<Validation>.from(validations)
      ..add(
        CustomValidation(
          customValidator,
          message: message,
          messageFn: messageFn,
        ),
      );
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  /// Validates a value against a custom validator function that has access to the entire schema data.
  Validator customWithSchema(
    SchemaCustomValidator customValidator, {
    String? message,
    String? Function()? messageFn,
  }) {
    final newValidations = List<Validation>.from(validations)
      ..add(
        SchemaCustomValidation(
          customValidator,
          message: message,
          messageFn: messageFn,
        ),
      );
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  /// Validates a value as dynamic. Always returns true.
  Validator any() {
    final newValidations = List<Validation>.from(validations)
      ..add(AnyValidation());
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  /// Validates that the value is not null.
  Validator required({String? message, String? Function()? messageFn}) {
    final newValidations = List<Validation>.from(validations)
      ..add(RequiredValidation(message: message, messageFn: messageFn));
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  /// Validates that the value is null.
  Validator nullValue({String? message, String? Function()? messageFn}) {
    final newValidations = List<Validation>.from(validations)
      ..add(NullValidation(message: message, messageFn: messageFn));
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  /// Validates that the value is a string.
  StringValidator string({String? message, String? Function()? messageFn}) {
    final newValidations = List<Validation>.from(validations)
      ..add(StringValidation(message: message, messageFn: messageFn));
    return StringValidator(initialValidations: newValidations);
  }

  /// Validates that the value is a number (int or double).
  NumberValidator number({String? message, String? Function()? messageFn}) {
    final newValidations = List<Validation>.from(validations)
      ..add(NumberValidation(message: message, messageFn: messageFn));
    return NumberValidator(initialValidations: newValidations);
  }

  /// Validates that the value is an int.
  IntValidator int({String? message, String? Function()? messageFn}) {
    final newValidations = List<Validation>.from(validations)
      ..add(IntValidation(message: message, messageFn: messageFn));
    return IntValidator(initialValidations: newValidations);
  }

  /// Validates that the value is a double.
  DoubleValidator double({String? message, String? Function()? messageFn}) {
    final newValidations = List<Validation>.from(validations)
      ..add(DoubleValidation(message: message, messageFn: messageFn));
    return DoubleValidator(initialValidations: newValidations);
  }

  /// Validates that the value is a bool.
  Validator boolean({String? message, String? Function()? messageFn}) {
    final newValidations = List<Validation>.from(validations)
      ..add(BoolValidation(message: message, messageFn: messageFn));
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  /// Validates that the value is a list.
  ListValidator list({
    List<ValidatorReference>? validators,
    String? message,
    String? Function()? messageFn,
  }) {
    final newValidations = List<Validation>.from(validations)
      ..add(
        ListValidation(
          validators: validators,
          message: message,
          messageFn: messageFn,
        ),
      );
    return ListValidator(initialValidations: newValidations);
  }

  /// Validates that the value is a map.
  /// Optionally validates keys and values using [keyValidator] and [valueValidator].
  Validator map({
    String? message,
    String? Function()? messageFn,
    ValidatorReference? keyValidator,
    ValidatorReference? valueValidator,
  }) {
    final newValidations = List<Validation>.from(validations)
      ..add(
        MapValidation(
          message: message,
          messageFn: messageFn,
          keyValidator: keyValidator,
          valueValidator: valueValidator,
        ),
      );
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  /// Validates that the value matches the given schema.
  Validator schema(Map<String, ValidatorReference> validatorSchema) {
    final newValidations = List<Validation>.from(validations)
      ..add(SchemaValidation(validatorSchema));
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  Map<String, dynamic>? _isValid(
    String? fieldName,
    dynamic value, [
    Set<SchemaValidation>? validatingSchemas,
  ]) {
    if (validatingSchemas != null) {
      final sv = schemaValidation;
      if (sv != null) {
        for (final validatingSchema in validatingSchemas) {
          if (identical(validatingSchema.validatorSchema, sv.validatorSchema)) {
            return null;
          }
        }
        if (validatingSchemas.contains(sv)) {
          return null;
        }
      }
    }

    final errors = <String, dynamic>{};
    final currentSchemas = validatingSchemas ?? <SchemaValidation>{};

    for (final validation in validations) {
      if (validation is SchemaValidation) {
        if (currentSchemas.contains(validation)) {
          continue;
        }
        currentSchemas.add(validation);
        if (!validation.validate(fieldName, value, currentSchemas)) {
          errors.addAll(validation.errors);
        }
        currentSchemas.remove(validation);
      } else if (validation is ListValidation) {
        if (!validation.validate(fieldName, value, currentSchemas)) {
          (errors.putIfAbsent(fieldName ?? '[DEFAULT]', () => []) as List).add(
            validation.message,
          );
        }
      } else if (validation is MapValidation) {
        if (!validation(fieldName, value)) {
          // MapValidation.errors returns a Map, merge it into errors
          final mapErrors = validation.errors;
          if (mapErrors != null) {
            errors.addAll(mapErrors);
          } else {
            // Fallback to message if no structured errors
            (errors.putIfAbsent(fieldName ?? '[DEFAULT]', () => []) as List)
                .add(validation.message);
          }
        }
      } else {
        if (!validation(fieldName, value)) {
          (errors.putIfAbsent(fieldName ?? '[DEFAULT]', () => []) as List).add(
            validation.message,
          );
        }
      }
    }

    if (errors.isEmpty) return null;
    return errors;
  }

  /// Validates a single value.
  SingleValidationResult<T> validateValue<T>(T value) {
    final errorMessage = _isValid(null, value);
    if (errorMessage != null) {
      // Check if errors are in Map format (from MapValidation with key/value validators)
      // If so, flatten them to a list for SingleValidationError
      if (errorMessage.containsKey('[DEFAULT]')) {
        return SingleValidationError(
          data: value,
          errors: (errorMessage['[DEFAULT]']! as List).cast(),
        );
      } else {
        // Structured errors from MapValidation - convert to list with key prefixes
        final errorList = <String>[];
        for (final entry in errorMessage.entries) {
          if (entry.value is List) {
            final key = entry.key;
            for (final error in (entry.value as List)) {
              errorList.add('$key: $error');
            }
          } else if (entry.value is Map) {
            final key = entry.key;
            if (key == 'keys' || key == 'values') {
              // Flatten nested key/value errors: keys.key1 -> key1, values.key1 -> key1
              _flattenErrors(entry.value as Map, errorList, '');
            } else {
              // Other nested map errors - flatten with prefix
              _flattenErrors(entry.value as Map, errorList, entry.key);
            }
          }
        }
        return SingleValidationError(data: value, errors: errorList);
      }
    }
    return SingleValidationSuccess(data: value);
  }

  void _flattenErrors(Map errorMap, List<String> errorList, String prefix) {
    for (final entry in errorMap.entries) {
      final key = prefix.isEmpty
          ? entry.key.toString()
          : '$prefix.${entry.key}';
      if (entry.value is List) {
        for (final error in (entry.value as List)) {
          errorList.add('$key: $error');
        }
      } else if (entry.value is Map) {
        _flattenErrors(entry.value as Map, errorList, key);
      }
    }
  }

  /// Validates a single value with a field name.
  SingleValidationResult<T> validateValueWithFieldName<T>(
    String fieldName,
    T value, {
    Set<SchemaValidation>? validatingSchemas,
  }) {
    final errors = _isValid(fieldName, value, validatingSchemas);
    if (errors != null) {
      return SingleValidationError(
        data: value,
        errors: (errors[fieldName]! as List).cast(),
      );
    }
    return SingleValidationSuccess(data: value);
  }

  /// Validates a schema.
  SchemaValidationResult<T> validateSchema<T>(
    Map<String, Object?> value, {
    FromJson<T>? fromJson,
    Set<SchemaValidation>? validatingSchemas,
  }) {
    final errors = _isValid(null, value, validatingSchemas);
    if (errors != null) {
      return SchemaValidationError(
        data: fromJson != null ? null : value as T,
        errors: errors,
      );
    }
    return SchemaValidationSuccess(data: fromJson?.call(value) ?? value as T);
  }

  /// Validates a schema with a field name.
  SchemaValidationResult<T> validateSchemaWithFieldName<T>(
    String fieldName,
    Map<String, Object?> value, {
    FromJson<T>? fromJson,
    Set<SchemaValidation>? validatingSchemas,
  }) {
    final errors = _isValid(fieldName, value, validatingSchemas);
    if (errors != null) {
      return SchemaValidationError(
        data: fromJson != null ? null : value as T,
        errors: errors,
      );
    }
    return SchemaValidationSuccess(data: fromJson?.call(value) ?? value as T);
  }
}
