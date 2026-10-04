import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given a model with non-String map keys', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_mapKeysSource)).output;
    });

    test('Then int keys are strings that parse to int', () {
      expectOutputContains(
        output,
        'KeyedSchemaKeys.byId: l.map(keyValidator: l.string().custom((key) => int.tryParse(key) != null, message: "must be a string containing an integer").required(),',
      );
    });

    test('Then DateTime keys are date strings', () {
      expectOutputContains(
        output,
        'KeyedSchemaKeys.byDay: l.map(keyValidator: l.string().dateTime().required(),',
      );
    });

    test('Then enum keys are the enum values', () {
      expectOutputContains(
        output,
        'KeyedSchemaKeys.byRole: l.map(keyValidator: l.oneOf(["admin", "member"]).required(),',
      );
    });

    group('When the validate function runs', () {
      late Map<String, Object?> results;

      setUpAll(() async {
        results = await evaluateGenerated(_mapKeysSource, {
          'valid':
              r'''$KeyedValidate({'byId': {'1': 'a'}, 'byDay': {'2024-01-01': 1}, 'byRole': {'admin': 1}})''',
          'invalid':
              r'''$KeyedValidate({'byId': {'one': 'a'}, 'byDay': {'Monday': 1}, 'byRole': {'owner': 1}})''',
        });
      });

      test('Then string keys that parse succeed', () {
        expect(results['valid'], 'success');
      });

      test('Then each key that does not parse is a key error on its map', () {
        expect(results['invalid'], {
          'byId': ['byId has an invalid key "one"'],
          'byDay': ['byDay has an invalid key "Monday"'],
          'byRole': ['byRole has an invalid key "owner"'],
        });
      });
    });
  });

  group('Given a model with a map keyed by a class', () {
    test('When the builder runs then it reports the unsupported key', () async {
      expect(
        await generationErrors(_classKeySource),
        allOf(
          contains('field `byPoint` of `ClassKeyed`'),
          contains('JSON object keys are strings'),
        ),
      );
    });
  });
}

const _mapKeysSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

enum Role { admin, member }

@luthor
class Keyed {
  final Map<int, String> byId;
  final Map<DateTime, int> byDay;
  final Map<Role, int> byRole;

  const Keyed({required this.byId, required this.byDay, required this.byRole});

  factory Keyed.fromJson(Map<String, dynamic> json) =>
      const Keyed(byId: {}, byDay: {}, byRole: {});

  Map<String, dynamic> toJson() => {};
}
''';

const _classKeySource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

class Point {
  const Point();

  factory Point.fromJson(Map<String, dynamic> json) => const Point();
}

@luthor
class ClassKeyed {
  final Map<Point, int> byPoint;

  const ClassKeyed({required this.byPoint});

  factory ClassKeyed.fromJson(Map<String, dynamic> json) =>
      const ClassKeyed(byPoint: {});

  Map<String, dynamic> toJson() => {};
}
''';
