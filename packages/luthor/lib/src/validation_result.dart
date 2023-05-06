import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_result.freezed.dart';

/// Validation result for any single validation.
@freezed
class SingleValidationResult<T> with _$SingleValidationResult<T> {
  const factory SingleValidationResult.error(List<String> errors) =
      _SingleValidationResultError;

  const factory SingleValidationResult.success(T data) =
      _SingleValidationResultSuccess;

  const SingleValidationResult._();

  bool get isValid => maybeWhen(
        success: (_) => true,
        orElse: () => false,
      );
}

/// Validation result for a schema validation.
@freezed
class SchemaValidationResult<T> with _$SchemaValidationResult<T> {
  const factory SchemaValidationResult.error(Map<String, dynamic> errors) =
      _SchemaValidationResultError;

  const factory SchemaValidationResult.success(T data) =
      _SchemaValidationResultSuccess;

  const SchemaValidationResult._();

  bool get isValid => maybeWhen(
        success: (_) => true,
        orElse: () => false,
      );
}
