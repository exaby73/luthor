import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given a model with constructor defaults', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_constructorDefaultsSource)).output;
    });

    test('Then defaulted fields are not required', () {
      expectOutputContains(output, 'CtorDefaultsSchemaKeys.count: l.int(),');
      expectOutputContains(output, 'CtorDefaultsSchemaKeys.label: l.string(),');
    });

    test(
      'When the validate function runs then an empty payload succeeds',
      () async {
        final results = await evaluateGenerated(_constructorDefaultsSource, {
          'empty': r'''$CtorDefaultsValidate({})''',
        });

        expect(results['empty'], 'success');
      },
    );
  });

  group('Given a freezed model with a JsonKey default value', () {
    test(
      'When the builder generates the schema then the field is optional',
      () async {
        final generation = await generateSharedPart(_jsonKeyDefaultSource);

        expectOutputContains(
          generation.output,
          'JsonKeyDefaultSchemaKeys.jk: l.string(),',
        );
      },
    );
  });

  group('Given a model with fields excluded from fromJson', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_excludedSource)).output;
    });

    test('Then the excluded fields are left out of the schema', () {
      expectOutputContains(
        output,
        'const ExcludedSchemaKeys = (kept: "kept");',
      );
      expectOutputLacks(output, 'ExcludedSchemaKeys.cache');
      expectOutputLacks(output, 'ExcludedSchemaKeys.legacy');
    });
  });
}

const _constructorDefaultsSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
@JsonSerializable()
class CtorDefaults {
  final int count;
  final String label;

  const CtorDefaults({this.count = 0, this.label = 'none'});

  factory CtorDefaults.fromJson(Map<String, dynamic> json) => CtorDefaults(
    count: json['count'] as int? ?? 0,
    label: json['label'] as String? ?? 'none',
  );

  Map<String, dynamic> toJson() => {'count': count, 'label': label};
}
''';

const _jsonKeyDefaultSource = r'''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
@freezed
abstract class JsonKeyDefault with _$JsonKeyDefault {
  const factory JsonKeyDefault({
    @JsonKey(defaultValue: 'x') required String jk,
  }) = _JsonKeyDefault;

  factory JsonKeyDefault.fromJson(Map<String, dynamic> json) =>
      _$JsonKeyDefaultFromJson(json);
}
''';

const _excludedSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

class Cache {}

@luthor
@JsonSerializable()
class Excluded {
  final String kept;
  @JsonKey(includeFromJson: false)
  final Cache? cache;
  // ignore: deprecated_member_use
  @JsonKey(ignore: true)
  final String? legacy;

  const Excluded({required this.kept, this.cache, this.legacy});

  factory Excluded.fromJson(Map<String, dynamic> json) =>
      Excluded(kept: json['kept'] as String);

  Map<String, dynamic> toJson() => {'kept': kept};
}
''';
