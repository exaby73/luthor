import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'list_model.freezed.dart';
part 'list_model.g.dart';

@luthor
@freezed
abstract class ListModel with _$ListModel {
  const factory ListModel({
    required List<String> stringList,
    required List<int> intList,
    List<String>? optionalList,
  }) = _ListModel;

  factory ListModel.fromJson(Map<String, dynamic> json) =>
      _$ListModelFromJson(json);
}
