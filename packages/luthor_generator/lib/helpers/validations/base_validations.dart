// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:luthor_generator/checkers.dart';
import 'package:luthor_generator/errors/unsupported_type_error.dart';
import 'package:luthor_generator/helpers/validations/custom_validations.dart';
import 'package:luthor_generator/helpers/validations/double_validations.dart';
import 'package:luthor_generator/helpers/validations/int_validations.dart';
import 'package:luthor_generator/helpers/validations/number_validations.dart';
import 'package:luthor_generator/helpers/validations/string_validations.dart';
import 'package:source_gen/source_gen.dart';

// Global context for tracking discovered classes during generation
class GenerationContext {
  const GenerationContext._();

  static final Set<ClassElement2> discoveredClasses = {};
  static Set<String>? typedefVisitedTypes;

  static void reset() {
    discoveredClasses.clear();
    typedefVisitedTypes = null;
  }

  static void addDiscoveredClass(ClassElement2 element) {
    discoveredClasses.add(element);
  }
}

String getValidations(
  FormalParameterElement param, {
  ClassElement2? enclosingClass,
}) {
  final buffer = StringBuffer();
  bool hasForwardRef = false;

  final isNullable = param.type.nullabilitySuffix == NullabilitySuffix.question;

  if (param.type is DynamicType) {
    buffer.write('l.any()');
  }

  if (param.type.isDartCoreBool) {
    buffer.write('l.boolean()');
  }

  if (param.type.isDartCoreDouble) {
    buffer.write('l.double()');
    buffer.write(getDoubleValidations(param));
  }

  if (param.type.isDartCoreInt) {
    buffer.write('l.int()');
    buffer.write(getIntValidations(param));
  }

  if (param.type.isDartCoreList) {
    _writeListValidations(buffer, param, enclosingClass: enclosingClass);
  }

  if (param.type.isDartCoreMap) {
    _writeMapValidations(buffer, param, enclosingClass: enclosingClass);
  }

  if (param.type.isDartCoreNull) {
    buffer.write('l.nullValue()');
  }

  if (param.type.isDartCoreNum) {
    buffer.write('l.number()');
    buffer.write(getNumberValidations(param));
  }

  if (param.type.isDartCoreString ||
      param.type.getDisplayString().replaceFirst('?', '') == 'DateTime') {
    buffer.write('l.string()');
    buffer.write(getStringValidations(param));
  }

  if (buffer.isEmpty) {
    hasForwardRef = _checkAndAddCustomSchema(
      buffer,
      param,
      enclosingClass: enclosingClass,
    );
  }

  getCustomValidations(param, buffer);

  final hasDefaultAnnotation = getAnnotation(defaultChecker, param) != null;
  if (param.type is! DynamicType && !isNullable && !hasDefaultAnnotation) {
    buffer.write('.required()');
  }

  // Close forwardRef if it was opened
  if (hasForwardRef) {
    buffer.write(')');
  }

  return buffer.toString();
}

bool _checkAndAddCustomSchema(
  StringBuffer buffer,
  FormalParameterElement param, {
  ClassElement2? enclosingClass,
}) {
  final element = param.type.element3;
  if (element == null) {
    throw UnsupportedTypeError(
      'Cannot determine type of ${param.type.getDisplayString()}',
    );
  }

  // Check if the parameter has @luthorForwardRef annotation
  final hasForwardRefAnnotation =
      getAnnotation(luthorForwardRefChecker, param) != null;

  final isSelfReference = _hasSelfReferenceInType(param.type, enclosingClass);

  final shouldUseForwardRef = hasForwardRefAnnotation || isSelfReference;

  final hasLuthorAnnotation = getAnnotation(luthorChecker, element) != null;

  final schemaName =
      '\$${param.type.getDisplayString().replaceFirst('?', '')}Schema';

  if (hasLuthorAnnotation) {
    // Class has @luthor annotation, use existing logic
    if (shouldUseForwardRef) {
      buffer.write('forwardRef(() => $schemaName');
      return true;
    } else {
      buffer.write(schemaName);
      return false;
    }
  } else if (element is ClassElement2 &&
      isCompatibleForAutoGeneration(element)) {
    // Class is compatible for auto-generation, add to discovered classes
    GenerationContext.addDiscoveredClass(element);
    if (shouldUseForwardRef) {
      buffer.write('forwardRef(() => $schemaName');
      return true;
    } else {
      buffer.write(schemaName);
      return false;
    }
  } else {
    throw UnsupportedTypeError(
      'Type ${param.type.getDisplayString()} does not have @luthor annotation and is not compatible for auto-generation. '
      'To make it compatible, ensure it has:\n'
      '1. A constructor with named parameters\n'
      '2. A fromJson factory constructor OR @MappableClass annotation',
    );
  }
}

bool _hasSelfReferenceInType(DartType type, ClassElement2? enclosingClass) {
  if (enclosingClass == null) return false;

  // Check direct type match
  final element = type.element3;
  if (element is ClassElement2 && identical(element, enclosingClass)) {
    return true;
  }

  // Check generic type parameters
  if (type is ParameterizedType) {
    final typeArgs = type.typeArguments;
    for (final typeArg in typeArgs) {
      // Recursively check if any generic type parameter matches
      if (_hasSelfReferenceInType(typeArg, enclosingClass)) {
        return true;
      }
    }
  }

  return false;
}

DartObject? getAnnotation(TypeChecker checker, Element2 field) {
  return checker.firstAnnotationOf(field);
}

/// Gets the qualified function name for use in generated code.
/// Returns 'ClassName.methodName' for static methods, or just 'functionName' for top-level functions.
String getQualifiedFunctionName(ExecutableElement function) {
  final enclosingElement = function.enclosingElement3;
  if (enclosingElement is InterfaceElement && function.isStatic) {
    return '${enclosingElement.name}.${function.name}';
  }
  return function.name;
}

/// Checks if a class is compatible for auto-generation
bool isCompatibleForAutoGeneration(ClassElement2 element) {
  // Must have at least one constructor
  if (element.constructors2.isEmpty) {
    return false;
  }

  // Check if has fromJson factory constructor OR is dart_mappable
  final hasFromJson = element.constructors2.any(
    (ctor) => ctor.isFactory && ctor.name3 == 'fromJson',
  );
  final isDartMappable = getAnnotation(dartMappableChecker, element) != null;

  if (!hasFromJson && !isDartMappable) {
    return false;
  }

  // Check if has constructor with named parameters
  final hasNamedParameters = element.constructors2.any(
    (ctor) => ctor.formalParameters.any((p) => p.isNamed),
  );

  return hasNamedParameters;
}

void _writeListValidations(
  StringBuffer buffer,
  FormalParameterElement param, {
  ClassElement2? enclosingClass,
}) {
  buffer.write('l.list(validators: [');

  // Check if the parameter has @luthorForwardRef annotation
  final hasForwardRefAnnotation =
      getAnnotation(luthorForwardRefChecker, param) != null;

  // Auto-detect self-reference: extract list element type and check if it matches enclosing class
  final isSelfReference = _hasSelfReferenceInType(param.type, enclosingClass);

  final shouldUseForwardRef = hasForwardRefAnnotation || isSelfReference;

  // Use proper analyzer API to extract list element type
  if (param.type is ParameterizedType) {
    final parameterizedType = param.type as ParameterizedType;
    final typeArgs = parameterizedType.typeArguments;

    if (typeArgs.isNotEmpty) {
      final elementType = typeArgs.first;

      // Create a mock ParameterElement for the list element type
      // to reuse getValidations logic
      final elementValidation = _getValidationForType(
        elementType,
        shouldUseForwardRef,
      );
      buffer.write(elementValidation);
    } else {
      // Fallback for List without type argument (raw List)
      buffer.write('l.any()');
    }
  } else {
    // Fallback for non-parameterized types
    buffer.write('l.any()');
  }

  buffer.write('])');
}

void _writeMapValidations(
  StringBuffer buffer,
  FormalParameterElement param, {
  ClassElement2? enclosingClass,
}) {
  buffer.write('l.map(');

  final keyValidatorBuffer = StringBuffer();
  final valueValidatorBuffer = StringBuffer();

  // Check if the parameter has @luthorForwardRef annotation
  final hasForwardRefAnnotation =
      getAnnotation(luthorForwardRefChecker, param) != null;

  // Auto-detect self-reference: extract map value type and check if it matches enclosing class
  final isSelfReference = _hasSelfReferenceInType(param.type, enclosingClass);
  final shouldUseForwardRef = hasForwardRefAnnotation || isSelfReference;

  // Extract key and value types from Map<K, V>
  if (param.type is ParameterizedType) {
    final parameterizedType = param.type as ParameterizedType;
    final typeArgs = parameterizedType.typeArguments;

    if (typeArgs.length >= 2) {
      final keyType = typeArgs[0];
      final valueType = typeArgs[1];

      // Generate key validator
      // _getValidationForType already handles .required() internally
      keyValidatorBuffer.write(_getValidationForType(keyType));

      // Generate value validator
      // _getValidationForType already handles .required() and forwardRef closing internally
      valueValidatorBuffer.write(
        _getValidationForType(valueType, shouldUseForwardRef),
      );
    } else {
      // Fallback for raw Map or Map without type arguments
      keyValidatorBuffer.write('l.any()');
      valueValidatorBuffer.write('l.any()');
    }
  } else {
    // Fallback for non-parameterized Map type
    keyValidatorBuffer.write('l.any()');
    valueValidatorBuffer.write('l.any()');
  }

  // Write the map() call with validators
  buffer.write('keyValidator: ');
  buffer.write(keyValidatorBuffer.toString());
  buffer.write(', valueValidator: ');
  buffer.write(valueValidatorBuffer.toString());
  buffer.write(')');
}

String _getValidationForType(DartType type, [bool useForwardRef = false]) {
  final buffer = StringBuffer();

  final isNullable = type.nullabilitySuffix == NullabilitySuffix.question;

  if (type is DynamicType) {
    buffer.write('l.any()');
  } else if (type.isDartCoreBool) {
    buffer.write('l.boolean()');
  } else if (type.isDartCoreDouble) {
    buffer.write('l.double()');
  } else if (type.isDartCoreInt) {
    buffer.write('l.int()');
  } else if (type.isDartCoreList) {
    // Handle nested lists
    if (type is ParameterizedType) {
      final nestedTypeArgs = type.typeArguments;
      if (nestedTypeArgs.isNotEmpty) {
        final nestedElementType = nestedTypeArgs.first;
        final nestedValidation = _getValidationForType(nestedElementType);
        buffer.write('l.list(validators: [$nestedValidation])');
      } else {
        buffer.write('l.list(validators: [l.any()])');
      }
    } else {
      buffer.write('l.list(validators: [l.any()])');
    }
  } else if (type.isDartCoreMap) {
    buffer.write('l.map()');
  } else if (type.isDartCoreNull) {
    buffer.write('l.nullValue()');
  } else if (type.isDartCoreNum) {
    buffer.write('l.number()');
  } else if (type.isDartCoreString ||
      type.getDisplayString().replaceFirst('?', '') == 'DateTime') {
    buffer.write('l.string()');
  } else {
    // Handle custom types with @luthor annotation or auto-generation
    final element = type.element3;
    if (element != null) {
      final hasLuthorAnnotation = getAnnotation(luthorChecker, element) != null;

      if (hasLuthorAnnotation) {
        final schemaName =
            '\$${type.getDisplayString().replaceFirst('?', '')}Schema';
        if (useForwardRef) {
          buffer.write('forwardRef(() => $schemaName');
        } else {
          buffer.write(schemaName);
        }
      } else if (element is ClassElement2 &&
          isCompatibleForAutoGeneration(element)) {
        // Class is compatible for auto-generation, add to discovered classes
        GenerationContext.addDiscoveredClass(element);
        final schemaName =
            '\$${type.getDisplayString().replaceFirst('?', '')}Schema';
        if (useForwardRef) {
          buffer.write('forwardRef(() => $schemaName');
        } else {
          buffer.write(schemaName);
        }
      } else {
        throw UnsupportedTypeError(
          'Type ${type.getDisplayString()} does not have @luthor annotation and is not compatible for auto-generation. '
          'To make it compatible, ensure it has:\n'
          '1. A constructor with named parameters\n'
          '2. A fromJson factory constructor OR @MappableClass annotation',
        );
      }
    } else {
      throw UnsupportedTypeError(
        'Cannot determine type of ${type.getDisplayString()}',
      );
    }
  }

  // Add required() if not nullable and not dynamic
  // If useForwardRef, add required inside the forwardRef callback before closing
  if (type is! DynamicType && !isNullable) {
    buffer.write('.required()');
  }

  // Close forwardRef if it was opened
  if (useForwardRef) {
    final element = type.element3;
    if (element != null) {
      final hasLuthorAnnotation = getAnnotation(luthorChecker, element) != null;
      final isAutoGenerated =
          element is ClassElement2 && isCompatibleForAutoGeneration(element);
      if (hasLuthorAnnotation || isAutoGenerated) {
        buffer.write(')');
      }
    }
  }

  return buffer.toString();
}
