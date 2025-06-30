import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';
import 'package:luthor_generator_example/sample.dart';

part 'another_sample.freezed.dart';

part 'another_sample.g.dart';

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
    required Sample sample,
    Sample? optionalSample,
  }) = _AnotherSample;

  factory AnotherSample.fromJson(Map<String, dynamic> json) =>
      _$AnotherSampleFromJson(json);
}

void main() {
  final json = {'id': 0};
  final result = $AnotherSampleValidate(json);
  switch (result) {
    case SchemaValidationSuccess(data: final data):
      print(data.validateSelf());
    case SchemaValidationError(errors: final errors):
      print(errors);
  }
}
