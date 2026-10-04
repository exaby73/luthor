import 'package:analyzer/dart/element/element.dart';
import 'package:luthor_generator/src/checkers.dart';
import 'package:luthor_generator/src/dart_source.dart';
import 'package:luthor_generator/src/field_validators.dart';
import 'package:luthor_generator/src/library_plan.dart';
import 'package:luthor_generator/src/model.dart';
import 'package:luthor_generator/src/runtime_api.dart' as runtime;

final class LibraryEmitter {
  LibraryEmitter(this.plan) : _validators = FieldValidators(plan);

  final LibraryPlan plan;
  final FieldValidators _validators;
  final _buffer = StringBuffer();

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
        'final ${runtime.validatorType} $schemaName = ${_schema(model, (field) => '$schemaKeys.${field.name}')};',
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
      ..writeln()
      ..writeln('extension ${name}ValidationExtension on $name {')
      ..writeln(
        '  ${runtime.validateSelf(modelType: name, validateFunction: validateName, json: switch (model.serializer) {
          ModelSerializer.mappable => 'toMap()',
          ModelSerializer.json => 'toJson()',
        })}',
      )
      ..writeln('}')
      ..writeln()
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
            'final ${runtime.validatorType} $schemaName = ${_schema(model, (field) => dartStringLiteral(field.key))};',
          )
          ..writeln();
      }
    }
    return _buffer.toString();
  }

  String _schema(Model model, String Function(ModelField field) keyOf) {
    return runtime.schema(model.name, [
      for (final field in model.fields)
        (keyOf(field), _validators.forField(field, model).emit()),
    ]);
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
