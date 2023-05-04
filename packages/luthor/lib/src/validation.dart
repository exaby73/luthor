import 'package:freezed_annotation/freezed_annotation.dart';

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
