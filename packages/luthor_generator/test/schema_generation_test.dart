import 'package:test/test.dart';

import 'fixtures/generator_sources.dart';
import 'utils/generator_test_utils.dart';

void main() {
  group('Given a class annotated with @luthor', () {
    late GenerationResult generation;

    group('When the builder generates a schema', () {
      setUp(() async {
        generation = await generateSharedPart(validProfileSource);
      });

      test('Then schema keys use JsonKey names', () {
        expect(generation.output, contains('const ProfileSchemaKeys = ('));
        expect(generation.output, contains('email: "email_address",'));
        expect(generation.output, contains('displayName: "display\\"name",'));
      });

      test('Then field validators match constructor types and annotations', () {
        expectOutputContains(
          generation.output,
          'ProfileSchemaKeys.email: l.string().email().required(),',
        );
        expectOutputContains(
          generation.output,
          'ProfileSchemaKeys.age: l.int().min(18).required(),',
        );
        expectOutputContains(
          generation.output,
          'ProfileSchemaKeys.status: l.string(),',
        );
        expectOutputContains(
          generation.output,
          'ProfileSchemaKeys.nickname: l.string(),',
        );
      });

      test('Then validation helpers are generated', () {
        expect(
          generation.output,
          contains(
            r'''SchemaValidationResult<Profile> $ProfileValidate(Map<String, dynamic> json) =>''',
          ),
        );
        expect(
          generation.output,
          contains(
            r'''$ProfileSchema.validateSchema(json, fromJson: Profile.fromJson)''',
          ),
        );
        expect(
          generation.output,
          contains(
            r'''SchemaValidationResult<Profile> validateSelf() => $ProfileValidate(toJson());''',
          ),
        );
      });
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(validProfileSource);
    });
  });

  group('Given a dart_mappable class annotated with @luthor', () {
    late GenerationResult generation;

    group('When the builder generates validation helpers', () {
      setUp(() async {
        generation = await generateSharedPart(mappableSource);
      });

      test('Then mapper APIs are used for conversion', () {
        expect(generation.output, contains('MappedProfileMapper.fromMap'));
        expectOutputContains(
          generation.output,
          r'''SchemaValidationResult<MappedProfile> validateSelf() => $MappedProfileValidate(toMap());''',
        );
      });
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(mappableSource);
    });
  });
}
