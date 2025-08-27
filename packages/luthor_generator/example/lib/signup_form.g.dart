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

Validator $SignupFormSchema = l.withName('SignupForm').schema({
  SignupFormSchemaKeys.email: l.string().email().required(),
  SignupFormSchemaKeys.password: l.string().min(8).required(),
  SignupFormSchemaKeys.confirmPassword: l
      .string()
      .customWithSchema(passwordsMatch, message: 'Passwords must match')
      .required(),
  SignupFormSchemaKeys.minAge: l.int().required(),
  SignupFormSchemaKeys.maxAge: l.int()
      .customWithSchema(
        isGreaterThanMinAge,
        message: 'Max age must be greater than min age',
      )
      .required(),
});

SchemaValidationResult<SignupForm> $SignupFormValidate(
  Map<String, dynamic> json,
) => $SignupFormSchema.validateSchema(json, fromJson: SignupForm.fromJson);

extension SignupFormValidationExtension on SignupForm {
  SchemaValidationResult<SignupForm> validateSelf() =>
      $SignupFormValidate(toJson());
}

// ignore: constant_identifier_names
const SignupFormErrorKeys = (
  email: "email",
  password: "password",
  confirmPassword: "confirmPassword",
  minAge: "minAge",
  maxAge: "maxAge",
);
