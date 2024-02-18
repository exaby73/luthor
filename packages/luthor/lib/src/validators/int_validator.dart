import 'package:luthor/src/validations/ints/max_validation.dart';
import 'package:luthor/src/validations/ints/min_validation.dart';
import 'package:luthor/src/validator.dart';

/// Validator for ints.
class IntValidator extends Validator {
  IntValidator({super.initialValidations});

  /// Validates that the int is greater than or equal to minValue.
  IntValidator min(int minValue, {String? message}) {
    validations.add(IntMinValidation(minValue: minValue, message: message));
    return this;
  }

  /// Validates that the int is less than or equal to minValue.
  IntValidator max(int maxValue, {String? message}) {
    validations.add(IntMaxValidation(maxValue: maxValue, message: message));
    return this;
  }
}
