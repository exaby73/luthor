import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given a model with enum fields', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_enumSource)).output;
    });

    test('Then enum names are the allowed values', () {
      expectOutputContains(
        output,
        'EnumsSchemaKeys.role: l.oneOf(["admin", "member"]).required(),',
      );
    });

    test('Then enum list items are checked', () {
      expectOutputContains(
        output,
        'EnumsSchemaKeys.roles: l.list(l.oneOf(["admin", "member"]).required()),',
      );
    });

    test('Then JsonValue and JsonEnum fieldRename values are used', () {
      expectOutputContains(
        output,
        'EnumsSchemaKeys.color: l.oneOf(["R", "dark_blue"]).required(),',
      );
    });

    test('Then a JsonEnum valueField selects integer values', () {
      expectOutputContains(
        output,
        'EnumsSchemaKeys.level: l.oneOf([10, 20]).required(),',
      );
    });

    test('Then a MappableEnum case style is used', () {
      expectOutputContains(
        output,
        'EnumsSchemaKeys.size: l.oneOf(["SMALL_SIZE", "huge"]).required(),',
      );
    });

    group('When the validate function runs', () {
      late Map<String, Object?> results;

      setUpAll(() async {
        results = await evaluateGenerated(_enumSource, {
          'valid':
              r'''$EnumsValidate({'role': 'admin', 'roles': ['member'], 'color': 'R', 'level': 20, 'size': 'huge'})''',
          'invalid':
              r'''$EnumsValidate({'role': 'owner', 'roles': ['admin', 'guest'], 'color': 'R', 'level': 20, 'size': 'huge'})''',
        });
      });

      test('Then known values succeed', () {
        expect(results['valid'], 'success');
      });

      test('Then unknown values are errors at their paths', () {
        expect(results['invalid'], {
          'role': ['role must be one of: admin, member'],
          'roles.1': ['roles must be one of: admin, member'],
        });
      });
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(_enumSource);
    });
  });

  group('Given a model with Set, Iterable, Uri and Object fields', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_jsonTypesSource)).output;
    });

    test('Then sets and iterables are validated as lists', () {
      expectOutputContains(
        output,
        'JsonTypesSchemaKeys.tags: l.list(l.string().required()).required(),',
      );
      expectOutputContains(
        output,
        'JsonTypesSchemaKeys.scores: l.list(l.int().required()).required(),',
      );
    });

    test('Then a Uri is validated as a string', () {
      expectOutputContains(
        output,
        'JsonTypesSchemaKeys.link: l.string().required(),',
      );
    });

    test('Then Object fields accept any value', () {
      expectOutputContains(output, 'JsonTypesSchemaKeys.anything: l.any(),');
      expectOutputContains(
        output,
        'JsonTypesSchemaKeys.something: l.any().required(),',
      );
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(_jsonTypesSource);
    });
  });
}

const _enumSource = '''
import 'package:dart_mappable/dart_mappable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

enum Role { admin, member }

@JsonEnum(fieldRename: FieldRename.snake)
enum Color {
  @JsonValue('R')
  red,
  darkBlue,
}

@JsonEnum(valueField: 'code')
enum Level {
  low(10),
  high(20);

  const Level(this.code);

  final int code;
}

@MappableEnum(caseStyle: CaseStyle.upperSnakeCase)
enum Size {
  smallSize,
  @MappableValue('huge')
  bigSize,
}

@luthor
class Enums {
  final Role role;
  final List<Role>? roles;
  final Color color;
  final Level level;
  final Size size;

  const Enums({
    required this.role,
    this.roles,
    required this.color,
    required this.level,
    required this.size,
  });

  factory Enums.fromJson(Map<String, dynamic> json) => const Enums(
    role: Role.admin,
    color: Color.red,
    level: Level.low,
    size: Size.bigSize,
  );

  Map<String, dynamic> toJson() => {};
}
''';

const _jsonTypesSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class JsonTypes {
  final Set<String> tags;
  final Iterable<int> scores;
  final Uri link;
  final Object? anything;
  final Object something;

  const JsonTypes({
    required this.tags,
    required this.scores,
    required this.link,
    this.anything,
    required this.something,
  });

  factory JsonTypes.fromJson(Map<String, dynamic> json) => JsonTypes(
    tags: (json['tags'] as List<dynamic>).cast<String>().toSet(),
    scores: (json['scores'] as List<dynamic>).cast<int>(),
    link: Uri.parse(json['link'] as String),
    anything: json['anything'],
    something: json['something'] as Object,
  );

  Map<String, dynamic> toJson() => {};
}
''';
