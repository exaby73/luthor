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

    final hasFromJsonCtor = element.constructors.any(
      (element) => element.isFactory && element.name == 'fromJson',
    );
    if (!hasFromJsonCtor) {
      throw InvalidGenerationSourceError(
        'Luthor can only be applied to classes with a factory fromJson constructor',
        element: element,
      );
    }

    final params = constructor.parameters;
    final buffer = StringBuffer();
    buffer.write('Validator \$${name}Schema = l.schema({\n');

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

    _writeValidateMethod(buffer, name);

    _writeExtension(buffer, name);

    return buffer.toString();
  }

  void _writeValidateMethod(StringBuffer buffer, String name) {
    buffer.write(
      'SchemaValidationResult<$name> \$${name}Validate(Map<String, dynamic> json) => '
      '\$${name}Schema.validateSchema(json, fromJson: $name.fromJson);',
    );
  }

  void _writeExtension(StringBuffer buffer, String name) {
    buffer.write(
      '\n\nextension ${name}ValidationExtension on $name {\n'
      '  SchemaValidationResult<$name> validateSelf() => \$${name}Validate(toJson());\n'
      '}\n',
    );
  }
}
