import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:luthor_generator/builder.dart';
import 'package:test/test.dart';

const _package = 'luthor_generator';
const _fixtureLibrary = 'profile.dart';

Future<TestBuilderResult> runBuilder(String source) {
  return runBuilderOn({_fixtureLibrary: source});
}

Future<TestBuilderResult> runBuilderOn(Map<String, String> libraries) async {
  final readerWriter = TestReaderWriter(rootPackage: _package);
  await readerWriter.testing.loadIsolateSources();
  return testBuilder(
    luthorBuilder(BuilderOptions.empty),
    {
      for (final MapEntry(:key, :value) in libraries.entries)
        '$_package|lib/$key': value,
    },
    rootPackage: _package,
    readerWriter: readerWriter,
    flattenOutput: true,
  );
}

Future<GenerationResult> generateSharedPart(String source) async {
  final parts = await generateSharedParts({_fixtureLibrary: source});
  return GenerationResult(parts[_fixtureLibrary] ?? '');
}

Future<Map<String, String>> generateSharedParts(
  Map<String, String> libraries,
) async {
  final result = await runBuilderOn(libraries);
  expect(result.errors, isEmpty, reason: result.errors.join('\n'));
  return {
    for (final library in libraries.keys)
      if (result.outputs.contains(_partAsset(library)))
        library: result.readerWriter.testing.readString(_partAsset(library)),
  };
}

Future<String> generationErrors(String source) async {
  final result = await runBuilder(source);
  return result.errors.join('\n');
}

Future<void> expectGeneratedCodeCompiles(String source) {
  return expectGeneratedLibrariesCompile({_fixtureLibrary: source});
}

Future<void> expectGeneratedLibrariesCompile(
  Map<String, String> libraries,
) async {
  final files = await _librariesWithParts(libraries);
  final library = await resolveSources(
    {
      for (final MapEntry(:key, :value) in files.entries)
        '$_package|lib/$key': value,
    },
    (resolver) =>
        resolver.libraryFor(AssetId(_package, 'lib/${libraries.keys.first}')),
    readAllSourcesFromFilesystem: true,
  );

  final errors = <Diagnostic>[];
  for (final path in files.keys) {
    final result =
        await library.session.getErrors('/$_package/lib/$path') as ErrorsResult;
    errors.addAll(
      result.diagnostics.where((error) => error.severity == Severity.error),
    );
  }

  expect(
    errors,
    isEmpty,
    reason: errors.map((error) => error.toString()).join('\n'),
  );
}

Future<Map<String, Object?>> evaluateGenerated(
  String source,
  Map<String, String> expressions,
) {
  return evaluateGeneratedLibraries({_fixtureLibrary: source}, expressions);
}

Future<Map<String, Object?>> evaluateGeneratedLibraries(
  Map<String, String> libraries,
  Map<String, String> expressions,
) async {
  final files = await _librariesWithParts(libraries);
  final directory = await Directory.systemTemp.createTemp('luthor_generator');
  try {
    for (final MapEntry(:key, :value) in files.entries) {
      final file = File('${directory.path}/$key');
      await file.parent.create(recursive: true);
      await file.writeAsString(value);
    }
    final runner = File('${directory.path}/runner.dart');
    await runner.writeAsString(_runnerSource(libraries.keys, expressions));

    final messages = ReceivePort();
    final errors = ReceivePort();
    await Isolate.spawnUri(
      runner.uri,
      const [],
      messages.sendPort,
      onError: errors.sendPort,
      packageConfig: await Isolate.packageConfig,
    );
    final outcome = await Future.any([
      messages.first,
      errors.first.then((error) => throw StateError('$error')),
    ]);
    messages.close();
    errors.close();
    return (jsonDecode(outcome as String) as Map).cast<String, Object?>();
  } finally {
    await directory.delete(recursive: true);
  }
}

void expectOutputContains(String output, String expected) {
  expect(_compact(output), matches(_snippetPattern(expected)));
}

void expectOutputLacks(String output, String unexpected) {
  expect(_compact(output), isNot(matches(_snippetPattern(unexpected))));
}

String _compact(String value) => value
    .replaceAll(RegExp(r'\s+'), '')
    .replaceAll(RegExp(r',(?=[)\]}])'), '');

RegExp _snippetPattern(String snippet) {
  final compact = _compact(snippet);
  if (!compact.endsWith(',')) return RegExp(RegExp.escape(compact));
  final body = RegExp.escape(compact.substring(0, compact.length - 1));
  return RegExp('$body(?:,|(?=[)\\]}]))');
}

AssetId _partAsset(String library) {
  final stem = library.substring(0, library.length - '.dart'.length);
  return AssetId(_package, 'lib/$stem.luthor.g.part');
}

Future<Map<String, String>> _librariesWithParts(
  Map<String, String> libraries,
) async {
  final parts = await generateSharedParts(libraries);
  final files = <String, String>{...libraries};
  for (final MapEntry(key: library, value: source) in libraries.entries) {
    final partDirective = RegExp(r'''part '([^']+\.g\.dart)';''');
    final match = partDirective.firstMatch(source);
    if (match == null) continue;
    final partPath = _sibling(library, match.group(1)!);
    final libraryName = library.split('/').last;
    files[partPath] = "part of '$libraryName';\n${parts[library] ?? ''}";
  }
  return files;
}

String _sibling(String library, String relative) {
  final slash = library.lastIndexOf('/');
  return slash == -1 ? relative : '${library.substring(0, slash)}/$relative';
}

String _runnerSource(
  Iterable<String> libraries,
  Map<String, String> expressions,
) {
  final imports = libraries.map((library) => "import '$library';").join('\n');
  final evaluations = expressions.entries
      .map(
        (entry) =>
            '''
  try {
    results[${jsonEncode(entry.key)}] = _describe(${entry.value});
  } catch (error) {
    results[${jsonEncode(entry.key)}] = 'threw \${error.runtimeType}';
  }''',
      )
      .join('\n');
  return '''
// ignore_for_file: unused_import
import 'dart:convert';
import 'dart:isolate';

import 'package:luthor/luthor.dart';

$imports

Object? _describe(Object? value) => switch (value) {
  SchemaValidationSuccess() => 'success',
  SchemaValidationError(:final errors) => errors,
  _ => value,
};

void main(List<String> args, SendPort port) {
  final results = <String, Object?>{};
$evaluations
  port.send(jsonEncode(results));
}
''';
}

class GenerationResult {
  const GenerationResult(this.output);

  final String output;
}
