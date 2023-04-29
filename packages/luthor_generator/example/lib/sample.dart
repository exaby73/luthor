import 'package:example/another_sample.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';
import 'package:luthor_annotation/luthor_annotation.dart';

part 'sample.freezed.dart';

part 'sample.g.dart';

part 'sample.luthor.dart';

@luthor
@freezed
class Sample with _$Sample {
  const factory Sample({
    dynamic anyValue,
    required bool boolValue,
    required double doubleValue,
    required int intValue,
    required List<String> listValue,
    // The following will work with luthor_generator, but not with json_serializable
    // Null? nullValue,
    required num numValue,
    required String stringValue,
    @isEmail required String email,
    @isDateTime required String date,
    @HasLength(10) String? exactly10Characters,
    @HasMin(8) @HasMax(200) required String minAndMax,
    @IsUri(allowedSchemes: ['https']) String? httpsLink,
    @MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor') required String luthorPath,
    required AnotherSample anotherSample,
  }) = _Sample;

  static Validator schema = _$SampleSchema;

  factory Sample.fromJson(Map<String, dynamic> json) => _$SampleFromJson(json);
}
