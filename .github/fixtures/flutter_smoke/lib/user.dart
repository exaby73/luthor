import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'user.g.dart';

@luthor
@JsonSerializable()
class User {
  const User({
    @isEmail required this.email,
    @HasMin(8) required this.password,
    this.nickname,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String email;
  final String password;
  final String? nickname;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

/// Uses the generated API so `dart analyze` fails if its shape changes.
bool isValidUser(Map<String, dynamic> json) => $UserValidate(json).isValid;
