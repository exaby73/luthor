import 'dart:io';

import 'package:build/build.dart';
import 'package:luthor_generator/builder.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('Given the luthor builder definition in build.yaml', () {
    late YamlMap builder;

    setUp(() {
      final config = loadYaml(File('build.yaml').readAsStringSync()) as YamlMap;
      builder = (config['builders'] as YamlMap)['luthor'] as YamlMap;
    });

    test(
      'Then it applies the combining builder so projects without json_serializable get a .g.dart',
      () {
        expect(
          builder['applies_builders'],
          contains('source_gen:combining_builder'),
        );
      },
    );
  });

  group('Given the luthor builder options', () {
    test('When unknown_keys is not a mode then creating the builder '
        'throws', () {
      expect(
        () => luthorBuilder(const BuilderOptions({'unknown_keys': 'loose'})),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            'must be one of strip, passthrough, strict',
          ),
        ),
      );
    });

    test('When an option is unknown then creating the builder throws', () {
      expect(
        () => luthorBuilder(const BuilderOptions({'unknown_key': 'strict'})),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            'is not a luthor option. The only option is unknown_keys',
          ),
        ),
      );
    });
  });
}
