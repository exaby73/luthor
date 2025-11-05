import 'package:luthor/luthor.dart';

/// Validator for lists.
class ListValidator extends Validator {
  ListValidator({super.initialValidations});

  /// Validates that the list has a minimum number of items.
  ListValidator min(
    int minLength, {
    String? message,
    String? Function()? messageFn,
  }) {
    final newValidations = List<Validation>.from(validations)
      ..add(
        ListMinValidation(
          minLength: minLength,
          message: message,
          messageFn: messageFn,
        ),
      );
    final newValidator = ListValidator(initialValidations: newValidations);
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the list has a maximum number of items.
  ListValidator max(
    int maxLength, {
    String? message,
    String? Function()? messageFn,
  }) {
    final newValidations = List<Validation>.from(validations)
      ..add(
        ListMaxValidation(
          maxLength: maxLength,
          message: message,
          messageFn: messageFn,
        ),
      );
    final newValidator = ListValidator(initialValidations: newValidations);
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the list has a specific number of items.
  ListValidator length(
    int length, {
    String? message,
    String? Function()? messageFn,
  }) {
    final newValidations = List<Validation>.from(validations)
      ..add(
        ListLengthValidation(
          length: length,
          message: message,
          messageFn: messageFn,
        ),
      );
    final newValidator = ListValidator(initialValidations: newValidations);
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }
}
