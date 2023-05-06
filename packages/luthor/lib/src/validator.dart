import 'package:luthor/src/validation.dart';
import 'package:luthor/src/validation_result.dart';
import 'package:luthor/src/validations/any_validation.dart';
import 'package:luthor/src/validations/bool_validation.dart';
import 'package:luthor/src/validations/double_validation.dart';
import 'package:luthor/src/validations/int_validation.dart';
import 'package:luthor/src/validations/list_validation.dart';
import 'package:luthor/src/validations/null_validation.dart';
import 'package:luthor/src/validations/number_validation.dart';
import 'package:luthor/src/validations/required_validation.dart';
import 'package:luthor/src/validations/schema_validation.dart';
import 'package:luthor/src/validations/string_validation.dart';
import 'package:luthor/src/validators/string_validator.dart';

/// Base validator class.
class Validator {
  Validator({List<Validation> initialValidations = const []})
      : validations = List.from(initialValidations);

  final List<Validation> validations;

  /// Validates a value as dynamic. Always returns true.
  Validator any({String? message}) {
    validations.add(AnyValidation(message: message));
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
  Validator number({String? message}) {
    validations.add(NumberValidation(message: message));
    return this;
  }

  /// Validates that the value is an int.
  Validator int({String? message}) {
    validations.add(IntValidation(message: message));
    return this;
  }

  /// Validates that the value is a double.
  Validator double({String? message}) {
    validations.add(DoubleValidation(message: message));
    return this;
  }

  /// Validates that the value is a bool.
  Validator bool({String? message}) {
    validations.add(BoolValidation(message: message));
    return this;
  }

  /// Validates that the value is a list.
  Validator list({List<Validator>? validators, String? message}) {
    validations.add(ListValidation(validations: validators, message: message));
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
      return SingleValidationResult.error(
        (errorMessage['[DEFAULT]']! as List).cast(),
      );
    }
    return SingleValidationResult.success(value);
  }

  /// Validates a single value with a field name.
  SingleValidationResult<T> validateValueWithFieldName<T>(
    String fieldName,
    T value,
  ) {
    final errors = _isValid(fieldName, value);
    if (errors != null) {
      return SingleValidationResult.error((errors[fieldName]! as List).cast());
    }
    return SingleValidationResult.success(value);
  }

  /// Validates a schema.
  SchemaValidationResult<Map<String, Object?>> validateSchema(
    Map<String, Object?> value,
  ) {
    final errors = _isValid(null, value);
    if (errors != null) {
      return SchemaValidationResult.error(errors);
    }
    return SchemaValidationResult.success(value);
  }

  /// Validates a schema with a field name.
  SchemaValidationResult<Map<String, Object?>> validateSchemaWithFieldName(
    String fieldName,
    Map<String, Object?> value,
  ) {
    final errors = _isValid(fieldName, value);
    if (errors != null) {
      return SchemaValidationResult.error(errors);
    }
    return SchemaValidationResult.success(value);
  }
}
