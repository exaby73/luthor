import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
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
    final constructor =
        element.constructors.firstWhereOrNull((c) => c.isFactory);
    if (constructor == null) {
      throw InvalidGenerationSourceError(
        'Luthor can only be applied to classes with a factory constructor.',
        element: element,
      );
    }

    final validateMethod = element.getMethod('validate');
    final isInvalidMethod = validateMethod == null ||
        !validateMethod.isStatic ||
        validateMethod.parameters.length != 1 ||
        validateMethod.parameters.first.type.toString() !=
            'Map<String, dynamic>' ||
        validateMethod.returnType.toString() != 'SchemaValidationResult<$name>';
    if (isInvalidMethod) {
      throw InvalidGenerationSourceError(
        'Luthor can only be applied to classes with a static validate method. '
        'Add the following code to your class:\n'
        'static SchemaValidationResult<$name> validate(Map<String, dynamic> json) => _\$${name}Validate(json);',
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
      'SchemaValidationResult<$name> _\$${name}Validate(Map<String, dynamic> json) => '
      '\$${name}Schema.validateSchema(json, fromJson: $name.fromJson);',
    );
  }

  void _writeExtension(StringBuffer buffer, String name) {
    buffer.write(
      '\n\nextension ${name}ValidationExtension on $name {\n'
      '  SchemaValidationResult<$name> validateSelf() => _\$${name}Validate(toJson());\n'
      '}\n',
    );
  }
}
