// ignore: constant_identifier_names
const RegistrationSchemaKeys = (
  name: "name",
  email: "email_address",
  password: "password",
  confirm: "confirm",
  accountType: "accountType",
  phone: "phone",
  age: "age",
  address: "address",
);

final SchemaValidator $RegistrationSchema = l
    .schema({
      RegistrationSchemaKeys.name: l.string().min(2).max(50).required(),
      RegistrationSchemaKeys.email: l.string().email().required(),
      RegistrationSchemaKeys.password: l.string().min(8).required(),
      RegistrationSchemaKeys.confirm: l
          .string()
          .customWithSchema(matchesPassword, message: "Passwords must match")
          .required(),
      RegistrationSchemaKeys.accountType: l
          .string()
          .customWithSchema(
            phoneForBusiness,
            message: "A business account needs a phone number",
          )
          .required(),
      RegistrationSchemaKeys.phone: l.string(),
      RegistrationSchemaKeys.age: l.int().min(18).required(),
      RegistrationSchemaKeys.address: forwardRef(
        () => $AddressSchema.required(),
      ),
    })
    .withName("Registration");

ValidationResult<Registration> $RegistrationValidate(Object? json) =>
    $RegistrationSchema.validateSchema(json, fromJson: Registration.fromJson);

extension RegistrationValidationExtension on Registration {
  ValidationResult<Registration> validateSelf() =>
      $RegistrationValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const RegistrationErrorKeys = (
  name: "name",
  email: "email_address",
  password: "password",
  confirm: "confirm",
  accountType: "accountType",
  phone: "phone",
  age: "age",
  address: (
    $key: "address",
    street: "address.street",
    city: "address.city",
    postcode: "address.postcode",
  ),
);

// ignore: constant_identifier_names
const SignUpSchemaKeys = (
  name: "name",
  email: "email",
  password: "password",
  confirm: "confirm",
  age: "age",
  website: "website",
  accountType: "accountType",
);

final SchemaValidator $SignUpSchema = l
    .schema({
      SignUpSchemaKeys.name: l.string().min(2).max(50).required(),
      SignUpSchemaKeys.email: l.string().email().required(),
      SignUpSchemaKeys.password: l.string().min(8).required(),
      SignUpSchemaKeys.confirm: l
          .string()
          .customWithSchema(matchesPassword, message: "Passwords must match")
          .required(),
      SignUpSchemaKeys.age: l.int().min(18),
      SignUpSchemaKeys.website: l.string().url(allowedSchemes: ["https"]),
      SignUpSchemaKeys.accountType: l.oneOf(["personal", "business"]),
    })
    .withName("SignUp");

ValidationResult<SignUp> $SignUpValidate(Object? json) =>
    $SignUpSchema.validateSchema(json, fromJson: SignUp.fromJson);

extension SignUpValidationExtension on SignUp {
  ValidationResult<SignUp> validateSelf() =>
      $SignUpValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const SignUpErrorKeys = (
  name: "name",
  email: "email",
  password: "password",
  confirm: "confirm",
  age: "age",
  website: "website",
  accountType: "accountType",
);
