import 'package:luthor/luthor.dart';

part 'plain_user.g.dart';

@luthor
class User {
  const User({
    @HasMin(2) required this.name,
    @IsEmail() required this.email,
    @HasMin(18) this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json['name'] as String,
    email: json['email'] as String,
    age: json['age'] as int?,
  );

  final String name;
  final String email;
  final int? age;

  Map<String, dynamic> toJson() => {'name': name, 'email': email, 'age': age};
}
