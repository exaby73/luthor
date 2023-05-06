import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_result.freezed.dart';

/// Validation result for any single validation.
@freezed
class SingleValidationResult<T> with _$SingleValidationResult<T> {
  const factory SingleValidationResult.error(
    /// List of all errors from all validations.
    List<String> errors,
  ) = _SingleValidationResultError;

  const factory SingleValidationResult.success(
    /// The validated data (same as input data).
    T data,
  ) = _SingleValidationResultSuccess;

  const SingleValidationResult._();

  /// Returns true if the validation was successful.
  bool get isValid => maybeWhen(
        success: (_) => true,
        orElse: () => false,
      );
}

/// Validation result for a schema validation.
@freezed
class SchemaValidationResult<T> with _$SchemaValidationResult<T> {
  const factory SchemaValidationResult.error(
    /// Map of all errors from all validations.
    Map<String, dynamic> errors,
  ) = _SchemaValidationResultError;

  const factory SchemaValidationResult.success(
    /// The validated data (same as input data).
    T data,
  ) = _SchemaValidationResultSuccess;

  const SchemaValidationResult._();

  /// Returns true if the validation was successful.
  bool get isValid => maybeWhen(
        success: (_) => true,
        orElse: () => false,
      );
}
