import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given two models in one library that nest the same class', () {
    group('When the builder generates the library', () {
      late String output;

      setUp(() async {
        output = (await generateSharedPart(_sharedNestedSource)).output;
      });

      test('Then the auto-generated schema is emitted once', () {
        expect(
          RegExp(r'Validator _\$GeoSchema =').allMatches(output),
          hasLength(1),
        );
      });

      test('Then the auto-generated schema is private', () {
        expectOutputLacks(output, r'Validator $GeoSchema');
        expectOutputLacks(output, 'GeoValidationExtension');
        expectOutputLacks(output, r'$GeoValidate');
      });

      test('Then models reference the private schema lazily', () {
        expectOutputContains(
          output,
          r'''ShopSchemaKeys.geo: forwardRef(() => _$GeoSchema.required()),''',
        );
      });
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(_sharedNestedSource);
    });

    test(
      'When the validate function runs then nested errors are reported',
      () async {
        final results = await evaluateGenerated(_sharedNestedSource, {
          'shop': r'''$ShopValidate({'geo': {'lat': 'north'}})''',
        });

        expect(results['shop'], {
          'geo.lat': ['lat must be a double'],
        });
      },
    );
  });

  group('Given two libraries that nest the same class without @luthor', () {
    test('When a third library exports both then it compiles', () async {
      await expectGeneratedLibrariesCompile(_crossLibrarySources);
    });
  });

  group('Given a model annotated with @luthor', () {
    test('When the builder generates the schema then it is final', () async {
      final generation = await generateSharedPart(_sharedNestedSource);

      expectOutputContains(
        generation.output,
        r'''final SchemaValidator $ShopSchema = l.schema({''',
      );
    });
  });
}

const _geoClass = '''
class Geo {
  final double lat;

  const Geo({required this.lat});

  factory Geo.fromJson(Map<String, dynamic> json) =>
      Geo(lat: json['lat'] as double);

  Map<String, dynamic> toJson() => {'lat': lat};
}
''';

const _sharedNestedSource =
    '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Shop {
  final Geo geo;

  const Shop({required this.geo});

  Map<String, dynamic> toJson() => {'geo': geo};

  factory Shop.fromJson(Map<String, dynamic> json) =>
      Shop(geo: Geo.fromJson(json['geo'] as Map<String, dynamic>));
}

@luthor
class Warehouse {
  final Geo geo;

  const Warehouse({required this.geo});

  Map<String, dynamic> toJson() => {'geo': geo};

  factory Warehouse.fromJson(Map<String, dynamic> json) =>
      Warehouse(geo: Geo.fromJson(json['geo'] as Map<String, dynamic>));
}

$_geoClass
''';

const _crossLibrarySources = {
  'app.dart': '''
export 'company.dart';
export 'person.dart';
''',
  'address.dart': '''
class Address {
  final String street;

  const Address({required this.street});

  factory Address.fromJson(Map<String, dynamic> json) =>
      Address(street: json['street'] as String);

  Map<String, dynamic> toJson() => {'street': street};
}
''',
  'person.dart': '''
import 'package:luthor/luthor.dart';

import 'address.dart';

part 'person.g.dart';

@luthor
class Person {
  final Address home;

  const Person({required this.home});

  Map<String, dynamic> toJson() => {'home': home};

  factory Person.fromJson(Map<String, dynamic> json) =>
      Person(home: Address.fromJson(json['home'] as Map<String, dynamic>));
}
''',
  'company.dart': '''
import 'package:luthor/luthor.dart';

import 'address.dart';

part 'company.g.dart';

@luthor
class Company {
  final Address office;

  const Company({required this.office});

  Map<String, dynamic> toJson() => {'office': office};

  factory Company.fromJson(Map<String, dynamic> json) =>
      Company(office: Address.fromJson(json['office'] as Map<String, dynamic>));
}
''',
};
