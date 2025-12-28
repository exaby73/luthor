import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'json_key_model.freezed.dart';
part 'json_key_model.g.dart';

@luthor
@freezed
abstract class JsonKeyModel with _$JsonKeyModel {
  const factory JsonKeyModel({
    @JsonKey(name: 'user_name') required String userName,
    @JsonKey(name: 'user_email') @IsEmail() required String userEmail,
    required String normalField,
  }) = _JsonKeyModel;

  factory JsonKeyModel.fromJson(Map<String, dynamic> json) =>
      _$JsonKeyModelFromJson(json);
}
