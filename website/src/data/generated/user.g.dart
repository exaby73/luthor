// ignore: constant_identifier_names
const UserSchemaKeys = (
  name: "name",
  email: "email_address",
  age: "age",
  role: "role",
  address: "address",
);

final SchemaValidator $UserSchema = l
    .schema({
      UserSchemaKeys.name: l.string().min(2).required(),
      UserSchemaKeys.email: l.string().email().required(),
      UserSchemaKeys.age: l.int().min(18),
      UserSchemaKeys.role: l.oneOf(["admin", "member"]),
      UserSchemaKeys.address: forwardRef(() => $AddressSchema.required()),
    })
    .withName("User");

ValidationResult<User> $UserValidate(Object? json) =>
    $UserSchema.validateSchema(json, fromJson: User.fromJson);

extension UserValidationExtension on User {
  ValidationResult<User> validateSelf() =>
      $UserValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const UserErrorKeys = (
  name: "name",
  email: "email_address",
  age: "age",
  role: "role",
  address: (
    $key: "address",
    street: "address.street",
    city: "address.city",
    postcode: "address.postcode",
  ),
);

// ignore: constant_identifier_names
const AddressSchemaKeys = (
  street: "street",
  city: "city",
  postcode: "postcode",
);

final SchemaValidator $AddressSchema = l
    .schema({
      AddressSchemaKeys.street: l.string().required(),
      AddressSchemaKeys.city: l.string().required(),
      AddressSchemaKeys.postcode: l
          .string()
          .regex(RegExp(r'^\d{5}$'))
          .required(),
    })
    .withName("Address");

ValidationResult<Address> $AddressValidate(Object? json) =>
    $AddressSchema.validateSchema(json, fromJson: Address.fromJson);

extension AddressValidationExtension on Address {
  ValidationResult<Address> validateSelf() =>
      $AddressValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const AddressErrorKeys = (street: "street", city: "city", postcode: "postcode");
