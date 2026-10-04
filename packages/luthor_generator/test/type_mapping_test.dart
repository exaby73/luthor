import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given a model with DateTime and nested map fields', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_dateAndMapSource)).output;
    });

    test('Then a nullable DateTime gets the date check', () {
      expectOutputContains(
        output,
        'TypesSchemaKeys.maybeAt: l.string().dateTime(),',
      );
    });

    test('Then DateTime list items get the date check', () {
      expectOutputContains(
        output,
        'TypesSchemaKeys.dates: l.list(l.string().dateTime().required()).required(),',
      );
    });

    test('Then nested maps get key and value validators', () {
      expectOutputContains(
        output,
        'TypesSchemaKeys.nested: l.map(keyValidator: l.string().required(), valueValidator: l.map(keyValidator: l.string().required(), valueValidator: l.int().required()).required()).required(),',
      );
    });

    group('When the validate function runs', () {
      late Map<String, Object?> results;

      setUpAll(() async {
        results = await evaluateGenerated(_dateAndMapSource, {
          'badDate':
              r'''$TypesValidate({'maybeAt': 'garbage', 'dates': [], 'nested': {}, 'listOfMaps': []})''',
          'badListDate':
              r'''$TypesValidate({'dates': ['garbage'], 'nested': {}, 'listOfMaps': []})''',
          'badNested':
              r'''$TypesValidate({'dates': [], 'nested': {'a': {'b': 'x'}}, 'listOfMaps': []})''',
          'badListOfMaps':
              r'''$TypesValidate({'dates': [], 'nested': {}, 'listOfMaps': [{'a': 'x'}]})''',
        });
      });

      test('Then an invalid nullable date is a validation error', () {
        expect(results['badDate'], isA<Map<String, Object?>>());
      });

      test('Then an invalid date in a list is a validation error', () {
        expect(results['badListDate'], isA<Map<String, Object?>>());
      });

      test('Then an invalid nested map value is a validation error', () {
        expect(results['badNested'], isA<Map<String, Object?>>());
      });

      test('Then an invalid map inside a list is a validation error', () {
        expect(results['badListOfMaps'], isA<Map<String, Object?>>());
      });
    });
  });

  group('Given a model with a dart:io File field and no annotation', () {
    test(
      'When the builder generates the schema then it uses l.file()',
      () async {
        final generation = await generateSharedPart(_fileSource);

        expectOutputContains(
          generation.output,
          'UploadSchemaKeys.upload: l.file().required(),',
        );
      },
    );
  });
}

const _dateAndMapSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Types {
  final DateTime? maybeAt;
  final List<DateTime> dates;
  final Map<String, Map<String, int>> nested;
  final List<Map<String, int>> listOfMaps;

  const Types({
    this.maybeAt,
    required this.dates,
    required this.nested,
    required this.listOfMaps,
  });

  factory Types.fromJson(Map<String, dynamic> json) => Types(
    maybeAt: json['maybeAt'] == null
        ? null
        : DateTime.parse(json['maybeAt'] as String),
    dates: (json['dates'] as List<dynamic>)
        .map((date) => DateTime.parse(date as String))
        .toList(),
    nested: (json['nested'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(
        key,
        (value as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, value as int),
        ),
      ),
    ),
    listOfMaps: (json['listOfMaps'] as List<dynamic>)
        .map(
          (item) => (item as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, value as int),
          ),
        )
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'maybeAt': maybeAt?.toIso8601String(),
    'dates': dates.map((date) => date.toIso8601String()).toList(),
    'nested': nested,
    'listOfMaps': listOfMaps,
  };
}
''';

const _fileSource = '''
import 'dart:io';

import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Upload {
  final File upload;

  const Upload({required this.upload});

  factory Upload.fromJson(Map<String, dynamic> json) =>
      Upload(upload: json['upload'] as File);

  Map<String, dynamic> toJson() => {'upload': upload};
}
''';
