import 'package:luthor/src/validation.dart';
import 'package:luthor/src/validation_result.dart';
import 'package:luthor/src/validations/any_validation.dart';
import 'package:luthor/src/validations/bool_validation.dart';
import 'package:luthor/src/validations/custom_validation.dart';
import 'package:luthor/src/validations/double_validation.dart';
import 'package:luthor/src/validations/int_validation.dart';
import 'package:luthor/src/validations/list_validation.dart';
import 'package:luthor/src/validations/map_validation.dart';
import 'package:luthor/src/validations/null_validation.dart';
import 'package:luthor/src/validations/number_validation.dart';
import 'package:luthor/src/validations/required_validation.dart';
import 'package:luthor/src/validations/schema_custom_validation.dart';
import 'package:luthor/src/validations/schema_validation.dart';
import 'package:luthor/src/validations/string_validation.dart';
import 'package:luthor/src/validators/double_validator.dart';
import 'package:luthor/src/validators/int_validator.dart';
import 'package:luthor/src/validators/number_validator.dart';
import 'package:luthor/src/validators/string_validator.dart';
import 'package:meta/meta.dart';

typedef FromJson<T> = T Function(Map<String, Object?> json);

/// Base validator class.
class Validator {
  Validator({List<Validation> initialValidations = const []})
    : validations = List.from(initialValidations);

  String? _name;

  String? get name => _name;

  @protected
  final List<Validation> validations;

  Validator withName(String? name) {
    _name = name;
    return this;
  }

  /// Checks if this validator has a required validation.
  bool get hasRequiredValidation {
    return validations.any((v) => v is RequiredValidation);
  }

  /// Sets schema data for any SchemaCustomValidation instances in this validator
  void setSchemaDataForValidations(Map<String, Object?> data) {
    for (final validation in validations) {
      if (validation is SchemaCustomValidation) {
        validation.setSchemaData(data);
      }
    }
  }

  /// Validates a value against a custom validator function.
  Validator custom(CustomValidator customValidator, {String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(CustomValidation(customValidator, message: message));
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  /// Validates a value against a custom validator function that has access to the entire schema data.
  Validator customWithSchema(SchemaCustomValidator customValidator, {String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(SchemaCustomValidation(customValidator, message: message));
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
  Validator required({String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(RequiredValidation(message: message));
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  /// Validates that the value is null.
  Validator nullValue({String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(NullValidation(message: message));
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  /// Validates that the value is a string.
  StringValidator string({String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(StringValidation(message: message));
    return StringValidator(initialValidations: newValidations);
  }

  /// Validates that the value is a number (int or double).
  NumberValidator number({String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(NumberValidation(message: message));
    return NumberValidator(initialValidations: newValidations);
  }

  /// Validates that the value is an int.
  IntValidator int({String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(IntValidation(message: message));
    return IntValidator(initialValidations: newValidations);
  }

  /// Validates that the value is a double.
  DoubleValidator double({String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(DoubleValidation(message: message));
    return DoubleValidator(initialValidations: newValidations);
  }

  /// Validates that the value is a bool.
  Validator boolean({String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(BoolValidation(message: message));
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  /// Validates that the value is a list.
  Validator list({List<Validator>? validators, String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(ListValidation(validators: validators, message: message));
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  /// Validates that the value is a map.
  Validator map({String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(MapValidation(message: message));
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  /// Validates that the value matches the given schema.
  Validator schema(Map<String, Validator> validatorSchema) {
    final newValidations = List<Validation>.from(validations)
      ..add(SchemaValidation(validatorSchema));
    final newValidator = Validator(initialValidations: newValidations);
    if (_name != null) {
      newValidator._name = _name;
    }
    return newValidator;
  }

  Map<String, dynamic>? _isValid(String? fieldName, dynamic value) {
    final errors = <String, dynamic>{};

    for (final validation in validations) {
      if (!validation(fieldName, value)) {
        if (validation is SchemaValidation) {
          errors.addAll(validation.errors);
        } else {
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
      return SingleValidationError(
        data: value,
        errors: (errorMessage['[DEFAULT]']! as List).cast(),
      );
    }
    return SingleValidationSuccess(data: value);
  }

  /// Validates a single value with a field name.
  SingleValidationResult<T> validateValueWithFieldName<T>(
    String fieldName,
    T value,
  ) {
    final errors = _isValid(fieldName, value);
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
  }) {
    final errors = _isValid(null, value);
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
  }) {
    final errors = _isValid(fieldName, value);
    if (errors != null) {
      return SchemaValidationError(
        data: fromJson != null ? null : value as T,
        errors: errors,
      );
    }
    return SchemaValidationSuccess(data: fromJson?.call(value) ?? value as T);
  }
}
