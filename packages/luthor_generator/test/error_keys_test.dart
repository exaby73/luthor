import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given a model with nested model fields', () {
    test(
      'When the builder generates error keys then nested fields have their own key',
      () async {
        final generation = await generateSharedPart(_nestedSource);

        expectOutputContains(
          generation.output,
          r'''home: ($key: "home", street: "home.street", geo: ($key: "home.geo", lat: "home.geo.lat"),),''',
        );
      },
    );

    group('When every leaf value is invalid', () {
      late Map<String, Object?> results;

      setUpAll(() async {
        results = await evaluateGenerated(
          _nestedSource,
          _lookUps(
            '''{'full_name': 1, 'home': {'street': 2, 'geo': {'lat': 'north'}}, 'tags': 'none'}''',
            [
              'PersonErrorKeys.name',
              'PersonErrorKeys.home.street',
              'PersonErrorKeys.home.geo.lat',
              'PersonErrorKeys.tags',
            ],
          ),
        );
      });

      test('Then the renamed field key finds its error', () {
        expect(results['PersonErrorKeys.name'], 'full_name must be a string');
      });

      test('Then the nested child key finds its error', () {
        expect(
          results['PersonErrorKeys.home.street'],
          'street must be a string',
        );
      });

      test('Then the doubly nested child key finds its error', () {
        expect(results['PersonErrorKeys.home.geo.lat'], 'lat must be a double');
      });

      test('Then the list field key finds its error', () {
        expect(results['PersonErrorKeys.tags'], 'tags must be a list');
      });
    });

    group('When the nested models are missing', () {
      late Map<String, Object?> results;

      setUpAll(() async {
        results = await evaluateGenerated(
          _nestedSource,
          _lookUps(
            '''{'home': {'street': 'Main'}}''',
            [r'PersonErrorKeys.home.$key', r'PersonErrorKeys.home.geo.$key'],
          ),
        );
        results.addAll(
          await evaluateGenerated(
            _nestedSource,
            _lookUps('{}', [r'PersonErrorKeys.home.$key']),
          ),
        );
      });

      test('Then the nested field key finds the required error', () {
        expect(results[r'PersonErrorKeys.home.$key'], 'home is required');
      });

      test('Then the doubly nested field key finds the required error', () {
        expect(results[r'PersonErrorKeys.home.geo.$key'], 'geo is required');
      });
    });
  });
}

Map<String, String> _lookUps(String payload, List<String> errorKeys) {
  return {
    for (final errorKey in errorKeys)
      errorKey: '\$PersonValidate($payload).getError($errorKey)',
  };
}

const _nestedSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Person {
  final String name;
  final Address home;
  final List<String> tags;

  const Person({
    @JsonKey(name: 'full_name') required this.name,
    required this.home,
    required this.tags,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    name: json['full_name'] as String,
    home: Address.fromJson(json['home'] as Map<String, dynamic>),
    tags: (json['tags'] as List<dynamic>).cast<String>(),
  );

  Map<String, dynamic> toJson() => {
    'full_name': name,
    'home': home,
    'tags': tags,
  };
}

class Address {
  final String street;
  final Geo geo;

  const Address({required this.street, required this.geo});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json['street'] as String,
    geo: Geo.fromJson(json['geo'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {'street': street, 'geo': geo};
}

class Geo {
  final double lat;

  const Geo({required this.lat});

  factory Geo.fromJson(Map<String, dynamic> json) =>
      Geo(lat: json['lat'] as double);

  Map<String, dynamic> toJson() => {'lat': lat};
}
''';
