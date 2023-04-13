import 'package:luthor/luthor.dart';
import 'package:luthor/src/validation.dart';

class ListValidation extends Validation {
  final List<Validator>? validations;
  final String? customMessage;

  ListValidation({this.validations, String? message}) : customMessage = message;

  @override
  bool call(String? fieldName, dynamic value) {
    this.fieldName = fieldName;
    if (value is! List?) return false;
    if (value == null) return true;
    if (validations == null) return true;

    for (final validation in validations!) {
      if (!value.any((e) => validation.validate(e).isValid)) {
        return false;
      }
    }

    return true;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    final m = '${fieldName ?? 'value'} must be a list';
    if (validations == null) return m;
    return '$m or does not match the validations';
  }
}
