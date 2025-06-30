import 'package:analyzer/dart/element/element.dart';
import 'package:luthor_generator/checkers.dart';
import 'package:luthor_generator/helpers/validations/base_validations.dart';

String getIntValidations(ParameterElement param) {
  final buffer = StringBuffer();

  _checkAndWriteMaxValidation(buffer, param);
  _checkAndWriteMinValidation(buffer, param);

  return buffer.toString();
}

void _checkAndWriteMaxValidation(StringBuffer buffer, ParameterElement param) {
  final maxAnnotation = getAnnotation(hasMaxChecker, param);
  if (maxAnnotation != null) {
    buffer.write('.max(');
    final message = maxAnnotation.getField('message')?.toStringValue();
    final max = maxAnnotation.getField('max')!.toIntValue()!;
    buffer.write(max);
    if (message != null) buffer.write(", message: '$message'");
    buffer.write(')');
  }
}

void _checkAndWriteMinValidation(StringBuffer buffer, ParameterElement param) {
  final minAnnotation = getAnnotation(hasMinChecker, param);
  if (minAnnotation != null) {
    buffer.write('.min(');
    final message = minAnnotation.getField('message')?.toStringValue();
    final min = minAnnotation.getField('min')!.toIntValue()!;
    buffer.write(min);
    if (message != null) buffer.write(", message: '$message'");
    buffer.write(')');
  }
}
