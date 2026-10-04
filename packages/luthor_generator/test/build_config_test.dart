import 'dart:io';

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
}
