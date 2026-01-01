import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';
import 'simple_model.dart';

part 'nested_model.freezed.dart';
part 'nested_model.g.dart';

@luthor
@freezed
abstract class NestedModel with _$NestedModel {
  const factory NestedModel({
    required String id,
    required SimpleModel user,
    SimpleModel? optionalUser,
  }) = _NestedModel;

  factory NestedModel.fromJson(Map<String, dynamic> json) =>
      _$NestedModelFromJson(json);
}
