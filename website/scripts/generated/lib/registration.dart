import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

import 'user.dart';

part 'registration.freezed.dart';
part 'registration.g.dart';

bool matchesPassword(String value, SchemaData data) =>
    value == data['password'];

/// A business account needs a phone number. The rule sits on `accountType`
/// because that field is always present; a missing optional `phone` is never
/// validated.
bool phoneForBusiness(String value, SchemaData data) {
  if (value != 'business') return true;
  final phone = data['phone'];
  return phone is String && phone.isNotEmpty;
}

enum AccountType { personal, business }

@luthor
@freezed
abstract class Registration with _$Registration {
  const factory Registration({
    @HasMin(2) @HasMax(50) required String name,
    @IsEmail() @JsonKey(name: 'email_address') required String email,
    @HasMin(8) required String password,
    @WithSchemaCustomValidator(matchesPassword, message: 'Passwords must match')
    required String confirm,
    @WithSchemaCustomValidator(
      phoneForBusiness,
      message: 'A business account needs a phone number',
    )
    required String accountType,
    String? phone,
    @HasMin(18) required int age,
    required Address address,
  }) = _Registration;

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);
}

@luthor
@freezed
abstract class SignUp with _$SignUp {
  const factory SignUp({
    @HasMin(2) @HasMax(50) required String name,
    @IsEmail() required String email,
    @HasMin(8) required String password,
    @WithSchemaCustomValidator(matchesPassword, message: 'Passwords must match')
    required String confirm,
    @HasMin(18) int? age,
    @IsUrl(allowedSchemes: ['https']) String? website,
    @Default(AccountType.personal) AccountType accountType,
  }) = _SignUp;

  factory SignUp.fromJson(Map<String, dynamic> json) => _$SignUpFromJson(json);
}
