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
}
