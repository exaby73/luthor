import 'package:luthor/src/validation.dart';
import 'package:luthor/src/validations/numbers/max_validation.dart';
import 'package:luthor/src/validations/numbers/min_validation.dart';
import 'package:luthor/src/validator.dart';

/// Validator for nums.
class NumberValidator extends Validator {
  NumberValidator({super.initialValidations});

  NumberValidator _copyWith(Validation validation) {
    final newValidator = NumberValidator(
      initialValidations: [...validations, validation],
    );
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the int is greater than or equal to minValue.
  NumberValidator min(
    num minValue, {
    String? message,
    String? Function()? messageFn,
  }) {
    return _copyWith(
      NumberMinValidation(
        minValue: minValue,
        message: message,
        messageFn: messageFn,
      ),
    );
  }

  /// Validates that the int is less than or equal to minValue.
  NumberValidator max(
    num maxValue, {
    String? message,
    String? Function()? messageFn,
  }) {
    return _copyWith(
      NumberMaxValidation(
        maxValue: maxValue,
        message: message,
        messageFn: messageFn,
      ),
    );
  }
}
