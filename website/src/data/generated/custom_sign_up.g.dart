// ignore: constant_identifier_names
const SignUpSchemaKeys = (password: "password", confirm: "confirm");

final SchemaValidator $SignUpSchema = l
    .schema({
      SignUpSchemaKeys.password: l.string().min(8).required(),
      SignUpSchemaKeys.confirm: l
          .string()
          .customWithSchema(matchesPassword, message: "Passwords must match")
          .required(),
    })
    .withName("SignUp");

ValidationResult<SignUp> $SignUpValidate(Object? json) =>
    $SignUpSchema.validateSchema(json, fromJson: SignUp.fromJson);

extension SignUpValidationExtension on SignUp {
  ValidationResult<SignUp> validateSelf() =>
      $SignUpValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const SignUpErrorKeys = (password: "password", confirm: "confirm");
