import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'classic_class_freezed.freezed.dart';
part 'classic_class_freezed.g.dart';

@luthor
@freezed
@JsonSerializable()
class ClassicClassFreezed with _$ClassicClassFreezed {
  ClassicClassFreezed({@HasMin(3) required this.name, required this.age});

  @override
  final String name;
  @override
  final int age;

  factory ClassicClassFreezed.fromJson(Map<String, dynamic> json) =>
      _$ClassicClassFreezedFromJson(json);

  Map<String, dynamic> toJson() => _$ClassicClassFreezedToJson(this);
}
