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

  _Validator required() {
    _validations.add(RequiredValidation());
    return this;
  }

  _Validator string() {
    _validations.add(StringValidation());
    return this;
  }

  _Validator email() {
    _validations.add(EmailValidation());
    return this;
  }

  _Validator number() {
    _validations.add(NumberValidation());
    return this;
  }

  _Validator int() {
    _validations.add(IntValidation());
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
