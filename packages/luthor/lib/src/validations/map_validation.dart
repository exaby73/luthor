import 'package:luthor/src/validation.dart';

class MapValidation extends Validation {
  String? customMessage;

  MapValidation({
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return value is Map?;
  }

  @override
  String get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a Map';

  @override
  Map<String, List<String>>? get errors => null;
}
