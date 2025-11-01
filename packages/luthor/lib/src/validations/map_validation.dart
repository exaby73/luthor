import 'package:luthor/luthor.dart';

class MapValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;
  final ValidatorReference? keyValidator;
  final ValidatorReference? valueValidator;
  Map<String, dynamic>? _failedMessage;

  MapValidation({
    String? message,
    String? Function()? messageFn,
    this.keyValidator,
    this.valueValidator,
  }) : customMessage = message,
       customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    _failedMessage = null;

    if (value == null) return true;
    if (value is! Map) {
      // Set message for single validation error format
      final msg =
          customMessage ??
          customMessageFn?.call() ??
          '${fieldName ?? 'value'} must be a Map';
      message = msg;
      _failedMessage = {
        fieldName ?? '[DEFAULT]': [msg],
      };
      return false;
    }

    // If no validators specified, just check it's a Map
    if (keyValidator == null && valueValidator == null) {
      return true;
    }

    // Validate keys if keyValidator is provided
    if (keyValidator != null) {
      final keyVal = keyValidator!.resolve();
      for (final key in value.keys) {
        final keyResult = keyVal.validateValue(key);
        if (keyResult case SingleValidationError(errors: final errors)) {
          _failedMessage ??= {};
          // Nest key errors under 'keys' to avoid collisions with map keys
          final keysMap =
              _failedMessage!.putIfAbsent('keys', () => <String, dynamic>{})
                  as Map<String, dynamic>;
          final keyErrors =
              keysMap.putIfAbsent(key.toString(), () => <String>[])
                  as List<String>;
          keyErrors.addAll(errors);
        }
      }
    }

    // Validate values if valueValidator is provided
    if (valueValidator != null) {
      final valVal = valueValidator!.resolve();
      for (final entry in value.entries) {
        final valueResult = valVal.validateValue(entry.value);
        if (valueResult case SingleValidationError(errors: final errors)) {
          _failedMessage ??= {};
          // Nest value errors under 'values' to avoid collisions with map keys
          final valuesMap =
              _failedMessage!.putIfAbsent('values', () => <String, dynamic>{})
                  as Map<String, dynamic>;
          final valueErrors =
              valuesMap.putIfAbsent(entry.key.toString(), () => <String>[])
                  as List<String>;
          valueErrors.addAll(errors);
        }
      }
    }

    return _failedMessage == null;
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must be a Map';

  @override
  Map<String, dynamic>? get errors => _failedMessage;
}
