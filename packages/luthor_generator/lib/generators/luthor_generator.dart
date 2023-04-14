import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:luthor_annotation/luthor_annotation.dart';
import 'package:luthor_generator/helpers/validations/base_validations.dart';
import 'package:luthor_generator/helpers/string_extension.dart';
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

    final constructor =
        element.constructors.firstWhereOrNull((c) => c.isFactory);
    if (constructor == null) {
      throw InvalidGenerationSourceError(
        'Luthor can only be applied to classes with a factory constructor.',
        element: element,
      );
    }

    final name = element.name.pascalToCamelCase();
    final params = constructor.parameters;

    final buffer = StringBuffer();
    buffer.write('Validator ${name}Schema = l.schema({\n');

    for (final param in params) {
      buffer.write("'${param.name}': l");
      buffer.write(getValidations(param));
      buffer.write(',\n');
    }

    buffer.write('});');

    return buffer.toString();
  }
}
