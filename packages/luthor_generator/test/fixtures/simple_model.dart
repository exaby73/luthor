import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'simple_model.freezed.dart';
part 'simple_model.g.dart';

@luthor
@freezed
abstract class SimpleModel with _$SimpleModel {
  const factory SimpleModel({
    required String name,
    required int age,
    required bool isActive,
    required double score,
    String? optionalField,
  }) = _SimpleModel;

  factory SimpleModel.fromJson(Map<String, dynamic> json) =>
      _$SimpleModelFromJson(json);
}
