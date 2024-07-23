import 'package:luthor/src/validation.dart';

class AnyValidation extends Validation {
  AnyValidation();

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    return true;
  }

  @override
  String get message =>
      throw StateError('AnyValidation does not have a message');

  @override
  Map<String, List<String>>? get errors => null;

  @override
  String toString() => 'AnyValidation{}';

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'any',
    };
  }
}
