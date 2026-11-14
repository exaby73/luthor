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

  group('Given a model annotated with unknownKeys strict', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_strictSource)).output;
    });

    test('Then the schema is strict', () {
      expectOutputContains(output, '}).strict().withName("Strict");');
    });

    group('When the validate function runs', () {
      late Map<String, Object?> results;

      setUpAll(() async {
        results = await evaluateGenerated(_strictSource, {
          'unknown': r'''$StrictValidate({'name': 'Ada', 'role': 'admin'})''',
          'known': r'''$StrictValidate({'name': 'Ada'})''',
        });
      });

      test('Then an unknown key is an error at its path', () {
        expect(results['unknown'], {
          'role': ['role is not an allowed key'],
        });
      });

      test('Then input without unknown keys passes', () {
        expect(results['known'], 'success');
      });
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(_strictSource);
    });
  });

  group('Given a model annotated with the full UnknownKeys.strict name', () {
    test('When the builder generates the schema then it is strict', () async {
      final source = _strictSource.replaceFirst(
        'unknownKeys: .strict',
        'unknownKeys: UnknownKeys.strict',
      );

      final output = (await generateSharedPart(source)).output;

      expectOutputContains(output, '}).strict().withName("Strict");');
    });
  });

  group('Given a model annotated with a const alias of a mode', () {
    test('When the builder generates the schema then it uses the aliased '
        'mode', () async {
      final source = _strictSource.replaceFirst(
        '@Luthor(unknownKeys: .strict)',
        'const mode = UnknownKeys.strict;\n\n@Luthor(unknownKeys: mode)',
      );

      final output = (await generateSharedPart(source)).output;

      expectOutputContains(output, '}).strict().withName("Strict");');
    });
  });

  group('Given a model annotated with unknownKeys passthrough', () {
    test('When the builder generates the schema then it keeps unknown '
        'keys', () async {
      final source = _strictSource.replaceFirst('.strict', '.passthrough');

      final output = (await generateSharedPart(source)).output;

      expectOutputContains(output, '}).passthrough().withName("Strict");');
    });
  });

  group('Given a model annotated with unknownKeys strip', () {
    test('When the builder generates the schema then it emits no '
        'modifier', () async {
      final source = _strictSource.replaceFirst('.strict', '.strip');

      final output = (await generateSharedPart(source)).output;

      expectOutputContains(output, '}).withName("Strict");');
    });
  });

  group('Given a dart_mappable model annotated with unknownKeys strict', () {
    test('When the builder generates the schema then it is strict', () async {
      final output = (await generateSharedPart(_strictMappableSource)).output;

      expectOutputContains(output, '}).strict().withName("Tagged");');
    });
  });

  group('Given a strict model nested in a model without a setting', () {
    late Map<String, Object?> results;

    setUpAll(() async {
      results = await evaluateGenerated(_nestedStrictSource, {
        'child':
            r'''$OrderValidate({'address': {'city': 'Oslo', 'zip': '1'}})''',
        'parent':
            r'''$OrderValidate({'address': {'city': 'Oslo'}, 'note': 1})''',
      });
    });

    test('Then an unknown key in the strict child is an error', () {
      expect(results['child'], {
        'address.zip': ['zip is not an allowed key'],
      });
    });

    test('Then an unknown key in the parent is stripped', () {
      expect(results['parent'], 'success');
    });
  });

  group('Given unknownKeys strict on a model whose field uses readValue', () {
    test('When the builder runs then generation fails naming the '
        'field', () async {
      final source = _readValueSource.replaceFirst(
        '@luthor\n',
        '@Luthor(unknownKeys: .strict)\n',
      );

      final errors = await generationErrors(source);

      expect(
        errors,
        contains(
          '`Legacy` sets `unknownKeys: .strict`, but field `name` uses '
          '`@JsonKey(readValue: ...)`, which can read keys the schema does '
          'not declare. Remove `unknownKeys`, or set it to `.passthrough`.',
        ),
      );
    });
  });

  group('Given unknownKeys strip on a model with a private JSON field', () {
    test('When the builder runs then generation fails naming the '
        'field', () async {
      final source = _privateFieldSource.replaceFirst(
        '@luthor\n',
        '@Luthor(unknownKeys: .strip)\n',
      );

      final errors = await generationErrors(source);

      expect(
        errors,
        contains(
          '`Vault` sets `unknownKeys: .strip`, but private field `_code` uses '
          '`@JsonKey(includeFromJson: true)`, which can read keys the schema '
          'does not declare.',
        ),
      );
    });
  });

  group('Given unknownKeys strict on a dart_mappable model with a hook', () {
    test('When the builder runs then generation fails naming the '
        'hook', () async {
      final source = _mappableHookSource.replaceFirst(
        '@luthor\n',
        '@Luthor(unknownKeys: .strict)\n',
      );

      final errors = await generationErrors(source);

      expect(
        errors,
        contains(
          '`Hooked` sets `unknownKeys: .strict`, but it uses '
          '`@MappableClass(hook: ...)`, which can read keys the schema does '
          'not declare.',
        ),
      );
    });
  });

  group('Given the unknown_keys builder option is strict', () {
    const options = {'unknown_keys': 'strict'};

    test('When a model has no setting then its schema is strict', () async {
      final output = (await generateSharedPart(
        _nestedStrictSource,
        options: options,
      )).output;

      expectOutputContains(output, '}).strict().withName("Order");');
    });

    test('When a nested class has no @luthor then its schema is '
        'strict', () async {
      final output = (await generateSharedPart(
        _autoNestedSource,
        options: options,
      )).output;

      expectOutputContains(output, '}).strict().withName("Line");');
    });

    test('When a model sets strip then the annotation wins', () async {
      final source = _strictSource.replaceFirst('.strict', '.strip');

      final output = (await generateSharedPart(
        source,
        options: options,
      )).output;

      expectOutputContains(output, '}).withName("Strict");');
    });

    test('When a model sets passthrough then the annotation wins', () async {
      final source = _strictSource.replaceFirst('.strict', '.passthrough');

      final output = (await generateSharedPart(
        source,
        options: options,
      )).output;

      expectOutputContains(output, '}).passthrough().withName("Strict");');
    });

    group('When a model without a setting uses readValue', () {
      late GenerationResult result;

      setUp(() async {
        result = await generateSharedPart(_readValueSource, options: options);
      });

      test('Then its schema keeps unknown keys', () {
        expectOutputContains(
          result.output,
          '}).passthrough().withName("Legacy");',
        );
      });

      test('Then the build warns that the model is not strict', () {
        expect(result.warnings, [
          contains(
            '`Legacy` passes unknown keys through instead of using the '
            '`unknown_keys: strict` builder option, because field `name` '
            'uses `@JsonKey(readValue: ...)`. Annotate it '
            '`@Luthor(unknownKeys: .passthrough)` to silence this warning.',
          ),
        ]);
      });
    });

    test('When a readValue model sets passthrough then the build does not '
        'warn', () async {
      final source = _readValueSource.replaceFirst(
        '@luthor\n',
        '@Luthor(unknownKeys: .passthrough)\n',
      );

      final result = await generateSharedPart(source, options: options);

      expect(result.warnings, isEmpty);
    });
  });

  group('Given the unknown_keys builder option is passthrough', () {
    test('When a model has no setting then its schema keeps unknown '
        'keys', () async {
      final output = (await generateSharedPart(
        _nestedStrictSource,
        options: {'unknown_keys': 'passthrough'},
      )).output;

      expectOutputContains(output, '}).passthrough().withName("Order");');
    });

    test('When a model uses readValue then the build does not warn', () async {
      final result = await generateSharedPart(
        _readValueSource,
        options: {'unknown_keys': 'passthrough'},
      );

      expect(result.warnings, isEmpty);
    });
  });

  group('Given the unknown_keys builder option is strip', () {
    const options = {'unknown_keys': 'strip'};

    test('When a model sets strict then the annotation wins', () async {
      final output = (await generateSharedPart(
        _strictSource,
        options: options,
      )).output;

      expectOutputContains(output, '}).strict().withName("Strict");');
    });

    group('When a model without a setting uses readValue', () {
      late GenerationResult result;

      setUp(() async {
        result = await generateSharedPart(_readValueSource, options: options);
      });

      test('Then its schema keeps unknown keys', () {
        expectOutputContains(
          result.output,
          '}).passthrough().withName("Legacy");',
        );
      });

      test('Then the build warns that the model does not strip', () {
        expect(result.warnings, [
          contains('`unknown_keys: strip` builder option, because field '),
        ]);
      });
    });

    test('When a nested class without @luthor uses readValue then the '
        'warning has no annotation hint', () async {
      final result = await generateSharedPart(
        _autoReadValueSource,
        options: options,
      );

      expect(result.warnings, [
        endsWith(
          '`Alias` passes unknown keys through instead of using the '
          '`unknown_keys: strip` builder option, because field `name` uses '
          '`@JsonKey(readValue: ...)`.',
        ),
      ]);
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

const _strictSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@Luthor(unknownKeys: .strict)
class Strict {
  final String name;

  const Strict({required this.name});

  factory Strict.fromJson(Map<String, dynamic> json) =>
      Strict(name: json['name'] as String);

  Map<String, dynamic> toJson() => {'name': name};
}
''';

const _strictMappableSource = '''
import 'package:dart_mappable/dart_mappable.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@MappableClass()
@Luthor(unknownKeys: .strict)
class Tagged {
  final String name;

  const Tagged({required this.name});
}

class TaggedMapper {
  static Tagged fromMap(Map<String, Object?> map) =>
      Tagged(name: map['name']! as String);
}

extension TaggedMapperExtension on Tagged {
  Map<String, Object?> toMap() => {'name': name};
}
''';

const _nestedStrictSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@Luthor(unknownKeys: .strict)
class Address {
  final String city;

  const Address({required this.city});

  factory Address.fromJson(Map<String, dynamic> json) =>
      Address(city: json['city'] as String);

  Map<String, dynamic> toJson() => {'city': city};
}

@luthor
class Order {
  final Address address;

  const Order({required this.address});

  factory Order.fromJson(Map<String, dynamic> json) =>
      Order(address: Address.fromJson(json['address'] as Map<String, dynamic>));

  Map<String, dynamic> toJson() => {'address': address.toJson()};
}
''';

const _autoNestedSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

class Line {
  final String sku;

  const Line({required this.sku});

  factory Line.fromJson(Map<String, dynamic> json) =>
      Line(sku: json['sku'] as String);
}

@luthor
class Cart {
  final Line line;

  const Cart({required this.line});

  factory Cart.fromJson(Map<String, dynamic> json) =>
      Cart(line: Line.fromJson(json['line'] as Map<String, dynamic>));
}
''';

const _autoReadValueSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

Object? readName(Map<dynamic, dynamic> json, String key) =>
    json[key] ?? json['legacy_name'];

class Alias {
  final String name;

  const Alias({@JsonKey(readValue: readName) required this.name});

  factory Alias.fromJson(Map<String, dynamic> json) =>
      Alias(name: readName(json, 'name') as String);
}

@luthor
class Person {
  final Alias alias;

  const Person({required this.alias});

  factory Person.fromJson(Map<String, dynamic> json) =>
      Person(alias: Alias.fromJson(json['alias'] as Map<String, dynamic>));
}
''';
