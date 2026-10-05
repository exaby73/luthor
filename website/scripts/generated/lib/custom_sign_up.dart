import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'custom_sign_up.freezed.dart';
part 'custom_sign_up.g.dart';

bool matchesPassword(String value, SchemaData data) =>
    value == data['password'];

@luthor
@freezed
abstract class SignUp with _$SignUp {
  const factory SignUp({
    @HasMin(8) required String password,
    @WithSchemaCustomValidator(matchesPassword, message: 'Passwords must match')
    required String confirm,
  }) = _SignUp;

  factory SignUp.fromJson(Map<String, dynamic> json) => _$SignUpFromJson(json);
}
