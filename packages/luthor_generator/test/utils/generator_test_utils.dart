import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:luthor_generator/builder.dart';
import 'package:test/test.dart';

Future<TestBuilderResult> runBuilder(String source) async {
  final readerWriter = TestReaderWriter(rootPackage: 'luthor_generator');
  await readerWriter.testing.loadIsolateSources();
  return testBuilder(
    luthorBuilder(BuilderOptions.empty),
    {'luthor_generator|lib/profile.dart': source},
    rootPackage: 'luthor_generator',
    readerWriter: readerWriter,
    flattenOutput: true,
  );
}

Future<GenerationResult> generateSharedPart(String source) async {
  final result = await runBuilder(source);
  final output = result.readerWriter.testing.readString(
    AssetId('luthor_generator', 'lib/profile.luthor.g.part'),
  );

  return GenerationResult(output);
}

Future<void> expectGeneratedCodeCompiles(String source) async {
  final generation = await generateSharedPart(source);
  final compileSource = source.replaceFirst(
    "part 'profile.g.dart';",
    "part 'profile.luthor.g.part';",
  );
  final library = await resolveSources(
    {
      'luthor_generator|lib/profile.dart': compileSource,
      'luthor_generator|lib/profile.luthor.g.part':
          "part of 'profile.dart';\n${generation.output}",
    },
    (resolver) => resolver.libraries.firstWhere(
      (library) => library.firstFragment.source.fullName.endsWith(
        '/luthor_generator/lib/profile.dart',
      ),
    ),
    readAllSourcesFromFilesystem: true,
  );

  final result =
      await library.session.getErrors('/luthor_generator/lib/profile.dart')
          as ErrorsResult;
  final errors = result.diagnostics
      .where((error) => error.severity == Severity.error)
      .toList();

  expect(
    errors,
    isEmpty,
    reason: errors.map((error) => error.toString()).join('\n'),
  );
}

void expectOutputContains(String output, String expected) {
  expect(_compact(output), contains(_compact(expected)));
}

String _compact(String value) => value.replaceAll(RegExp(r'\s+'), '');

class GenerationResult {
  const GenerationResult(this.output);

  final String output;
}
