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

      test('Then referenced compatible classes get private schemas', () {
        expect(generation.output, contains(r'''Validator _$AuthorSchema ='''));
        expect(generation.output, contains(r'''Validator _$CommentSchema ='''));
      });

      test('Then list item schemas are referenced lazily', () {
        expectOutputContains(
          generation.output,
          r'''ArticleSchemaKeys.comments: l.list(forwardRef(() => _$CommentSchema.required())).required(),''',
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
          contains(r'''l.list(forwardRef(() => $NodeSchema.required()))'''),
        );
      });
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(recursiveSource);
    });
  });
}
