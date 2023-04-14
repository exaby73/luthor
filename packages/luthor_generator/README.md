# luthor_generator

`luthor_generator` is a package allowing you to generate luthor schemas with
code generation. It is a companion to
the [`luthor`](https://pub.dev/packages/luthor) package, and is built to work
with `freezed`.

## Usage

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';
import 'package:luthor_annotation/luthor_annotation.dart';

part 'sample.freezed.dart';

part 'sample.g.dart';

part 'sample.luthor.dart';

@luthor
@freezed
class Sample
    with _$Sample {
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
    @HasLength(10) String? exactly10Characters,
    @HasMin(8) @HasMax(200) required String minAndMax,
    @IsUri(allowedSchemes: ['https']) String? httpsLink,
  }) = _Sample;

  factory Sample.fromJson(Map<String, dynamic> json) => _$SampleFromJson(json);
}

// Generates

Validator sampleSchema = l.schema({
  'anyValue': l.any(),
  'boolValue': l.bool().required(),
  'doubleValue': l.double().required(),
  'intValue': l.int().required(),
  'listValue': l.list(validators: [l.string()]).required(),
  'numValue': l.number().required(),
  'stringValue': l.string().required(),
  'email': l.string().email().required(),
  'date': l.string().dateTime().required(),
  'exactly10Characters': l.string().length(10),
  'minAndMax': l.string().max(200).min(8).required(),
  'httpsLink': l.string().uri(allowedSchemes: ['https']),
});
```