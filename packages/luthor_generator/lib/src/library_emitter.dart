import 'package:analyzer/dart/element/element.dart';
import 'package:luthor_generator/src/checkers.dart';
import 'package:luthor_generator/src/dart_source.dart';
import 'package:luthor_generator/src/field_validators.dart';
import 'package:luthor_generator/src/library_plan.dart';
import 'package:luthor_generator/src/model.dart';
import 'package:luthor_generator/src/runtime_api.dart' as runtime;

const _jsonMapHelper = r'_$luthorJsonMap';
const _jsonValueHelper = r'_$luthorJsonValue';
const _ownKey = r'$key';

final class LibraryEmitter {
  LibraryEmitter(this.plan) : _validators = FieldValidators(plan);

  final LibraryPlan plan;
  final FieldValidators _validators;
  final _buffer = StringBuffer();
  var _usesJsonHelpers = false;

  void writeModel(Model model) {
    final name = model.name;
    final schemaKeys = '${name}SchemaKeys';
    final schemaName = LibraryPlan.publicSchemaName(name);
    final validateName = '\$${name}Validate';

    _buffer
      ..writeln('// ignore: constant_identifier_names')
      ..writeln('const $schemaKeys = (')
      ..writeAll([
        for (final field in model.fields)
          '  ${field.name}: ${dartStringLiteral(field.key)},\n',
      ])
      ..writeln(');')
      ..writeln()
      ..writeln(
        runtime.schemaDeclaration(
          schemaName,
          _schema(model, (field) => '$schemaKeys.${field.name}'),
        ),
      )
      ..writeln()
      ..writeln(
        runtime.validateFunction(
          modelType: name,
          functionName: validateName,
          schemaName: schemaName,
          fromJson: switch (model.serializer) {
            ModelSerializer.mappable => '${name}Mapper.fromMap',
            ModelSerializer.json => '$name.fromJson',
          },
        ),
      )
      ..writeln();

    if (model.hasToJson) {
      final json = switch (model.serializer) {
        ModelSerializer.mappable => 'toMap()',
        ModelSerializer.json => '$_jsonMapHelper(toJson())',
      };
      _usesJsonHelpers |= model.serializer == ModelSerializer.json;
      _buffer
        ..writeln('extension ${name}ValidationExtension on $name {')
        ..writeln(
          '  ${runtime.validateSelf(modelType: name, validateFunction: validateName, json: json)}',
        )
        ..writeln('}')
        ..writeln();
    }

    _buffer
      ..writeln('// ignore: constant_identifier_names')
      ..writeln('const ${name}ErrorKeys = (')
      ..write(_errorKeys(model, '', {model.element}, '  '))
      ..writeln(');')
      ..writeln();
  }

  String emit() {
    final emitted = <ClassElement>{};
    while (true) {
      final pending = plan.autoSchemas.entries
          .where((entry) => !emitted.contains(entry.key))
          .toList();
      if (pending.isEmpty) break;
      for (final MapEntry(key: element, value: schemaName) in pending) {
        emitted.add(element);
        final model = plan.models.read(element);
        _buffer
          ..writeln(
            runtime.schemaDeclaration(
              schemaName,
              _schema(model, (field) => dartStringLiteral(field.key)),
            ),
          )
          ..writeln();
      }
    }
    if (_usesJsonHelpers) _buffer.write(_jsonHelpers);
    return _buffer.toString();
  }

  String _schema(Model model, String Function(ModelField field) keyOf) {
    return runtime.schema(model.name, [
      for (final field in model.fields)
        (keyOf(field), _validators.forField(field, model).emit()),
    ], passthrough: model.passthrough);
  }

  String _errorKeys(
    Model model,
    String prefix,
    Set<ClassElement> visiting,
    String indent,
  ) {
    final buffer = StringBuffer();
    for (final field in model.fields) {
      final path = prefix.isEmpty ? field.key : '$prefix.${field.key}';
      final nested = _nestedModel(field);
      if (nested == null || visiting.contains(nested.element)) {
        buffer.writeln('$indent${field.name}: ${dartStringLiteral(path)},');
        continue;
      }
      buffer
        ..writeln('$indent${field.name}: (')
        ..writeln('$indent  $_ownKey: ${dartStringLiteral(path)},')
        ..write(
          _errorKeys(nested, path, {...visiting, nested.element}, '$indent  '),
        )
        ..writeln('$indent),');
    }
    return buffer.toString();
  }

  Model? _nestedModel(ModelField field) {
    if (field.usesConverter) return null;
    final element = field.type.element;
    if (element is! ClassElement) return null;
    if (!luthorChecker.hasAnnotationOf(element) &&
        !ModelReader.isSerializable(element)) {
      return null;
    }
    return plan.models.read(element);
  }
}

const _jsonHelpers =
    '''
Map<String, Object?> $_jsonMapHelper(Map<Object?, Object?> map) => {
  for (final entry in map.entries)
    entry.key.toString(): $_jsonValueHelper(entry.value),
};

Object? $_jsonValueHelper(Object? value) {
  if (value == null || value is String || value is num || value is bool) {
    return value;
  }
  if (value is Map) return $_jsonMapHelper(value);
  if (value is Iterable) {
    return [for (final item in value) $_jsonValueHelper(item)];
  }
  try {
    // ignore: avoid_dynamic_calls
    return $_jsonValueHelper((value as dynamic).toJson());
    // ignore: avoid_catching_errors
  } on NoSuchMethodError {
    return value;
  }
}
''';
