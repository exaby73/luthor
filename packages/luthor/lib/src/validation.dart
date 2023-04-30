import 'package:freezed_annotation/freezed_annotation.dart';

abstract class Validation {
  String? fieldName;

  Validation();

  String? get message;
  Map<String, dynamic>? get errors;

  @mustCallSuper
  bool call(String? fieldName, Object? value) {
    this.fieldName = fieldName;
    return true;
  }
}
