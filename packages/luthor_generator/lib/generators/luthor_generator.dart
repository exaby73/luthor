import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:luthor/luthor.dart';
import 'package:luthor_generator/checkers.dart';
import 'package:luthor_generator/helpers/validations/base_validations.dart';
import 'package:source_gen/source_gen.dart';

class LuthorGenerator extends GeneratorForAnnotation<Luthor> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Luthor can only be applied to classes.',
        element: element,
      );
    }

    if (element.constructors.isEmpty) {
      throw InvalidGenerationSourceError(
        'Luthor can only be applied to classes with at least one constructor.',
        element: element,
      );
    }

    final name = element.name;
    final constructor = element.constructors.first;

    final isDartMappableClass =
        getAnnotation(dartMappableChecker, element) != null;
    final hasFromJsonCtor = element.constructors.any(
      (element) => element.isFactory && element.name == 'fromJson',
    );
    if (!hasFromJsonCtor && !isDartMappableClass) {
      throw InvalidGenerationSourceError(
        'Luthor can only be applied to classes with a factory fromJson constructor',
        element: element,
      );
    }

    final params = constructor.parameters;
    final buffer = StringBuffer();
    buffer.write("Validator \$${name}Schema = l.withName('$name').schema({\n");

    for (final param in params) {
      var name = param.name;
      final jsonKeyName = jsonKeyChecker
          .firstAnnotationOf(param)
          ?.getField('name')
          ?.toStringValue();

      if (jsonKeyName != null) {
        name = jsonKeyName;
      }

      buffer.write("'$name': ");
      buffer.write(getValidations(param));
      buffer.write(',\n');
    }

    buffer.write('});\n\n');

    _writeValidateMethod(buffer, name, isDartMappable: isDartMappableClass);

    _writeExtension(buffer, name, isDartMappable: isDartMappableClass);

    return buffer.toString();
  }

  void _writeValidateMethod(
    StringBuffer buffer,
    String name, {
    required bool isDartMappable,
  }) {
    late final String fromJsonString;
    if (isDartMappable) {
      fromJsonString = '${name}Mapper.fromMap';
    } else {
      fromJsonString = '$name.fromJson';
    }
    buffer.write(
      'SchemaValidationResult<$name> \$${name}Validate(Map<String, dynamic> json) => '
      '\$${name}Schema.validateSchema(json, fromJson: $fromJsonString);',
    );
  }

  void _writeExtension(
    StringBuffer buffer,
    String name, {
    required bool isDartMappable,
  }) {
    late final String toJsonString;
    if (isDartMappable) {
      toJsonString = 'toMap()';
    } else {
      toJsonString = 'toJson()';
    }
    buffer.write(
      '\n\nextension ${name}ValidationExtension on $name {\n'
      '  SchemaValidationResult<$name> validateSelf() => \$${name}Validate($toJsonString);\n'
      '}\n',
    );
  }
}
