import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'strict_example.g.dart';

@Luthor(unknownKeys: .strict)
@JsonSerializable()
class Invite {
  const Invite({@isEmail required this.email, this.note});

  final String email;
  final String? note;

  factory Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);

  Map<String, dynamic> toJson() => _$InviteToJson(this);
}

void main() {
  final valid = $InviteValidate({'email': 'ada@example.com'});
  print(valid.isValid);

  final invalid = $InviteValidate({'email': 'ada@example.com', 'emial': 'x'});
  print(invalid.errors);
}
