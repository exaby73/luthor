import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given a string annotation on an int field', () {
    test(
      'When the builder runs then it reports the misplaced annotation',
      () async {
        expect(
          await generationErrors(_misplaced('@isEmail', 'int')),
          allOf(
            contains('@IsEmail cannot be used on field `value` of `Misplaced`'),
            contains('it applies to String fields, but `value` is int'),
          ),
        );
      },
    );
  });

  group('Given a fractional bound on an int field', () {
    test(
      'When the builder runs then it reports that the bound must be an int',
      () async {
        expect(
          await generationErrors(_misplaced('@HasMax(5.5)', 'int')),
          contains('@HasMax on field `value` of `Misplaced` needs an int'),
        );
      },
    );
  });

  group('Given a fractional bound on a String field', () {
    test(
      'When the builder runs then it reports that the bound must be an int',
      () async {
        expect(
          await generationErrors(_misplaced('@HasMin(1.5)', 'String')),
          contains('@HasMin on field `value` of `Misplaced` needs an int'),
        );
      },
    );
  });

  group('Given a string annotation on a list field', () {
    test(
      'When the builder runs then it points to list element support',
      () async {
        expect(
          await generationErrors(_misplaced('@HasLength(3)', 'List<String>')),
          allOf(
            contains('@HasLength cannot be used on field `value`'),
            contains('Validators for list elements are not supported yet'),
          ),
        );
      },
    );
  });

  group('Given integer bounds on double and num fields', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_boundsSource)).output;
    });

    test('Then the bounds are applied', () {
      expectOutputContains(
        output,
        'BoundsSchemaKeys.ratio: l.double().max(5).required(),',
      );
      expectOutputContains(
        output,
        'BoundsSchemaKeys.amount: l.num().min(1).required(),',
      );
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(_boundsSource);
    });
  });

  group('Given repeated annotations on one field', () {
    test('When the builder generates the schema then each one applies', () async {
      final generation = await generateSharedPart(_repeatedSource);

      expectOutputContains(
        generation.output,
        'RepeatedSchemaKeys.name: l.string().min(1).min(5).custom(isA).custom(isB).required(),',
      );
    });
  });
}

String _misplaced(String annotation, String type) =>
    '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Misplaced {
  final $type value;

  const Misplaced({$annotation required this.value});

  factory Misplaced.fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();

  Map<String, dynamic> toJson() => {};
}
''';

const _boundsSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Bounds {
  final double ratio;
  final num amount;

  const Bounds({@HasMax(5) required this.ratio, @HasMin(1) required this.amount});

  factory Bounds.fromJson(Map<String, dynamic> json) =>
      Bounds(ratio: json['ratio'] as double, amount: json['amount'] as num);

  Map<String, dynamic> toJson() => {'ratio': ratio, 'amount': amount};
}
''';

const _repeatedSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

bool isA(Object? value) => true;

bool isB(Object? value) => true;

@luthor
class Repeated {
  final String name;

  const Repeated({
    @HasMin(1)
    @HasMin(5)
    @WithCustomValidator(isA)
    @WithCustomValidator(isB)
    required this.name,
  });

  factory Repeated.fromJson(Map<String, dynamic> json) =>
      Repeated(name: json['name'] as String);

  Map<String, dynamic> toJson() => {'name': name};
}
''';
