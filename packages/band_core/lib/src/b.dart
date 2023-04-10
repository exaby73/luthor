import 'package:band_core/src/validation.dart';
import 'package:band_core/src/validation_result.dart';
import 'package:band_core/src/validations/email_validation.dart';
import 'package:band_core/src/validations/int_validation.dart';
import 'package:band_core/src/validations/number_validation.dart';
import 'package:band_core/src/validations/required_validation.dart';
import 'package:band_core/src/validations/string_validation.dart';

class _Validator {
  _Validator();

  final List<Validation> _validations = [];

  _Validator required([String? message]) {
    _validations.add(RequiredValidation(message: message));
    return this;
  }

  _Validator string([String? message]) {
    _validations.add(StringValidation(message: message));
    return this;
  }

  _Validator email([String? message]) {
    _validations.add(EmailValidation(message: message));
    return this;
  }

  _Validator number([String? message]) {
    _validations.add(NumberValidation(message: message));
    return this;
  }

  _Validator int([String? message]) {
    _validations.add(IntValidation(message: message));
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

_Validator get b => _Validator();
