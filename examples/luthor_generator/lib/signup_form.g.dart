// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignupForm _$SignupFormFromJson(Map<String, dynamic> json) => _SignupForm(
  email: json['email'] as String,
  password: json['password'] as String,
  confirmPassword: json['confirmPassword'] as String,
  minAge: (json['minAge'] as num).toInt(),
  maxAge: (json['maxAge'] as num).toInt(),
);

Map<String, dynamic> _$SignupFormToJson(_SignupForm instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'minAge': instance.minAge,
      'maxAge': instance.maxAge,
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const SignupFormSchemaKeys = (
  email: "email",
  password: "password",
  confirmPassword: "confirmPassword",
  minAge: "minAge",
  maxAge: "maxAge",
);

final SchemaValidator $SignupFormSchema = l
    .schema({
      SignupFormSchemaKeys.email: l.string().email().required(),
      SignupFormSchemaKeys.password: l.string().min(8).required(),
      SignupFormSchemaKeys.confirmPassword: l
          .string()
          .customWithSchema(passwordsMatch, message: "Passwords must match")
          .required(),
      SignupFormSchemaKeys.minAge: l.int().required(),
      SignupFormSchemaKeys.maxAge: l.int()
          .customWithSchema(
            isGreaterThanMinAge,
            message: "Max age must be greater than min age",
          )
          .required(),
    })
    .withName("SignupForm");

ValidationResult<SignupForm> $SignupFormValidate(Object? json) =>
    $SignupFormSchema.validateSchema(json, fromJson: SignupForm.fromJson);

extension SignupFormValidationExtension on SignupForm {
  ValidationResult<SignupForm> validateSelf() =>
      $SignupFormValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const SignupFormErrorKeys = (
  email: "email",
  password: "password",
  confirmPassword: "confirmPassword",
  minAge: "minAge",
  maxAge: "maxAge",
);

Map<String, Object?> _$luthorJsonMap(Map<Object?, Object?> map) => {
  for (final entry in map.entries)
    entry.key.toString(): _$luthorJsonValue(entry.value),
};

Object? _$luthorJsonValue(Object? value) {
  if (value == null || value is String || value is num || value is bool) {
    return value;
  }
  if (value is Map) return _$luthorJsonMap(value);
  if (value is Iterable) {
    return [for (final item in value) _$luthorJsonValue(item)];
  }
  try {
    // ignore: avoid_dynamic_calls
    return _$luthorJsonValue((value as dynamic).toJson());
    // ignore: avoid_catching_errors
  } on NoSuchMethodError {
    return value;
  }
}
