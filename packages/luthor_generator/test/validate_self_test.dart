import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given models without a toJson method', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_noToJsonSource)).output;
    });

    test('Then no validateSelf extension is generated', () {
      expectOutputLacks(output, 'NoToJsonValidationExtension');
      expectOutputLacks(output, 'NoCreateToJsonValidationExtension');
      expectOutputLacks(output, 'FreezedNoToJsonValidationExtension');
    });

    test('Then freezed models that generate toJson keep the extension', () {
      expectOutputContains(
        output,
        'extension FreezedWithToJsonValidationExtension on FreezedWithToJson {',
      );
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(_noToJsonSourceWithoutFreezed);
    });
  });

  group('Given a model whose toJson keeps nested objects', () {
    group('When validateSelf runs', () {
      late Map<String, Object?> results;

      setUpAll(() async {
        results = await evaluateGenerated(_nestedToJsonSource, {
          'person':
              '''Person(home: const Address(street: 'Main'), tags: {'a'}).validateSelf()''',
          'node':
              '''const Node(name: 'root', children: [Node(name: 'leaf', children: [])]).validateSelf()''',
          'invalid':
              '''Person(home: const Address(street: ''), tags: {}).validateSelf()''',
        });
      });

      test('Then nested models are validated as maps', () {
        expect(results['person'], 'success');
      });

      test('Then recursive models validate', () {
        expect(results['node'], 'success');
      });

      test('Then nested errors are still reported', () {
        expect(results['invalid'], {
          'home': {
            'street': ['street must be at least 1 character long'],
          },
        });
      });
    });
  });
}

const _noToJsonModels = '''
@luthor
class NoToJson {
  final String name;

  const NoToJson({required this.name});

  factory NoToJson.fromJson(Map<String, dynamic> json) =>
      NoToJson(name: json['name'] as String);
}

@luthor
@JsonSerializable(createToJson: false)
class NoCreateToJson {
  final String name;

  const NoCreateToJson({required this.name});

  factory NoCreateToJson.fromJson(Map<String, dynamic> json) =>
      NoCreateToJson(name: json['name'] as String);
}
''';

const _noToJsonSourceWithoutFreezed =
    '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

$_noToJsonModels
''';

const _noToJsonSource =
    '''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

$_noToJsonModels

@luthor
@Freezed(toJson: false)
abstract class FreezedNoToJson with _\$FreezedNoToJson {
  const factory FreezedNoToJson({required String name}) = _FreezedNoToJson;

  factory FreezedNoToJson.fromJson(Map<String, dynamic> json) =>
      _\$FreezedNoToJsonFromJson(json);
}

@luthor
@freezed
abstract class FreezedWithToJson with _\$FreezedWithToJson {
  const factory FreezedWithToJson({required String name}) = _FreezedWithToJson;

  factory FreezedWithToJson.fromJson(Map<String, dynamic> json) =>
      _\$FreezedWithToJsonFromJson(json);
}
''';

const _nestedToJsonSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Person {
  final Address home;
  final Set<String> tags;

  const Person({required this.home, required this.tags});

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    home: Address.fromJson(json['home'] as Map<String, dynamic>),
    tags: (json['tags'] as List<dynamic>).cast<String>().toSet(),
  );

  Map<String, dynamic> toJson() => {'home': home, 'tags': tags};
}

class Address {
  final String street;

  const Address({@HasMin(1) required this.street});

  factory Address.fromJson(Map<String, dynamic> json) =>
      Address(street: json['street'] as String);

  Map<String, dynamic> toJson() => {'street': street};
}

@luthor
class Node {
  final String name;
  final List<Node> children;

  const Node({required this.name, required this.children});

  factory Node.fromJson(Map<String, dynamic> json) => Node(
    name: json['name'] as String,
    children: (json['children'] as List<dynamic>)
        .map((child) => Node.fromJson(child as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {'name': name, 'children': children};
}
''';
