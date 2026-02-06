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
    // Reset the generation context for each annotated element
    GenerationContext.reset();
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

    final params = constructor.formalParameters;
    final buffer = StringBuffer();

    // Generate SchemaKeys first (needed by schema)
    _writeSchemaKeysRecord(buffer, name!, constructor);

    // Generate schema using SchemaKeys
    buffer.write(
      "\nValidator \$${name}Schema = l.withName('$name').schema({\n",
    );

    for (final param in params) {
      final fieldName = param.name;
      buffer.write("  ${name}SchemaKeys.$fieldName: ");
      buffer.write(getValidations(param, enclosingClass: element));
      buffer.write(',\n');
    }

    buffer.write('});\n\n');

    _writeValidateMethod(buffer, name, isDartMappable: isDartMappableClass);

    _writeExtension(buffer, name, isDartMappable: isDartMappableClass);

    _writeErrorKeysRecord(buffer, name, constructor);

    // Generate schemas for discovered classes
    final discoveredSchemas = _generateDiscoveredSchemas();
    if (discoveredSchemas.isNotEmpty) {
      buffer.write('\n\n// Auto-generated schemas for discovered classes\n');
      buffer.write(discoveredSchemas);
    }

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

  void _writeSchemaKeysRecord(
    StringBuffer buffer,
    String name,
    ConstructorElement constructor,
  ) {
    buffer.write('\n\n');

    // Generate SchemaKeys constant
    buffer.write('// ignore: constant_identifier_names\n');
    buffer.write('const ${name}SchemaKeys = (\n');

    for (final param in constructor.formalParameters) {
      final fieldName = _getRecordFieldName(param.name!);
      final jsonKeyName = _getJsonKeyName(param);
      buffer.write('  $fieldName: "$jsonKeyName",\n');
    }

    buffer.write(');\n');
  }

  void _writeErrorKeysRecord(
    StringBuffer buffer,
    String name,
    ConstructorElement constructor,
  ) {
    buffer.write('\n\n');

    // Generate constant instance (no typedef)
    buffer.write('// ignore: constant_identifier_names\n');
    buffer.write('const ${name}ErrorKeys = (\n');
    final visitedTypesForValues = <String>{};
    _writeErrorKeysValues(
      buffer,
      constructor.formalParameters,
      '  ',
      '',
      visitedTypesForValues,
    );
    buffer.write(');\n');
  }

  void _writeErrorKeysValues(
    StringBuffer buffer,
    List<FormalParameterElement> parameters,
    String indent,
    String prefix,
    Set<String> visitedTypes,
  ) {
    for (final param in parameters) {
      final fieldName = _getRecordFieldName(param.name!);
      final jsonKeyName = _getJsonKeyName(param);
      final fullKey = prefix.isEmpty ? jsonKeyName : '$prefix.$jsonKeyName';
      final isNestedSchema = _isNestedSchema(param);

      if (isNestedSchema) {
        final nestedClass = _getNestedClassElement(param);
        if (nestedClass != null) {
          final className = nestedClass.name!;

          // Check for circular reference
          if (visitedTypes.contains(className)) {
            // For circular references, just provide the key as a string
            buffer.write('$indent$fieldName: "$fullKey",\n');
          } else {
            // Generate the nested record inline with prefixed keys
            visitedTypes.add(className);
            buffer.write('$indent$fieldName: (\n');
            _writeErrorKeysValues(
              buffer,
              nestedClass.constructors.first.formalParameters,
              '$indent  ',
              fullKey,
              visitedTypes,
            );
            buffer.write('$indent),\n');
            visitedTypes.remove(className);
          }
        }
      } else {
        buffer.write('$indent$fieldName: "$fullKey",\n');
      }
    }
  }

  String _getRecordFieldName(String paramName) {
    // Convert to camelCase for record field names
    return paramName;
  }

  String _getJsonKeyName(FormalParameterElement param) {
    final jsonKeyName = jsonKeyChecker
        .firstAnnotationOf(param)
        ?.getField('name')
        ?.toStringValue();
    return jsonKeyName ?? param.name!;
  }

  bool _isNestedSchema(FormalParameterElement param) {
    final element = param.type.element;
    if (element == null) return false;

    final hasLuthorAnnotation = getAnnotation(luthorChecker, element) != null;
    if (hasLuthorAnnotation) return true;

    if (element is ClassElement && isCompatibleForAutoGeneration(element)) {
      return true;
    }

    return false;
  }

  ClassElement? _getNestedClassElement(FormalParameterElement param) {
    final element = param.type.element;
    if (element is ClassElement) {
      final hasLuthorAnnotation = getAnnotation(luthorChecker, element) != null;
      if (hasLuthorAnnotation || isCompatibleForAutoGeneration(element)) {
        return element;
      }
    }
    return null;
  }

  /// Generates schema for a compatible class
  String _generateAutoSchema(ClassElement element, String className) {
    final constructor = element.constructors.first;
    final isDartMappableClass =
        getAnnotation(dartMappableChecker, element) != null;

    final buffer = StringBuffer();

    // Generate SchemaKeys first (needed by schema)
    _writeSchemaKeysRecord(buffer, className, constructor);

    // Generate schema using SchemaKeys
    buffer.write(
      "\nValidator \$${className}Schema = l.withName('$className').schema({\n",
    );

    for (final param in constructor.formalParameters) {
      final fieldName = param.name!;
      buffer.write("  ${className}SchemaKeys.$fieldName: ");
      buffer.write(getValidations(param, enclosingClass: element));
      buffer.write(',\n');
    }

    buffer.write('});\n\n');

    _writeValidateMethod(
      buffer,
      className,
      isDartMappable: isDartMappableClass,
    );
    _writeExtension(buffer, className, isDartMappable: isDartMappableClass);

    _writeErrorKeysRecord(buffer, className, constructor);

    return buffer.toString();
  }

  /// Generates schemas for all discovered classes
  String _generateDiscoveredSchemas() {
    final buffer = StringBuffer();
    final processedClasses = <String>{};

    // Process discovered classes iteratively to handle nested dependencies
    while (GenerationContext.discoveredClasses.isNotEmpty) {
      final currentClass = GenerationContext.discoveredClasses.first;
      GenerationContext.discoveredClasses.remove(currentClass);

      final className = currentClass.name!;

      // Skip if already processed
      if (processedClasses.contains(className)) {
        continue;
      }

      // Generate schema for this class
      buffer.write(_generateAutoSchema(currentClass, className));
      processedClasses.add(className);
    }

    return buffer.toString();
  }
}
