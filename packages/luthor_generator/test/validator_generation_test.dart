import 'package:test/test.dart';

import 'fixtures/generator_sources.dart';
import 'utils/generator_test_utils.dart';

void main() {
  group('Given an annotated class using every supported validator kind', () {
    late GenerationResult generation;

    group('When the builder generates validators', () {
      setUp(() async {
        generation = await generateSharedPart(allValidatorsSource);
      });

      test('Then scalar validators include annotation configuration', () {
        expectOutputContains(
          generation.output,
          r'''FieldsSchemaKeys.email: l.string().email(message: "can't email \"user\"").required(),''',
        );
        expectOutputContains(
          generation.output,
          '''FieldsSchemaKeys.uri: l.string().uri(allowedSchemes: ["https", "custom+scheme"], message: "can't uri").required(),''',
        );
        expectOutputContains(
          generation.output,
          r'''FieldsSchemaKeys.path: l.string().regex("^foo\\d+\$", message: "can't match").required(),''',
        );
        expectOutputContains(
          generation.output,
          '''FieldsSchemaKeys.ipv4: l.string().ip(version: IpVersion.v4, message: "can't ip").required(),''',
        );
      });

      test('Then number and collection validators are generated', () {
        expectOutputContains(
          generation.output,
          'FieldsSchemaKeys.count: l.int().max(10).min(1).required(),',
        );
        expectOutputContains(
          generation.output,
          'FieldsSchemaKeys.ratio: l.double().max(1.5).min(0.5).required(),',
        );
        expectOutputContains(
          generation.output,
          'FieldsSchemaKeys.amount: l.number().max(99).min(0).required(),',
        );
        expectOutputContains(
          generation.output,
          'FieldsSchemaKeys.tags: l.list(validators: [l.string().required()]).required(),',
        );
        expectOutputContains(
          generation.output,
          'FieldsSchemaKeys.nothing: l.nullValue(),',
        );
        expectOutputContains(
          generation.output,
          'FieldsSchemaKeys.scores: l.map(keyValidator: l.string().required(), valueValidator: l.int().required(),).required(),',
        );
      });

      test('Then custom validators keep qualified callback names', () {
        expectOutputContains(
          generation.output,
          '''FieldsSchemaKeys.custom: l.string().custom(isCustomValue, message: "can't custom").required(),''',
        );
        expectOutputContains(
          generation.output,
          '''FieldsSchemaKeys.schemaCustom: l.string().customWithSchema(FieldsValidators.matchesCustom, message: "can't schema").required(),''',
        );
      });
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(allValidatorsSource);
    });
  });

  group('Given a file field with a custom message', () {
    test(
      'When the builder generates the schema then the message is kept',
      () async {
        final generation = await generateSharedPart(_fileMessageSource);

        expectOutputContains(
          generation.output,
          'AttachmentSchemaKeys.file: l.file(message: "need a file").required(),',
        );
      },
    );
  });

  group('Given a model with a static fromJson method', () {
    test(
      'When the builder generates the validate function then it uses the method',
      () async {
        final generation = await generateSharedPart(_staticFromJsonSource);

        expectOutputContains(
          generation.output,
          r'''$StaticFactorySchema.validateSchema(json, fromJson: StaticFactory.fromJson);''',
        );
      },
    );
  });

  group('Given an annotation bound that is infinite', () {
    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(_infiniteBoundSource);
    });
  });

  group('Given annotations from another package with serializer names', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_imposterSource)).output;
    });

    test('Then a foreign JsonKey does not rename the key', () {
      expectOutputContains(
        output,
        'const ImposterSchemaKeys = (value: "value",);',
      );
    });

    test('Then a foreign Default does not make the field optional', () {
      expectOutputContains(
        output,
        'ImposterSchemaKeys.value: l.string().required(),',
      );
    });
  });
}

const _fileMessageSource = '''
import 'dart:io';

import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Attachment {
  final File file;

  const Attachment({@IsFile(message: 'need a file') required this.file});

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      Attachment(file: json['file'] as File);

  Map<String, dynamic> toJson() => {'file': file};
}
''';

const _staticFromJsonSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class StaticFactory {
  final String name;

  const StaticFactory({required this.name});

  static StaticFactory fromJson(Map<String, dynamic> json) =>
      StaticFactory(name: json['name'] as String);

  Map<String, dynamic> toJson() => {'name': name};
}
''';

const _infiniteBoundSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Bounds {
  final double ratio;

  const Bounds({
    @HasMaxDouble(double.infinity) @HasMinDouble(double.negativeInfinity)
    required this.ratio,
  });

  factory Bounds.fromJson(Map<String, dynamic> json) =>
      Bounds(ratio: json['ratio'] as double);

  Map<String, dynamic> toJson() => {'ratio': ratio};
}
''';

const _imposterSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

class JsonKey {
  const JsonKey({this.name});

  final String? name;
}

class Default {
  const Default(this.value);

  final Object? value;
}

@luthor
class Imposter {
  final String value;

  const Imposter({@JsonKey(name: 'other') @Default('x') required this.value});

  factory Imposter.fromJson(Map<String, dynamic> json) =>
      Imposter(value: json['value'] as String);

  Map<String, dynamic> toJson() => {'value': value};
}
''';
