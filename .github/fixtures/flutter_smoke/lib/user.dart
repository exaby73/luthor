import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'user.g.dart';

enum Role { admin, member }

@JsonSerializable()
class Address {
  const Address({required this.city});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  final String city;

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@luthor
@JsonSerializable(explicitToJson: true)
class User {
  const User({
    @isEmail required this.email,
    @HasMin(8) required this.password,
    this.nickname,
    this.role = Role.member,
    this.address,
    this.tags = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String email;
  final String password;
  final String? nickname;
  final Role role;
  final Address? address;
  final List<String> tags;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

/// Uses the generated API so `dart analyze` fails if its shape changes.
final SchemaValidator userSchema = $UserSchema;

String? firstError(Object? json) {
  final ValidationResult<User> result = $UserValidate(json);
  return result.getError(UserErrorKeys.email) ??
      result.getError(UserErrorKeys.address.$key) ??
      result.getError(UserErrorKeys.address.city);
}

bool isValidUser(User user) => user.validateSelf().isValid;
