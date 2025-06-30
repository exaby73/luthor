// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:luthor_generator/checkers.dart';
import 'package:luthor_generator/helpers/validations/base_validations.dart';

String getDoubleValidations(ParameterElement param) {
  final buffer = StringBuffer();

  _checkAndWriteMaxValidation(buffer, param);
  _checkAndWriteMinValidation(buffer, param);

  return buffer.toString();
}

void _checkAndWriteMaxValidation(StringBuffer buffer, ParameterElement param) {
  final maxAnnotation = getAnnotation(hasMaxDoubleChecker, param);
  if (maxAnnotation != null) {
    buffer.write('.max(');
    final message = maxAnnotation.getField('message')?.toStringValue();
    final max = maxAnnotation.getField('max')!.toDoubleValue()!;
    buffer.write(max);
    if (message != null) buffer.write(", message: '$message'");
    buffer.write(')');
  }
}

void _checkAndWriteMinValidation(StringBuffer buffer, ParameterElement param) {
  final minAnnotation = getAnnotation(hasMinDoubleChecker, param);
  if (minAnnotation != null) {
    buffer.write('.min(');
    final message = minAnnotation.getField('message')?.toStringValue();
    final min = minAnnotation.getField('min')!.toDoubleValue()!;
    buffer.write(min);
    if (message != null) buffer.write(", message: '$message'");
    buffer.write(')');
  }
}
