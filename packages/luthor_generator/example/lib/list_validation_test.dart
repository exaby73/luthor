import 'package:example/another_sample.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'list_validation_test.freezed.dart';
part 'list_validation_test.g.dart';

@luthor
@freezed
abstract class ListValidationTest with _$ListValidationTest {
  const factory ListValidationTest({
    // Test case 1: List with nullable primitive types
    required List<String?> nullableStrings,
    required List<int?> nullableInts,
    
    // Test case 2: List with custom objects
    required List<AnotherSample> customObjects,
    
    // Test case 3: List with nullable custom objects
    required List<AnotherSample?> nullableCustomObjects,
    
    // Test case 4: Optional lists with nullable elements
    List<String?>? optionalNullableStrings,
  }) = _ListValidationTest;

  factory ListValidationTest.fromJson(Map<String, dynamic> json) =>
      _$ListValidationTestFromJson(json);
}

void main() {
  print('Testing list validation with problematic types...');
}