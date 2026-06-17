import 'package:luthor/src/validation.dart';
import 'package:luthor/src/validations/numbers/max_validation.dart';
import 'package:luthor/src/validations/numbers/min_validation.dart';
import 'package:luthor/src/validator.dart';

/// Validator for ints.
class IntValidator extends Validator {
  IntValidator({super.initialValidations});

  IntValidator _copyWith(Validation validation) {
    final newValidator = IntValidator(
      initialValidations: [...validations, validation],
    );
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the int is greater than or equal to minValue.
  IntValidator min(
    int minValue, {
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
  IntValidator max(
    int maxValue, {
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
