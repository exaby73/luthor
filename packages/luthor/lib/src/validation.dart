import 'package:meta/meta.dart';

/// Abstract class for implementing a validation.
abstract class Validation {
  /// Holds the field name of the validated value.
  String? fieldName;

  Validation();

  /// Holds the error message of the validation in case of single value validation.
  String? message;

  /// Holds the errors of the validation in case of schema validation.
  Map<String, dynamic>? errors;

  /// Validates the given value.
  @mustCallSuper
  bool call(String? fieldName, Object? value) {
    this.fieldName = fieldName;
    message = null;
    errors = null;
    return true;
  }
}
