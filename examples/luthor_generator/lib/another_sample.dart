import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'another_sample.freezed.dart';

part 'another_sample.g.dart';

enum Role { admin, member }

@luthor
@freezed
abstract class AnotherSample with _$AnotherSample {
  const factory AnotherSample({
    required int id,
    @JsonKey(name: 'full_name') String? name,
    @IsEmail(message: "Invalid email") required String email,
    @IsIp(version: IpVersion.v4) String? ip,
    @HasMin(8) required String password,
    @Default('user') String type,
    @IsUrl(allowedSchemes: ['http', 'https']) String? url,
    @Default([Role.member]) List<Role> roles,
  }) = _AnotherSample;

  factory AnotherSample.fromJson(Map<String, dynamic> json) =>
      _$AnotherSampleFromJson(json);
}

void main() {
  final json = {
    'id': 0,
    'email': 'ada@example.com',
    'password': 'password123',
    'roles': ['admin'],
  };
  final result = $AnotherSampleValidate(json);
  switch (result) {
    case ValidationSuccess(:final data):
      print(data.validateSelf());
    case ValidationFailure(:final errors):
      print(errors);
  }
}
