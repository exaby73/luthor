import 'package:luthor/luthor.dart';
import 'package:luthor/src/validations/strings/string_url_validation.dart';

/// Validator for strings.
class StringValidator extends Validator {
  StringValidator({super.initialValidations});

  StringValidator _copyWith(Validation validation) {
    final newValidator = StringValidator(
      initialValidations: [...validations, validation],
    );
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the string is a valid date.
  StringValidator dateTime({String? message, String? Function()? messageFn}) {
    final newValidations = List<Validation>.from(validations)
      ..add(StringDateTimeValidation(message: message, messageFn: messageFn));
    final newValidator = StringValidator(initialValidations: newValidations);
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the string is a valid email.
  StringValidator email({String? message, String? Function()? messageFn}) {
    final newValidations = List<Validation>.from(validations)
      ..add(StringEmailValidation(message: message, messageFn: messageFn));
    final newValidator = StringValidator(initialValidations: newValidations);
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the string has a minimum character length.
  StringValidator min(
    int minLength, {
    String? message,
    String? Function()? messageFn,
  }) {
    final newValidations = List<Validation>.from(validations)
      ..add(
        StringMinValidation(
          minLength: minLength,
          message: message,
          messageFn: messageFn,
        ),
      );
    final newValidator = StringValidator(initialValidations: newValidations);
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the string has a maximum character length.
  StringValidator max(
    int maxLength, {
    String? message,
    String? Function()? messageFn,
  }) {
    final newValidations = List<Validation>.from(validations)
      ..add(
        StringMaxValidation(
          maxLength: maxLength,
          message: message,
          messageFn: messageFn,
        ),
      );
    final newValidator = StringValidator(initialValidations: newValidations);
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the string has a specific character length.
  StringValidator length(
    int length, {
    String? message,
    String? Function()? messageFn,
  }) {
    final newValidations = List<Validation>.from(validations)
      ..add(
        StringLengthValidation(
          length: length,
          message: message,
          messageFn: messageFn,
        ),
      );
    final newValidator = StringValidator(initialValidations: newValidations);
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the string is a valid URI.
  StringValidator uri({
    List<String>? allowedSchemes,
    String? message,
    String? Function()? messageFn,
  }) {
    return _copyWith(
      StringUriValidation(
        allowedSchemes: allowedSchemes,
        message: message,
        messageFn: messageFn,
      ),
    );
  }

  /// Validates that the string is a valid URL (must have scheme and host).
  StringValidator url({
    List<String>? allowedSchemes,
    String? message,
    String? Function()? messageFn,
  }) {
    return _copyWith(
      StringUrlValidation(
        allowedSchemes: allowedSchemes,
        message: message,
        messageFn: messageFn,
      ),
    );
  }

  /// Validates that the string is a valid emoji.
  StringValidator emoji({String? message, String? Function()? messageFn}) {
    return _copyWith(
      StringEmojiValidation(message: message, messageFn: messageFn),
    );
  }

  /// Validates that the string is a valid UUID.
  StringValidator uuid({String? message, String? Function()? messageFn}) {
    return _copyWith(
      StringUuidValidation(message: message, messageFn: messageFn),
    );
  }

  /// Validates that the string is a valid CUID.
  StringValidator cuid({String? message, String? Function()? messageFn}) {
    return _copyWith(
      StringCuidValidation(message: message, messageFn: messageFn),
    );
  }

  /// Validates that the string is a valid CUID2.
  StringValidator cuid2({String? message, String? Function()? messageFn}) {
    return _copyWith(
      StringCuid2Validation(message: message, messageFn: messageFn),
    );
  }

  /// Validates that the string is an ip with optional parameter for IPv4 and IPv6 as "v4" and "v6" respectively.
  StringValidator ip({
    String? message,
    String? Function()? messageFn,
    IpVersion? version,
  }) {
    return _copyWith(
      StringIpValidation(
        message: message,
        messageFn: messageFn,
        version: version,
      ),
    );
  }

  /// Validates that the string matches a regular expression.
  StringValidator regex(
    String pattern, {
    String? message,
    String? Function()? messageFn,
  }) {
    return _copyWith(
      StringRegexValidation(pattern, message: message, messageFn: messageFn),
    );
  }

  /// Validates that the string starts with a string.
  StringValidator startsWith(
    String string, {
    String? message,
    String? Function()? messageFn,
  }) {
    return _copyWith(
      StringStartsWithValidation(
        string,
        message: message,
        messageFn: messageFn,
      ),
    );
  }

  /// Validates that the string ends with a string.
  StringValidator endsWith(
    String string, {
    String? message,
    String? Function()? messageFn,
  }) {
    return _copyWith(
      StringEndsWithValidation(string, message: message, messageFn: messageFn),
    );
  }

  /// Validates that the string contains a string.
  StringValidator contains(
    String string, {
    String? message,
    String? Function()? messageFn,
  }) {
    return _copyWith(
      StringContainsValidation(string, message: message, messageFn: messageFn),
    );
  }
}
