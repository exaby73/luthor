import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'json_user.g.dart';

@luthor
@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  const User({required this.fullName, required this.email, this.age});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @HasMin(2)
  final String fullName;
  @IsEmail()
  final String email;
  @HasMin(18)
  final int? age;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
