// Copies the LuthorGenerator section of every lib/*.g.dart into
// website/src/data/generated/<name>.g.dart, so the docs embed real output.
import 'dart:io';

void main() {
  final outDir = Directory('../../src/data/generated')..createSync(recursive: true);
  for (final file in Directory('lib').listSync().whereType<File>()) {
    if (!file.path.endsWith('.g.dart')) continue;
    final text = file.readAsStringSync();
    final marker = '// LuthorGenerator\n// ' + '*' * 74 + '\n';
    final start = text.indexOf(marker);
    if (start < 0) continue;
    var body = text.substring(start + marker.length).trim();
    // Drop the shared toJson helpers; they are the same in every file.
    final helpers = body.indexOf('Map<String, Object?> _\$luthorJsonMap');
    if (helpers > 0) body = body.substring(0, helpers).trim();
    final name = file.uri.pathSegments.last;
    File('${outDir.path}/$name').writeAsStringSync('$body\n');
    stdout.writeln('extracted $name');
  }
}
