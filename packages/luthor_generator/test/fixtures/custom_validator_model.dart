import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'custom_validator_model.freezed.dart';
part 'custom_validator_model.g.dart';

bool customValidatorFn(Object? value) {
  return value == 'valid';
}

String customErrorMessage() {
  return 'Value must be "valid"';
}

bool schemaValidatorFn(Object? value, Map<String, Object?> data) {
  return value == data['matchField'];
}

@luthor
@freezed
abstract class CustomValidatorModel with _$CustomValidatorModel {
  const factory CustomValidatorModel({
    @WithCustomValidator(customValidatorFn, messageFn: customErrorMessage)
    required String customField,
    required String matchField,
    @WithSchemaCustomValidator(schemaValidatorFn, message: 'Fields must match')
    required String confirmField,
  }) = _CustomValidatorModel;

  factory CustomValidatorModel.fromJson(Map<String, dynamic> json) =>
      _$CustomValidatorModelFromJson(json);
}
