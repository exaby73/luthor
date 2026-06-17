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

      test('Then generation reports the missing factory error', () {
        expect(
          result.errors.join('\n'),
          contains(
            'Luthor can only be applied to classes with a factory fromJson constructor',
          ),
        );
      });
    });
  });

  group('Given an annotated class has an unsupported field type', () {
    late TestBuilderResult result;

    group('When the builder runs', () {
      setUp(() async {
        result = await runBuilder(unsupportedFieldSource);
      });

      test('Then generation reports how to make the type compatible', () {
        expect(
          result.errors.join('\n'),
          allOf(
            contains('Type Unsupported does not have @luthor annotation'),
            contains('A fromJson factory constructor OR @MappableClass'),
          ),
        );
      });
    });
  });
}
