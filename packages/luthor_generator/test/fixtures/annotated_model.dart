import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'annotated_model.freezed.dart';
part 'annotated_model.g.dart';

@luthor
@freezed
abstract class AnnotatedModel with _$AnnotatedModel {
  const factory AnnotatedModel({
    @IsEmail() required String email,
    @HasMin(8) @HasMax(100) required String password,
    @HasMin(18) @HasMax(120) required int age,
    @HasMinDouble(0.0) @HasMaxDouble(100.0) required double score,
    @StartsWith('https://') String? website,
    @EndsWith('.com') String? domain,
    @Contains('test') String? testField,
    @IsUuid() required String uuid,
  }) = _AnnotatedModel;

  factory AnnotatedModel.fromJson(Map<String, dynamic> json) =>
      _$AnnotatedModelFromJson(json);
}
