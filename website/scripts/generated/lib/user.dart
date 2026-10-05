import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum Role { admin, member }

@luthor
@freezed
abstract class User with _$User {
  const factory User({
    @HasMin(2) required String name,
    @IsEmail() @JsonKey(name: 'email_address') required String email,
    @HasMin(18) int? age,
    @Default(Role.member) Role role,
    required Address address,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@luthor
@freezed
abstract class Address with _$Address {
  const factory Address({
    required String street,
    required String city,
    @MatchRegex(r'^\d{5}$') required String postcode,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}
