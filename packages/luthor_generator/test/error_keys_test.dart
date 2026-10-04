import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given a model with a nested model field', () {
    test(
      'When the builder generates error keys then the nested field has its own key',
      () async {
        final generation = await generateSharedPart(_nestedSource);

        expectOutputContains(
          generation.output,
          r'''home: ($key: "home", street: "home.street"),''',
        );
      },
    );

    group('When the error keys look up errors', () {
      late Map<String, Object?> results;

      setUpAll(() async {
        results = await evaluateGenerated(_nestedSource, {
          'missingHome':
              r'''($PersonValidate({}) as SchemaValidationError).getError(PersonErrorKeys.home.$key)''',
          'missingStreet':
              r'''($PersonValidate({'home': <String, dynamic>{}}) as SchemaValidationError).getError(PersonErrorKeys.home.street)''',
        });
      });

      test('Then the nested field key finds the field error', () {
        expect(results['missingHome'], 'home is required');
      });

      test('Then the nested child key finds the child error', () {
        expect(results['missingStreet'], 'street is required');
      });
    });
  });
}

const _nestedSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Person {
  final Address home;

  const Person({required this.home});

  factory Person.fromJson(Map<String, dynamic> json) =>
      Person(home: Address.fromJson(json['home'] as Map<String, dynamic>));

  Map<String, dynamic> toJson() => {'home': home};
}

class Address {
  final String street;

  const Address({required this.street});

  factory Address.fromJson(Map<String, dynamic> json) =>
      Address(street: json['street'] as String);

  Map<String, dynamic> toJson() => {'street': street};
}
''';
