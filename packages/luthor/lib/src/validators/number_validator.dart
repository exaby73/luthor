import 'package:luthor/src/validations/numbers/max_validation.dart';
import 'package:luthor/src/validations/numbers/min_validation.dart';
import 'package:luthor/src/validator.dart';

/// Validator for nums.
class NumberValidator extends Validator {
  NumberValidator({super.initialValidations});

  /// Validates that the int is greater than or equal to minValue.
  NumberValidator min(num minValue, {String? message}) {
    validations.add(NumberMinValidation(minValue: minValue, message: message));
    return this;
  }

  /// Validates that the int is less than or equal to minValue.
  NumberValidator max(num maxValue, {String? message}) {
    validations.add(NumberMaxValidation(maxValue: maxValue, message: message));
    return this;
  }
}
