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

  /// Validates a value against a custom validator function.
  Validator custom(CustomValidator customValidator, {String? message}) {
    validations.add(CustomValidation(customValidator, message: message));
    return this;
  }

  /// Validates a value as dynamic. Always returns true.
  Validator any() {
    validations.add(AnyValidation());
    return this;
  }

  /// Validates that the value is not null.
  Validator required({String? message}) {
    validations.add(RequiredValidation(message: message));
    return this;
  }

  /// Validates that the value is null.
  Validator nullValue({String? message}) {
    validations.add(NullValidation(message: message));
    return this;
  }

  /// Validates that the value is a string.
  StringValidator string({String? message}) {
    validations.add(StringValidation(message: message));
    return StringValidator(initialValidations: validations);
  }

  /// Validates that the value is a number (int or double).
  NumberValidator number({String? message}) {
    validations.add(NumberValidation(message: message));
    return NumberValidator(initialValidations: validations);
  }

  /// Validates that the value is an int.
  IntValidator int({String? message}) {
    validations.add(IntValidation(message: message));
    return IntValidator(initialValidations: validations);
  }

  /// Validates that the value is a double.
  DoubleValidator double({String? message}) {
    validations.add(DoubleValidation(message: message));
    return DoubleValidator(initialValidations: validations);
  }

  /// Validates that the value is a bool.
  Validator boolean({String? message}) {
    validations.add(BoolValidation(message: message));
    return this;
  }

  /// Validates that the value is a list.
  Validator list({List<Validator>? validators, String? message}) {
    validations.add(ListValidation(validators: validators, message: message));
    return this;
  }

  /// Validates that the value is a map.
  Validator map({String? message}) {
    validations.add(MapValidation(message: message));
    return this;
  }

  /// Validates that the value matches the given schema.
  Validator schema(Map<String, Validator> validatorSchema) {
    validations.add(SchemaValidation(validatorSchema));
    return this;
  }

  Map<String, dynamic>? _isValid(String? fieldName, dynamic value) {
    final errors = <String, dynamic>{};

    for (final validation in validations) {
      if (!validation(fieldName, value)) {
        if (validation is SchemaValidation) {
          errors.addAll(validation.errors);
        } else {
          (errors.putIfAbsent(fieldName ?? '[DEFAULT]', () => []) as List)
              .add(validation.message);
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
