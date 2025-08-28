import 'package:luthor/luthor.dart';

class ListValidation extends Validation {
  final List<Validator>? validators;
  final String? customMessage;
  String? Function()? customMessageFn;

  ListValidation({
    this.validators,
    String? message,
    String? Function()? messageFn,
  }) : customMessage = message,
       customMessageFn = messageFn;

  bool _isValid(Validator validation, dynamic e) {
    if (e is Map<String, Object?>) {
      return validation.validateSchema(e).isValid;
    }

    return validation.validateValue(e).isValid;
  }

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value is! List?) return false;
    if (value == null) return true;
    if (validators == null) return true;

    for (final e in value) {
      if (!validators!.any((v) => _isValid(v, e))) {
        return false;
      }
    }

    return true;
  }

  @override
  String get message {
    if (customMessage != null) return customMessage!;
    if (customMessageFn != null) {
      final m = customMessageFn!();
      if (m != null) return m;
    }
    final m = '${fieldName ?? 'value'} must be a list';
    if (validators == null) return m;
    return '$m or does not match the validations';
  }

  @override
  Map<String, List<String>>? get errors => null;
}
