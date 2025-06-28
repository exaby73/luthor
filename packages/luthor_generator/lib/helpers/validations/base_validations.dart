import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
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

String getValidations(ParameterElement param) {
  final buffer = StringBuffer();

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
    _writeListValidations(buffer, param);
  }

  if (param.type.isDartCoreMap) {
    buffer.write('l.map()');
  }

  if (param.type.isDartCoreNull) {
    buffer.write('l.nullValue()');
  }

  if (param.type.isDartCoreNum) {
    buffer.write('l.number()');
    buffer.write(getNumberValidations(param));
  }

  if (param.type.isDartCoreString ||
      param.type.getDisplayString() == 'DateTime') {
    buffer.write('l.string()');
    buffer.write(getStringValidations(param));
  }

  if (buffer.isEmpty) {
    _checkAndAddCustomSchema(buffer, param);
  }

  getCustomValidations(param, buffer);

  final hasDefaultAnnotation = getAnnotation(defaultChecker, param) != null;
  if (param.type is! DynamicType && !isNullable && !hasDefaultAnnotation) {
    buffer.write('.required()');
  }

  return buffer.toString();
}

void _checkAndAddCustomSchema(StringBuffer buffer, ParameterElement param) {
  final element = param.type.element;
  if (element == null) {
    throw UnsupportedTypeError(
      'Cannot determine type of ${param.type.getDisplayString()}',
    );
  }

  final hasLuthorAnnotation = getAnnotation(luthorChecker, element) != null;
  if (!hasLuthorAnnotation) {
    throw UnsupportedTypeError(
      'Type ${param.type.getDisplayString()} '
      'does not have @luthor annotation.',
    );
  }
  buffer.write(
    '\$${param.type.getDisplayString().replaceFirst('?', '')}Schema',
  );
}

DartObject? getAnnotation(TypeChecker checker, Element field) {
  return checker.firstAnnotationOf(field);
}

void _writeListValidations(StringBuffer buffer, ParameterElement param) {
  buffer.write('l.list(validators: [');
  
  // Use proper analyzer API to extract list element type
  if (param.type is ParameterizedType) {
    final parameterizedType = param.type as ParameterizedType;
    final typeArgs = parameterizedType.typeArguments;
    
    if (typeArgs.isNotEmpty) {
      final elementType = typeArgs.first;
      
      // Create a mock ParameterElement for the list element type
      // to reuse getValidations logic
      final elementValidation = _getValidationForType(elementType);
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

String _getValidationForType(DartType type) {
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
  } else if (type.isDartCoreString || type.getDisplayString() == 'DateTime') {
    buffer.write('l.string()');
  } else {
    // Handle custom types with @luthor annotation
    final element = type.element;
    if (element != null) {
      final hasLuthorAnnotation = getAnnotation(luthorChecker, element) != null;
      if (hasLuthorAnnotation) {
        buffer.write('\$${type.getDisplayString().replaceFirst('?', '')}Schema');
      } else {
        throw UnsupportedTypeError(
          'Type ${type.getDisplayString()} does not have @luthor annotation.',
        );
      }
    } else {
      throw UnsupportedTypeError(
        'Cannot determine type of ${type.getDisplayString()}',
      );
    }
  }
  
  // Add required() if not nullable and not dynamic
  if (type is! DynamicType && !isNullable) {
    buffer.write('.required()');
  }
  
  return buffer.toString();
}
