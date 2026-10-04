import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given a model that uses prefixed imports', () {
    late String output;

    setUp(() async {
      output = (await generateSharedParts(_prefixedSources))['shop.dart']!;
    });

    test('Then nested schemas keep the import prefix', () {
      expectOutputContains(
        output,
        r'''ShopSchemaKeys.address: forwardRef(() => m.$AddressSchema.required()),''',
      );
    });

    test('Then custom validator functions keep the import prefix', () {
      expectOutputContains(
        output,
        'l.int().custom(v.isPositive, messageBuilder: v.positiveMessage).required()',
      );
    });

    test('Then static extension methods are qualified', () {
      expectOutputContains(output, 'custom(v.NumChecks.small)');
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedLibrariesCompile(_prefixedSources);
    });
  });

  group('Given a model whose nested @luthor schema is hidden by show', () {
    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedLibrariesCompile(_hiddenSchemaSources);
    });
  });

  group('Given a class name containing a dollar sign', () {
    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(_dollarSource);
    });
  });
}

const _addressLibrary = '''
import 'package:luthor/luthor.dart';

part 'address.g.dart';

@luthor
class Address {
  final String street;

  const Address({required this.street});

  factory Address.fromJson(Map<String, dynamic> json) =>
      Address(street: json['street'] as String);

  Map<String, dynamic> toJson() => {'street': street};
}
''';

const _prefixedSources = {
  'shop.dart': '''
import 'package:luthor/luthor.dart';

import 'address.dart' as m;
import 'validators.dart' as v;

part 'shop.g.dart';

@luthor
class Shop {
  final m.Address address;
  final int count;
  final int size;

  const Shop({
    required this.address,
    @WithCustomValidator(v.isPositive, messageBuilder: v.positiveMessage)
    required this.count,
    @WithCustomValidator(v.NumChecks.small) required this.size,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    address: m.Address.fromJson(json['address'] as Map<String, dynamic>),
    count: json['count'] as int,
    size: json['size'] as int,
  );

  Map<String, dynamic> toJson() => {
    'address': address.toJson(),
    'count': count,
    'size': size,
  };
}
''',
  'address.dart': _addressLibrary,
  'validators.dart': '''
import 'package:luthor/luthor.dart';

bool isPositive(Object? value) => value is int && value > 0;

String positiveMessage(ValidationIssue issue) => 'must be positive';

extension NumChecks on int {
  static bool small(Object? value) => value is int && value < 10;
}
''',
};

const _hiddenSchemaSources = {
  'shop.dart': '''
import 'package:luthor/luthor.dart';

import 'address.dart' show Address;

part 'shop.g.dart';

@luthor
class Shop {
  final Address address;

  const Shop({required this.address});

  factory Shop.fromJson(Map<String, dynamic> json) =>
      Shop(address: Address.fromJson(json['address'] as Map<String, dynamic>));

  Map<String, dynamic> toJson() => {'address': address.toJson()};
}
''',
  'address.dart': _addressLibrary,
};

const _dollarSource = r'''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Foo$Bar {
  final String name;

  const Foo$Bar({required this.name});

  factory Foo$Bar.fromJson(Map<String, dynamic> json) =>
      Foo$Bar(name: json['name'] as String);

  Map<String, dynamic> toJson() => {'name': name};
}
''';
