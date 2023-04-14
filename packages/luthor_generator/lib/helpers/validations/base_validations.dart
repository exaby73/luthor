import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:luthor_generator/errors/unsupported_type_error.dart';
import 'package:luthor_generator/helpers/validations/string_validations.dart';
import 'package:source_gen/source_gen.dart';

String getValidations(ParameterElement param) {
  final buffer = StringBuffer();

  final isNullable = param.type.nullabilitySuffix == NullabilitySuffix.question;

  if (param.type.getDisplayString(withNullability: false) == 'DateTime') {
    throw UnsupportedTypeError(
      'DateTime is not supported. Use String instead with @isDateTime.',
    );
  }

  if (param.type.isDynamic) {
    buffer.write('.any()');
  }

  if (param.type.isDartCoreBool) {
    buffer.write('.bool()');
  }

  if (param.type.isDartCoreDouble) {
    buffer.write('.double()');
  }

  if (param.type.isDartCoreInt) {
    buffer.write('.int()');
  }

  if (param.type.isDartCoreList) {
    _writeListValidations(buffer, param);
  }

  if (param.type.isDartCoreNull) {
    buffer.write('.nullValue()');
  }

  if (param.type.isDartCoreNum) {
    buffer.write('.number()');
  }

  if (param.type.isDartCoreString) {
    buffer.write('.string()');
    buffer.write(getStringValidations(param));
  }

  if (buffer.toString().endsWith('l')) buffer.write('any()');

  if (!param.type.isDynamic && !isNullable) buffer.write('.required()');

  return buffer.toString();
}

DartObject? getAnnotation(TypeChecker checker, ParameterElement field) {
  return checker.firstAnnotationOf(field);
}

void _writeListValidations(StringBuffer buffer, ParameterElement param) {
  buffer.write('.list(validators: [');
  final listType = param.type
      .getDisplayString(withNullability: false)
      .replaceFirst('List<', '')
      .replaceFirst('>', '');

  const types = ['dynamic', 'bool', 'double', 'Null', 'int', 'num', 'String'];

  if (!types.contains(listType)) {
    throw UnsupportedTypeError('List<$listType> is not supported.');
  }

  if (listType == 'dynamic') {
    buffer.write('l.any()])');
    return;
  }

  if (listType == 'num') {
    buffer.write('l.number()])');
    return;
  }

  if (listType == 'Null') {
    buffer.write('l.nullValue()])');
    return;
  }

  buffer.write('l.${listType.toLowerCase()}()])');
}
