import 'package:band_core/src/validation.dart';
import 'package:band_core/src/validation_result.dart';
import 'package:band_core/src/validations/any_validation.dart';
import 'package:band_core/src/validations/bool_validation.dart';
import 'package:band_core/src/validations/date_time_validation.dart';
import 'package:band_core/src/validations/double_validation.dart';
import 'package:band_core/src/validations/email_validation.dart';
import 'package:band_core/src/validations/int_validation.dart';
import 'package:band_core/src/validations/null_validation.dart';
import 'package:band_core/src/validations/number_validation.dart';
import 'package:band_core/src/validations/required_validation.dart';
import 'package:band_core/src/validations/schema_validation.dart';
import 'package:band_core/src/validations/string_validation.dart';

class Validator {
  Validator();

  final List<Validation> _validations = [];

  Validator any([String? message]) {
    _validations.add(AnyValidation(message: message));
    return this;
  }

  Validator required([String? message]) {
    _validations.add(RequiredValidation(message: message));
    return this;
  }

  Validator nullValue([String? message]) {
    _validations.add(NullValidation(message: message));
    return this;
  }

  Validator string([String? message]) {
    _validations.add(StringValidation(message: message));
    return this;
  }

  Validator email([String? message]) {
    _validations.add(EmailValidation(message: message));
    return this;
  }

  Validator dateTime([String? message]) {
    _validations.add(DateTimeValidation(message: message));
    return this;
  }

  Validator number([String? message]) {
    _validations.add(NumberValidation(message: message));
    return this;
  }

  Validator int([String? message]) {
    _validations.add(IntValidation(message: message));
    return this;
  }

  Validator double([String? message]) {
    _validations.add(DoubleValidation(message: message));
    return this;
  }

  Validator bool([String? message]) {
    _validations.add(BoolValidation(message: message));
    return this;
  }

  Validator schema(Map<String, Validator> validatorSchema) {
    _validations.add(SchemaValidation(validatorSchema));
    return this;
  }

  String? _isValid(String fieldName, dynamic value) {
    for (final validation in _validations) {
      if (!validation(fieldName, value)) {
        return validation.message;
      }
    }
    return null;
  }

  ValidationResult validate(dynamic value) {
    final errorMessage = _isValid('value', value);
    return ValidationResult(
      isValid: errorMessage == null,
      message: errorMessage,
    );
  }

  ValidationResult validateWithFieldName(String fieldName, dynamic value) {
    final errorMessage = _isValid(fieldName, value);
    return ValidationResult(
      isValid: errorMessage == null,
      message: errorMessage,
    );
  }
}

