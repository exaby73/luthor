import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'fixtures/generator_sources.dart';
import 'utils/generator_test_utils.dart';

void main() {
  group('Given @luthor is applied to a non-class element', () {
    late TestBuilderResult result;

    group('When the builder runs', () {
      setUp(() async {
        result = await runBuilder(invalidSource);
      });

      test('Then generation reports the invalid source error', () {
        expect(
          result.errors.join('\n'),
          contains('Luthor can only be applied to classes.'),
        );
      });
    });
  });

  group('Given @luthor is applied to a class without fromJson', () {
    late TestBuilderResult result;

    group('When the builder runs', () {
      setUp(() async {
        result = await runBuilder(noFromJsonSource);
      });

      test('Then generation reports the missing fromJson error', () {
        expect(
          result.errors.join('\n'),
          contains(
            'Luthor can only be applied to classes with a fromJson constructor '
            'or static method, or a @MappableClass annotation.',
          ),
        );
      });
    });
  });

  group('Given an annotated class has an unsupported field type', () {
    late String errors;

    group('When the builder runs', () {
      setUp(() async {
        errors = await generationErrors(unsupportedFieldSource);
      });

      test('Then the error names the field, the model and the type', () {
        expect(
          errors,
          contains(
            'Luthor cannot validate field `unsupported` of `Container`: '
            'its type `Unsupported`',
          ),
        );
      });

      test('Then the error explains how to make the type compatible', () {
        expect(
          errors,
          allOf(
            contains('Annotate `Unsupported` with @luthor'),
            contains('fromJson'),
            contains('JsonConverter'),
          ),
        );
      });

      test('Then the error points at the field', () {
        expect(errors, contains('required this.unsupported'));
      });
    });
  });

  group('Given an annotated class with a record field', () {
    test(
      'When the builder runs then it says records are unsupported',
      () async {
        expect(
          await generationErrors(_recordFieldSource),
          allOf(
            contains('field `pair` of `WithRecord`'),
            contains('Records are not supported'),
          ),
        );
      },
    );
  });

  group('Given a freezed union annotated with @luthor', () {
    test(
      'When the builder runs then it reports unions are unsupported',
      () async {
        expect(
          await generationErrors(_unionSource),
          allOf(
            contains('`Shape` is a union'),
            contains('Shape.circle'),
            contains('Shape.square'),
            contains('union dispatch is not supported yet'),
          ),
        );
      },
    );
  });

  group('Given a generic class annotated with @luthor', () {
    test(
      'When the builder runs then it reports generics are unsupported',
      () async {
        expect(
          await generationErrors(_genericModelSource),
          contains(
            '`Tagged` is generic. Generic models are not supported yet.',
          ),
        );
      },
    );
  });

  group('Given a model with a field whose class is generic', () {
    test(
      'When the builder runs then it reports generics are unsupported',
      () async {
        expect(
          await generationErrors(_genericFieldSource),
          allOf(
            contains('field `tagged` of `UsesTagged`'),
            contains('Generic models are not supported yet'),
          ),
        );
      },
    );
  });

  group('Given a model nesting a class with only positional parameters', () {
    test(
      'When the builder generates the schema then the class gets one',
      () async {
        final generation = await generateSharedPart(_positionalNestedSource);

        expectOutputContains(
          generation.output,
          r'''final SchemaValidator _$PosOnlySchema = l.schema({"a": l.string().required()}).withName("PosOnly");''',
        );
      },
    );
  });
}

const _recordFieldSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class WithRecord {
  final (int, String) pair;

  const WithRecord({required this.pair});

  factory WithRecord.fromJson(Map<String, dynamic> json) =>
      const WithRecord(pair: (1, 'a'));
}
''';

const _unionSource = r'''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
@freezed
sealed class Shape with _$Shape {
  const factory Shape.circle({required double radius}) = Circle;
  factory Shape.square({required double side}) = Square;
  factory Shape.unit() => Shape.square(side: 1);

  factory Shape.fromJson(Map<String, dynamic> json) => _$ShapeFromJson(json);
}
''';

const _taggedClass = '''
class Tagged<T> {
  final String label;

  const Tagged({required this.label});

  factory Tagged.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromT,
  ) => Tagged(label: json['label'] as String);
}
''';

const _genericModelSource =
    '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
$_taggedClass
''';

const _genericFieldSource =
    '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class UsesTagged {
  final Tagged<int> tagged;

  const UsesTagged({required this.tagged});

  factory UsesTagged.fromJson(Map<String, dynamic> json) =>
      const UsesTagged(tagged: Tagged(label: 'x'));
}

$_taggedClass
''';

const _positionalNestedSource = r'''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class UsesPosOnly {
  final PosOnly p;

  const UsesPosOnly({required this.p});

  factory UsesPosOnly.fromJson(Map<String, dynamic> json) =>
      UsesPosOnly(p: PosOnly.fromJson(json['p'] as Map<String, dynamic>));

  Map<String, dynamic> toJson() => {'p': p};
}

@freezed
abstract class PosOnly with _$PosOnly {
  const factory PosOnly(String a) = _PosOnly;

  factory PosOnly.fromJson(Map<String, dynamic> json) =>
      _$PosOnlyFromJson(json);
}
''';
