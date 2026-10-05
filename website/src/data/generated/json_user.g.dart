// ignore: constant_identifier_names
const UserSchemaKeys = (fullName: "full_name", email: "email", age: "age");

final SchemaValidator $UserSchema = l
    .schema({
      UserSchemaKeys.fullName: l.string().min(2).required(),
      UserSchemaKeys.email: l.string().email().required(),
      UserSchemaKeys.age: l.int().min(18),
    })
    .withName("User");

ValidationResult<User> $UserValidate(Object? json) =>
    $UserSchema.validateSchema(json, fromJson: User.fromJson);

extension UserValidationExtension on User {
  ValidationResult<User> validateSelf() =>
      $UserValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const UserErrorKeys = (fullName: "full_name", email: "email", age: "age");
