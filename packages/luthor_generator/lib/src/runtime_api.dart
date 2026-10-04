import 'package:luthor_generator/src/dart_source.dart';
import 'package:luthor_generator/src/validator_expr.dart';

const schemaValidatorType = 'SchemaValidator';
const resultType = 'ValidationResult';

String typeEntry(EntryType type, [List<String> arguments = const []]) {
  return 'l.${type.method}(${arguments.join(', ')})';
}

String schemaDeclaration(String schemaName, String schema) {
  return 'final $schemaValidatorType $schemaName = $schema;';
}

String schema(
  String name,
  Iterable<(String, String)> fields, {
  bool passthrough = false,
}) {
  final entries = fields.map((field) => '  ${field.$1}: ${field.$2},\n');
  return 'l.schema({\n${entries.join()}})'
      '${passthrough ? '.passthrough()' : ''}'
      '.withName(${dartStringLiteral(name)})';
}

String validator(ValidatorExpr expr) {
  final chain = '${expr.modifiers.join()}${expr.required ? '.required()' : ''}';
  return switch (expr.base) {
    TypeEntry(:final type, :final arguments) =>
      '${typeEntry(type, arguments)}$chain',
    AllowedValues(:final literals) => 'l.oneOf([${literals.join(', ')}])$chain',
    ListOf(:final element) => 'l.list(${validator(element)})$chain',
    MapOf(:final key, :final value) =>
      'l.map(keyValidator: ${validator(key)}, valueValidator: ${validator(value)})$chain',
    SchemaRef(:final reference) => 'forwardRef(() => $reference$chain)',
  };
}

String modifier(String method, List<String> arguments) {
  return '.$method(${arguments.join(', ')})';
}

String dateTime() => modifier('dateTime', const []);

String regExp(String pattern, Map<String, bool> flags) {
  return 'RegExp(${[dartRawStringLiteral(pattern), for (final MapEntry(:key, :value) in flags.entries) '$key: $value'].join(', ')})';
}

String parsableKey(String parser, String description) {
  return modifier('custom', [
    '(key) => $parser.tryParse(key) != null',
    'message: ${dartStringLiteral('must be a string containing $description')}',
  ]);
}

String validateFunction({
  required String modelType,
  required String functionName,
  required String schemaName,
  required String fromJson,
}) {
  return '$resultType<$modelType> $functionName(Object? json) => '
      '$schemaName.validateSchema(json, fromJson: $fromJson);';
}

String validateSelf({
  required String modelType,
  required String validateFunction,
  required String json,
}) {
  return '$resultType<$modelType> validateSelf() => $validateFunction($json);';
}

enum EntryType {
  string('string'),
  int('int'),
  double('double'),
  number('num'),
  boolean('bool'),
  any('any'),
  file('file'),
  nullValue('nullValue');

  const EntryType(this.method);

  final String method;
}
