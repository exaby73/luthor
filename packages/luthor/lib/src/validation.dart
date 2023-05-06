import 'package:freezed_annotation/freezed_annotation.dart';

/// Abstract class for implementing a validation.
abstract class Validation {
  String? fieldName;

  Validation();

  String? message;
  Map<String, dynamic>? errors;

  @mustCallSuper
  bool call(String? fieldName, Object? value) {
    this.fieldName = fieldName;
    message = null;
    errors = null;
    return true;
  }
}
