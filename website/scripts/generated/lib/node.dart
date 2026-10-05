import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'node.freezed.dart';
part 'node.g.dart';

@luthor
@freezed
abstract class Node with _$Node {
  const factory Node({
    required String value,
    List<Node>? children,
    Node? parent,
  }) = _Node;

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
}
