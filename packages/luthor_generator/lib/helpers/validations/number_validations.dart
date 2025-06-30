import 'package:analyzer/dart/element/element.dart';
import 'package:luthor_generator/checkers.dart';
import 'package:luthor_generator/helpers/validations/base_validations.dart';

String getNumberValidations(ParameterElement param) {
  final buffer = StringBuffer();

  _checkAndWriteMaxValidation(buffer, param);
  _checkAndWriteMinValidation(buffer, param);

  return buffer.toString();
}

void _checkAndWriteMaxValidation(StringBuffer buffer, ParameterElement param) {
  final maxAnnotation = getAnnotation(hasMaxNumberChecker, param);
  if (maxAnnotation != null) {
    buffer.write('.max(');
    final message = maxAnnotation.getField('message')?.toStringValue();
    final maxInt = maxAnnotation.getField('max')!.toIntValue();
    final maxDouble = maxAnnotation.getField('max')!.toDoubleValue();
    buffer.write(maxInt ?? maxDouble);
    if (message != null) buffer.write(", message: '$message'");
    buffer.write(')');
  }
}

void _checkAndWriteMinValidation(StringBuffer buffer, ParameterElement param) {
  final minAnnotation = getAnnotation(hasMinNumberChecker, param);
  if (minAnnotation != null) {
    buffer.write('.min(');
    final message = minAnnotation.getField('message')?.toStringValue();
    final minInt = minAnnotation.getField('min')!.toIntValue();
    final minDouble = minAnnotation.getField('min')!.toDoubleValue();
    buffer.write(minInt ?? minDouble);
    if (message != null) buffer.write(", message: '$message'");
    buffer.write(')');
  }
}
