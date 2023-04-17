import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_result.freezed.dart';

@freezed
class ValidationResult<T> with _$ValidationResult<T> {
  const factory ValidationResult.error(String message) = _ValidationResultError;

  const factory ValidationResult.success(T data) = _ValidationResultSuccess;

  const ValidationResult._();

  bool get isValid => maybeWhen(
        success: (_) => true,
        orElse: () => false,
      );
}
