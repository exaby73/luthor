import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';
import 'package:luthor_annotation/luthor_annotation.dart';

part 'another_sample.freezed.dart';

part 'another_sample.g.dart';

part 'another_sample.luthor.dart';

@luthor
@freezed
class AnotherSample with _$AnotherSample {
  const factory AnotherSample({
    required int id,
    String? name,
  }) = _AnotherSample;

  static final Validator schema = _$AnotherSampleSchema;

  factory AnotherSample.fromJson(Map<String, dynamic> json) =>
      _$AnotherSampleFromJson(json);
}
