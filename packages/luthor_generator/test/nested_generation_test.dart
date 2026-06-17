import 'package:test/test.dart';

import 'fixtures/generator_sources.dart';
import 'utils/generator_test_utils.dart';

void main() {
  group('Given an annotated class with compatible nested classes', () {
    late GenerationResult generation;

    group('When the builder discovers nested schemas', () {
      setUp(() async {
        generation = await generateSharedPart(nestedSource);
      });

      test('Then referenced compatible classes get schemas', () {
        expect(generation.output, contains(r'''Validator $AuthorSchema ='''));
        expect(generation.output, contains(r'''Validator $CommentSchema ='''));
      });

      test('Then list item schemas are referenced', () {
        expect(generation.output, contains('ArticleSchemaKeys.comments: l'));
        expect(
          generation.output,
          contains(r'''validators: [$CommentSchema.required()]'''),
        );
      });
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(nestedSource);
    });
  });

  group('Given an annotated self-referential class', () {
    late GenerationResult generation;

    group('When the builder generates the recursive field', () {
      setUp(() async {
        generation = await generateSharedPart(recursiveSource);
      });

      test('Then forwardRef wraps the self reference', () {
        expect(
          generation.output,
          contains(
            r'''validators: [forwardRef(() => $NodeSchema.required())]''',
          ),
        );
      });
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(recursiveSource);
    });
  });
}
