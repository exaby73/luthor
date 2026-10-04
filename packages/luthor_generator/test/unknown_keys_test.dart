import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given a json_serializable model with settable fields', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_settableSource)).output;
    });

    test('Then a nullable settable field is an optional schema field', () {
      expectOutputContains(output, 'AccountSchemaKeys.note: l.string(),');
    });

    test('Then a non-nullable settable field is required', () {
      expectOutputContains(
        output,
        'AccountSchemaKeys.count: l.int().required(),',
      );
    });

    test('Then a JsonKey name renames the settable field key', () {
      expectOutputContains(output, 'label: "display_label",');
    });

    test('Then final, ignored and private fields are left out', () {
      expectOutputLacks(output, 'AccountSchemaKeys.createdBy');
      expectOutputLacks(output, 'AccountSchemaKeys.cache');
      expectOutputLacks(output, '_secret');
    });

    test('Then the schema strips unknown keys', () {
      expectOutputLacks(output, '.passthrough()');
    });

    group('When the validate function runs', () {
      late Map<String, Object?> results;

      setUpAll(() async {
        results = await evaluateGenerated(_settableSource, {
          'fields': r'''
          switch ($AccountValidate({'id': 'a', 'note': 'n', 'count': 2, 'display_label': 'L', 'extra': true})) {
            ValidationSuccess(:final data) => [data.note, data.count, data.label],
            final failure => failure.errors,
          }''',
          'missingCount': r'''$AccountValidate({'id': 'a'})''',
        });
      });

      test('Then fromJson receives every settable field', () {
        expect(results['fields'], ['n', 2, 'L']);
      });

      test('Then a missing required settable field is an error', () {
        expect(results['missingCount'], {
          'count': ['count is required'],
        });
      });
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(_settableSource);
    });
  });

  group('Given a model whose field uses JsonKey readValue', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_readValueSource)).output;
    });

    test('Then the schema keeps unknown keys', () {
      expectOutputContains(output, '}).passthrough().withName("Legacy");');
    });

    test('Then the field accepts any value and is optional', () {
      expectOutputContains(output, 'LegacySchemaKeys.name: l.any(),');
    });

    test(
      'When the validate function runs then readValue sees the other key',
      () async {
        final results = await evaluateGenerated(_readValueSource, {
          'name': r'''
          switch ($LegacyValidate({'legacy_name': 'old'})) {
            ValidationSuccess(:final data) => data.name,
            final failure => failure.errors,
          }''',
        });

        expect(results['name'], 'old');
      },
    );
  });

  group('Given a model that reads a private field from JSON', () {
    test(
      'When the builder generates the schema then it keeps unknown keys',
      () async {
        final output = (await generateSharedPart(_privateFieldSource)).output;

        expectOutputContains(output, '}).passthrough().withName("Vault");');
      },
    );
  });

  group('Given a dart_mappable model with a class hook', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_mappableHookSource)).output;
    });

    test('Then the schema keeps unknown keys', () {
      expectOutputContains(output, '}).passthrough().withName("Hooked");');
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(_mappableHookSource);
    });
  });
}

const _settableSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@JsonSerializable()
@luthor
class Account {
  final String id;
  final String createdBy = 'system';
  String? note;
  int count = 0;
  @JsonKey(name: 'display_label')
  String? label;
  @JsonKey(includeFromJson: false)
  String? cache;
  String? _secret;

  Account({required this.id});

  factory Account.fromJson(Map<String, dynamic> json) =>
      Account(id: json['id'] as String)
        ..note = json['note'] as String?
        ..count = json['count'] as int
        ..label = json['display_label'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'secret': _secret};
}
''';

const _readValueSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

Object? readName(Map<dynamic, dynamic> json, String key) =>
    json[key] ?? json['legacy_name'];

@luthor
class Legacy {
  final String name;

  const Legacy({@JsonKey(readValue: readName) required this.name});

  factory Legacy.fromJson(Map<String, dynamic> json) =>
      Legacy(name: readName(json, 'name') as String);

  Map<String, dynamic> toJson() => {'name': name};
}
''';

const _privateFieldSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@JsonSerializable()
@luthor
class Vault {
  final String id;
  @JsonKey(includeFromJson: true)
  String? _code;

  Vault({required this.id});

  factory Vault.fromJson(Map<String, dynamic> json) =>
      Vault(id: json['id'] as String).._code = json['_code'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'code': _code};
}
''';

const _mappableHookSource = '''
import 'package:dart_mappable/dart_mappable.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

class RenameHook extends MappingHook {
  const RenameHook();
}

@MappableClass(hook: RenameHook())
@luthor
class Hooked {
  final String name;

  const Hooked({required this.name});
}

class HookedMapper {
  static Hooked fromMap(Map<String, Object?> map) =>
      Hooked(name: map['name']! as String);
}

extension HookedMapperExtension on Hooked {
  Map<String, Object?> toMap() => {'name': name};
}
''';
