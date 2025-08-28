// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/element/element2.dart';
import 'package:luthor_generator/checkers.dart';
import 'package:luthor_generator/helpers/validations/base_validations.dart';

String getNumberValidations(FormalParameterElement param) {
  final buffer = StringBuffer();

  _checkAndWriteMaxValidation(buffer, param);
  _checkAndWriteMinValidation(buffer, param);

  return buffer.toString();
}

void _checkAndWriteMaxValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final maxAnnotation = getAnnotation(hasMaxNumberChecker, param);
  if (maxAnnotation != null) {
    buffer.write('.max(');
    final message = maxAnnotation.getField('message')?.toStringValue();
    final messageFn = maxAnnotation.getField('messageFn')?.toFunctionValue();
    final maxInt = maxAnnotation.getField('max')!.toIntValue();
    final maxDouble = maxAnnotation.getField('max')!.toDoubleValue();
    
    final params = <String>[(maxInt ?? maxDouble).toString()];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    
    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteMinValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final minAnnotation = getAnnotation(hasMinNumberChecker, param);
  if (minAnnotation != null) {
    buffer.write('.min(');
    final message = minAnnotation.getField('message')?.toStringValue();
    final messageFn = minAnnotation.getField('messageFn')?.toFunctionValue();
    final minInt = minAnnotation.getField('min')!.toIntValue();
    final minDouble = minAnnotation.getField('min')!.toDoubleValue();
    
    final params = <String>[(minInt ?? minDouble).toString()];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    
    buffer.write(params.join(', '));
    buffer.write(')');
  }
}
