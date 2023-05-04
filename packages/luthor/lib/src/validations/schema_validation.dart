import 'package:luthor/src/validation.dart';
import 'package:luthor/src/validator.dart';

class SchemaValidation extends Validation {
  Map<String, dynamic>? failedMessage;
  final Map<String, Validator> validatorSchema;

  SchemaValidation(this.validatorSchema);

  @override
  bool call(String? fieldName, covariant Map<String, dynamic> value) {
    super.call(fieldName, value);

    for (final entry in validatorSchema.entries) {
      final name = entry.key;
      final validator = entry.value;
      final fieldValue = value[name];

      if (fieldValue is Map<String, Object?>) {
        final result = validator.validateSchemaWithFieldName(name, fieldValue);

        if (!result.isValid) {
          failedMessage ??= {};
          (failedMessage!.putIfAbsent(name, () => {}) as Map).addAll(
            result.whenOrNull(
                  error: (errors) => errors,
                ) ??
                {},
          );
        }
      } else {
        failedMessage ??= {};
        final result = validator.validateValueWithFieldName(name, fieldValue);

        if (!result.isValid) {
          failedMessage ??= {};
          (failedMessage!.putIfAbsent(name, () => []) as List).addAll(
            result.whenOrNull(
                  error: (errors) => errors,
                ) ??
                [],
          );
        }
      }
    }

    return failedMessage == null;
  }

  @override
  Map<String, dynamic> get errors => failedMessage!;

  @override
  String? get message => null;
}
