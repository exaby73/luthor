// ignore_for_file: invalid_annotation_target

import 'package:example/another_sample.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'sample.freezed.dart';

part 'sample.g.dart';

bool customValidatorFn(Object? value) {
  return value == 'custom';
}

@luthor
@freezed
abstract class Sample with _$Sample {
  const factory Sample({
    dynamic anyValue,
    required bool boolValue,
    required double doubleValue,
    required int intValue,
    required List<String> listValue,
    // The following will work with luthor_generator, but not with json_serializable
    // Null? nullValue,
    required num numValue,
    required String stringValue,
    @isEmail required String email,
    @isDateTime required String date,
    required DateTime dateTime,
    @HasLength(10) String? exactly10Characters,
    @HasMin(8) @HasMax(200) required String minAndMaxString,
    @StartsWith('foo') required String startsWithFoo,
    @EndsWith('bar') required String endsWithBar,
    @Contains('baz') required String containsBaz,
    @HasMin(2) @HasMax(4) required int minAndMaxInt,
    @HasMinDouble(2.0) @HasMaxDouble(4.0) required double minAndMaxDouble,
    @HasMinNumber(2) @HasMaxNumber(3.0) required num minAndMaxNumber,
    @IsUri(allowedSchemes: ['https']) String? httpsLink,
    @IsUrl() String? aUrl,
    @MatchRegex(r'^https:\/\/pub\.dev\/packages\/luthor')
    required String luthorPath,
    required AnotherSample anotherSample,
    @JsonKey(name: 'jsonKeyName') required String foo,
    @WithCustomValidator(customValidatorFn) required String custom,
    required List<int> numbers,
    String? hello,
  }) = _Sample;

  factory Sample.fromJson(Map<String, dynamic> json) => _$SampleFromJson(json);
}

void main() {
  final result = $SampleValidate({});
  switch (result) {
    case SchemaValidationError(errors: final errors):
      print('Error: ');
      errors.forEach((key, value) {
        print('$key: $value');
      });
    case SchemaValidationSuccess(data: final data):
      print('Success: $data');
      data.validateSelf();
  }

  print('*' * 10);
  final result2 = $SampleValidate({
    "minAndMaxInt": 1,
    "minAndMaxDouble": 1.0,
    "minAndMaxNumber": 1,
    "custom": 'custom',
  });
  switch (result2) {
    case SchemaValidationError(errors: final errors):
      print('Error: Result 2');
      errors.forEach((key, value) {
        print('$key: $value');
      });
    case SchemaValidationSuccess(data: final data):
      print('Success: $data');
      data.validateSelf();
  }

  print('*' * 10);
  final result3 = $SampleValidate({
    "minAndMaxInt": 5,
    "minAndMaxDouble": 5.0,
    "minAndMaxNumber": 5,
    "custom": 1,
  });
  switch (result3) {
    case SchemaValidationError(errors: final errors):
      print('Error: Result 3');
      errors.forEach((key, value) {
        print('$key: $value');
      });
    case SchemaValidationSuccess(data: final data):
      print('Success: $data');
      data.validateSelf();
  }
}
