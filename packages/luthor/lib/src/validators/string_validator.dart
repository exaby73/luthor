import 'package:luthor/luthor.dart';
import 'package:luthor/src/validations/strings/string_url_validation.dart';

/// Validator for strings.
class StringValidator extends Validator {
  StringValidator({super.initialValidations});

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
    validations.add(
      StringUriValidation(
        allowedSchemes: allowedSchemes,
        message: message,
        messageFn: messageFn,
      ),
    );
    return this;
  }

  /// Validates that the string is a valid URL (must have scheme and host).
  StringValidator url({
    List<String>? allowedSchemes,
    String? message,
    String? Function()? messageFn,
  }) {
    validations.add(
      StringUrlValidation(
        allowedSchemes: allowedSchemes,
        message: message,
        messageFn: messageFn,
      ),
    );
    return this;
  }

  /// Validates that the string is a valid emoji.
  StringValidator emoji({String? message, String? Function()? messageFn}) {
    validations.add(
      StringEmojiValidation(message: message, messageFn: messageFn),
    );
    return this;
  }

  /// Validates that the string is a valid UUID.
  StringValidator uuid({String? message, String? Function()? messageFn}) {
    validations.add(
      StringUuidValidation(message: message, messageFn: messageFn),
    );
    return this;
  }

  /// Validates that the string is a valid CUID.
  StringValidator cuid({String? message, String? Function()? messageFn}) {
    validations.add(
      StringCuidValidation(message: message, messageFn: messageFn),
    );
    return this;
  }

  /// Validates that the string is a valid CUID2.
  StringValidator cuid2({String? message, String? Function()? messageFn}) {
    validations.add(
      StringCuid2Validation(message: message, messageFn: messageFn),
    );
    return this;
  }

  /// Validates that the string is an ip with optional parameter for IPv4 and IPv6 as "v4" and "v6" respectively.
  StringValidator ip({
    String? message,
    String? Function()? messageFn,
    IpVersion? version,
  }) {
    validations.add(
      StringIpValidation(
        message: message,
        messageFn: messageFn,
        version: version,
      ),
    );
    return this;
  }

  /// Validates that the string matches a regular expression.
  StringValidator regex(
    String pattern, {
    String? message,
    String? Function()? messageFn,
  }) {
    validations.add(
      StringRegexValidation(pattern, message: message, messageFn: messageFn),
    );
    return this;
  }

  /// Validates that the string starts with a string.
  StringValidator startsWith(
    String string, {
    String? message,
    String? Function()? messageFn,
  }) {
    validations.add(
      StringStartsWithValidation(
        string,
        message: message,
        messageFn: messageFn,
      ),
    );
    return this;
  }

  /// Validates that the string ends with a string.
  StringValidator endsWith(
    String string, {
    String? message,
    String? Function()? messageFn,
  }) {
    validations.add(
      StringEndsWithValidation(string, message: message, messageFn: messageFn),
    );
    return this;
  }

  /// Validates that the string contains a string.
  StringValidator contains(
    String string, {
    String? message,
    String? Function()? messageFn,
  }) {
    validations.add(
      StringContainsValidation(string, message: message, messageFn: messageFn),
    );
    return this;
  }
}
