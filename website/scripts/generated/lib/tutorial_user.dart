import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'tutorial_user.freezed.dart';
part 'tutorial_user.g.dart';

@luthor
@freezed
abstract class User with _$User {
  const factory User({
    @HasMin(2) required String name,
    @IsEmail() required String email,
    @HasMin(18) int? age,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
