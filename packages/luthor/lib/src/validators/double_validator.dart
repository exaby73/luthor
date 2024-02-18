import 'package:luthor/src/validations/numbers/max_validation.dart';
import 'package:luthor/src/validations/numbers/min_validation.dart';
import 'package:luthor/src/validator.dart';

/// Validator for ints.
class DoubleValidator extends Validator {
  DoubleValidator({super.initialValidations});

  /// Validates that the int is greater than or equal to minValue.
  DoubleValidator min(double minValue, {String? message}) {
    validations.add(NumberMinValidation(minValue: minValue, message: message));
    return this;
  }

  /// Validates that the int is less than or equal to minValue.
  DoubleValidator max(double maxValue, {String? message}) {
    validations.add(NumberMaxValidation(maxValue: maxValue, message: message));
    return this;
  }
}
