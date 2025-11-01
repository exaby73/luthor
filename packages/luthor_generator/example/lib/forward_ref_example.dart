import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'forward_ref_example.freezed.dart';
part 'forward_ref_example.g.dart';

@luthor
@freezed
abstract class Node with _$Node {
  const factory Node({required String value, List<Node>? children}) = _Node;

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
}

void main() {
  // Test self-referential schema
  final data = {
    'value': 'root',
    'children': [
      {
        'value': 'child1',
        'children': [
          {'value': 'grandchild', 'children': null},
        ],
      },
      {'value': 'child2', 'children': null},
    ],
  };

  final result = $NodeValidate(data);
  switch (result) {
    case SchemaValidationError(errors: final errors):
      print('Validation failed:');
      errors.forEach((key, value) {
        print('$key: $value');
      });
    case SchemaValidationSuccess(data: final data):
      print('Validation succeeded!');
      print('Node value: ${data.value}');
      print('Children count: ${data.children?.length ?? 0}');
  }
}
