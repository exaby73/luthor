import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group(
    'Given a freezed model whose private constructor is declared first',
    () {
      late String output;

      setUp(() async {
        output = (await generateSharedPart(_privateFirstSource)).output;
      });

      test('Then the schema uses the unnamed factory parameters', () {
        expectOutputContains(
          output,
          'WithMethodsSchemaKeys.qty: l.int().min(1).required(),',
        );
      });
    },
  );

  group('Given a model whose fromJson factory is declared first', () {
    group('When the validate function runs', () {
      late Map<String, Object?> results;

      setUpAll(() async {
        results = await evaluateGenerated(_fromJsonFirstSource, {
          'valid': r'''$FromJsonFirstValidate({'title': 't'})''',
          'missing': r'''$FromJsonFirstValidate({})''',
        });
      });

      test('Then a valid payload succeeds', () {
        expect(results['valid'], 'success');
      });

      test('Then the constructor field is required', () {
        expect(results['missing'], {
          'title': ['title is required'],
        });
      });
    });
  });

  group('Given a model that names its constructor in @JsonSerializable', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_namedConstructorSource)).output;
    });

    test('Then the schema uses the named constructor', () {
      expectOutputContains(output, 'const PickedSchemaKeys = (code: "code",);');
    });
  });

  group('Given a model with only a private constructor besides fromJson', () {
    test(
      'When the builder runs then it reports a missing constructor',
      () async {
        expect(
          await generationErrors(_noPublicConstructorSource),
          contains('`Hidden` has no public constructor'),
        );
      },
    );
  });
}

const _privateFirstSource = r'''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
@freezed
abstract class WithMethods with _$WithMethods {
  const WithMethods._();

  const factory WithMethods({
    required String name,
    @HasMin(1) required int qty,
  }) = _WithMethods;

  factory WithMethods.fromJson(Map<String, dynamic> json) =>
      _$WithMethodsFromJson(json);
}
''';

const _fromJsonFirstSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class FromJsonFirst {
  factory FromJsonFirst.fromJson(Map<String, dynamic> json) =>
      FromJsonFirst(title: json['title'] as String);

  const FromJsonFirst({required this.title});

  final String title;

  Map<String, dynamic> toJson() => {'title': title};
}
''';

const _namedConstructorSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
@JsonSerializable(constructor: 'create')
class Picked {
  final String code;

  Picked({required String name}) : code = name;

  Picked.create({required this.code});

  factory Picked.fromJson(Map<String, dynamic> json) =>
      Picked.create(code: json['code'] as String);

  Map<String, dynamic> toJson() => {'code': code};
}
''';

const _noPublicConstructorSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Hidden {
  final String value;

  const Hidden._(this.value);

  factory Hidden.fromJson(Map<String, dynamic> json) =>
      Hidden._(json['value'] as String);
}
''';
