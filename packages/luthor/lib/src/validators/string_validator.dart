import 'package:luthor/luthor.dart';
import 'package:luthor/src/validations/strings/string_url_validation.dart';

/// Validator for strings.
class StringValidator extends Validator {
  StringValidator({super.initialValidations});

  /// Validates that the string is a valid date.
  StringValidator dateTime({String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(StringDateTimeValidation(message: message));
    final newValidator = StringValidator(initialValidations: newValidations);
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the string is a valid email.
  StringValidator email({String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(StringEmailValidation(message: message));
    final newValidator = StringValidator(initialValidations: newValidations);
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the string has a minimum character length.
  StringValidator min(int minLength, {String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(StringMinValidation(minLength: minLength, message: message));
    final newValidator = StringValidator(initialValidations: newValidations);
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the string has a maximum character length.
  StringValidator max(int maxLength, {String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(StringMaxValidation(maxLength: maxLength, message: message));
    final newValidator = StringValidator(initialValidations: newValidations);
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the string has a specific character length.
  StringValidator length(int length, {String? message}) {
    final newValidations = List<Validation>.from(validations)
      ..add(StringLengthValidation(length: length, message: message));
    final newValidator = StringValidator(initialValidations: newValidations);
    if (name != null) {
      newValidator.withName(name);
    }
    return newValidator;
  }

  /// Validates that the string is a valid URI.
  StringValidator uri({List<String>? allowedSchemes, String? message}) {
    validations.add(
      StringUriValidation(allowedSchemes: allowedSchemes, message: message),
    );
    return this;
  }

  /// Validates that the string is a valid URL (must have scheme and host).
  StringValidator url({List<String>? allowedSchemes, String? message}) {
    validations.add(
      StringUrlValidation(allowedSchemes: allowedSchemes, message: message),
    );
    return this;
  }

  /// Validates that the string is a valid emoji.
  StringValidator emoji({String? message}) {
    validations.add(StringEmojiValidation(message: message));
    return this;
  }

  /// Validates that the string is a valid UUID.
  StringValidator uuid({String? message}) {
    validations.add(StringUuidValidation(message: message));
    return this;
  }

  /// Validates that the string is a valid CUID.
  StringValidator cuid({String? message}) {
    validations.add(StringCuidValidation(message: message));
    return this;
  }

  /// Validates that the string is a valid CUID2.
  StringValidator cuid2({String? message}) {
    validations.add(StringCuid2Validation(message: message));
    return this;
  }

  /// Validates that the string is an ip with optional parameter for IPv4 and IPv6 as "v4" and "v6" respectively.
  StringValidator ip({String? message, IpVersion? version}) {
    validations.add(
      StringIpValidation(customMessage: message, version: version),
    );
    return this;
  }

  /// Validates that the string matches a regular expression.
  StringValidator regex(String pattern, {String? message}) {
    validations.add(StringRegexValidation(pattern, message: message));
    return this;
  }

  /// Validates that the string starts with a string.
  StringValidator startsWith(String string, {String? message}) {
    validations.add(StringStartsWithValidation(string, message: message));
    return this;
  }

  /// Validates that the string ends with a string.
  StringValidator endsWith(String string, {String? message}) {
    validations.add(StringEndsWithValidation(string, message: message));
    return this;
  }

  /// Validates that the string contains a string.
  StringValidator contains(String string, {String? message}) {
    validations.add(StringContainsValidation(string, message: message));
    return this;
  }
}
