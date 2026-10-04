import 'package:analyzer/dart/constant/value.dart';
import 'package:source_gen/source_gen.dart';

typedef KeyNaming = String Function(String fieldName);

String identityNaming(String fieldName) => fieldName;

KeyNaming jsonSerializableNaming(DartObject? fieldRename) {
  return switch (fieldRename?.variable?.name) {
    'snake' => (name) => _separateWords(name, '_'),
    'kebab' => (name) => _separateWords(name, '-'),
    'screamingSnake' => (name) => _separateWords(name, '_').toUpperCase(),
    'pascal' =>
      (name) => name.isEmpty ? name : name[0].toUpperCase() + name.substring(1),
    _ => identityNaming,
  };
}

KeyNaming mappableNaming(DartObject? caseStyle) {
  if (caseStyle == null || caseStyle.isNull) return identityNaming;
  final style = ConstantReader(caseStyle);
  final head = style.peek('head')?.objectValue.variable?.name;
  final tail = style.peek('tail')?.objectValue.variable?.name;
  final separator = style.peek('separator')?.stringValue ?? '';
  return (name) {
    final words = name.split(_mappableWordBoundary);
    final transformed = [
      for (final (index, word) in words.indexed)
        _transform(index == 0 && head != null ? head : tail, word),
    ];
    return transformed.join(separator);
  };
}

final _upperCase = RegExp('[A-Z]');
final _mappableWordBoundary = RegExp(r'[ ./_\-\\]+|(?<=[a-z])(?=[A-Z])');

String _separateWords(String name, String separator) {
  return name.replaceAllMapped(_upperCase, (match) {
    final lower = match.group(0)!.toLowerCase();
    return match.start > 0 ? '$separator$lower' : lower;
  });
}

String _transform(String? transform, String word) {
  return switch (transform) {
    'upperCase' => word.toUpperCase(),
    'lowerCase' => word.toLowerCase(),
    'capitalCase' when word.isNotEmpty =>
      word[0].toUpperCase() + word.substring(1).toLowerCase(),
    _ => word,
  };
}
