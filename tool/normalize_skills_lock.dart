import 'dart:convert';
import 'dart:io';

/// Rewrites absolute local skill sources in `skills-lock.json` to paths
/// relative to the current directory, so the lock file is portable.
///
/// The workspace root package has no dependencies, so this script uses only
/// `dart:io`.
void main() {
  final lockFile = File('skills-lock.json');
  if (!lockFile.existsSync()) {
    return;
  }

  final lock = jsonDecode(lockFile.readAsStringSync()) as Map<String, dynamic>;
  final skills = lock['skills'] as Map<String, dynamic>? ?? {};
  final base = _segments(Directory.current.absolute.path);
  var changed = false;

  for (final skill in skills.values.cast<Map<String, dynamic>>()) {
    final source = skill['source'];
    if (source is! String || !_isAbsolute(source)) {
      continue;
    }

    skill['source'] = _relative(_segments(source), base);
    changed = true;
  }

  if (changed) {
    lockFile.writeAsStringSync(
      '${const JsonEncoder.withIndent('  ').convert(lock)}\n',
    );
  }
}

final _absolutePath = RegExp(r'^([A-Za-z]:)?[\\/]');

bool _isAbsolute(String path) => _absolutePath.hasMatch(path);

List<String> _segments(String path) => [
  for (final segment in path.replaceAll(r'\', '/').split('/'))
    if (segment.isNotEmpty && segment != '.') segment,
];

bool _same(String a, String b) =>
    Platform.isWindows ? a.toLowerCase() == b.toLowerCase() : a == b;

/// Returns [target] relative to [base] as a POSIX path that starts with `./`
/// or `../`.
String _relative(List<String> target, List<String> base) {
  var common = 0;
  while (common < target.length &&
      common < base.length &&
      _same(target[common], base[common])) {
    common++;
  }

  final up = base.length - common;
  return [
    if (up == 0) '.',
    for (var i = 0; i < up; i++) '..',
    ...target.skip(common),
  ].join('/');
}
