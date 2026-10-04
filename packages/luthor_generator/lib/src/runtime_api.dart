import 'package:luthor_generator/src/dart_source.dart';
import 'package:luthor_generator/src/validator_expr.dart';

const validatorType = 'Validator';
const schemaResultType = 'SchemaValidationResult';

String typeEntry(EntryType type, [List<String> arguments = const []]) {
  return 'l.${type.method}(${arguments.join(', ')})';
}

String schema(String name, Iterable<(String, String)> fields) {
  final entries = fields.map((field) => '  ${field.$1}: ${field.$2},\n');
  return 'l.withName(${dartStringLiteral(name)}).schema({\n${entries.join()}})';
}

String validator(ValidatorExpr expr) {
  final chain = '${expr.modifiers.join()}${expr.required ? '.required()' : ''}';
  return switch (expr.base) {
    TypeEntry(:final type, :final arguments) =>
      '${typeEntry(type, arguments)}$chain',
    ListOf(:final element) =>
      'l.list(validators: [${validator(element)}])$chain',
    MapOf(:final key, :final value) =>
      'l.map(keyValidator: ${validator(key)}, valueValidator: ${validator(value)})$chain',
    SchemaRef(:final reference) => 'forwardRef(() => $reference$chain)',
  };
}

String modifier(String method, List<String> arguments) {
  return '.$method(${arguments.join(', ')})';
}

String dateTime() => modifier('dateTime', const []);

String allowedValues(List<String> literals) {
  final values = literals.join(', ');
  final message = dartStringLiteral('must be one of ${literals.join(', ')}');
  return modifier('custom', [
    '(value) => value == null || const <Object?>[$values].contains(value)',
    'message: $message',
  ]);
}

String parsableKey(String parser, String description) {
  return modifier('custom', [
    '(value) => value is String && $parser.tryParse(value) != null',
    'message: ${dartStringLiteral('must be a string containing $description')}',
  ]);
}

String validateFunction({
  required String modelType,
  required String functionName,
  required String schemaName,
  required String fromJson,
}) {
  return '$schemaResultType<$modelType> $functionName(Map<String, dynamic> json) => '
      '$schemaName.validateSchema(json, fromJson: $fromJson);';
}

String validateSelf({
  required String modelType,
  required String validateFunction,
  required String json,
}) {
  return '$schemaResultType<$modelType> validateSelf() => $validateFunction($json);';
}

enum EntryType {
  string('string'),
  int('int'),
  double('double'),
  number('number'),
  boolean('boolean'),
  any('any'),
  file('file'),
  nullValue('nullValue');

  const EntryType(this.method);

  final String method;
}
