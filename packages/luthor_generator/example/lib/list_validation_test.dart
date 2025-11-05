import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';
import 'package:luthor_generator_example/another_sample.dart';

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

    // Test case 5: List with min length validator
    @HasMin(2) required List<String> minTwoStrings,

    // Test case 6: List with max length validator
    @HasMax(5) required List<int> maxFiveInts,

    // Test case 7: List with exact length validator
    @HasLength(3) required List<bool> exactlyThreeBools,

    // Test case 8: List with both min and max validators
    @HasMin(1) @HasMax(10) required List<double> betweenOneAndTenDoubles,
  }) = _ListValidationTest;

  factory ListValidationTest.fromJson(Map<String, dynamic> json) =>
      _$ListValidationTestFromJson(json);
}

void main() {
  print('Testing list validation with problematic types...');
}
