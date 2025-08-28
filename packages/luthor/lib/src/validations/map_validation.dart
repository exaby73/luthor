import 'package:luthor/src/validation.dart';

class MapValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;

  MapValidation({String? message, String? Function()? messageFn})
    : customMessage = message,
      customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value is Map?;
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must be a Map';

  @override
  Map<String, List<String>>? get errors => null;
}
