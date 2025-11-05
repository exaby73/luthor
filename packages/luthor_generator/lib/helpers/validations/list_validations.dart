// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/element/element2.dart';
import 'package:luthor_generator/checkers.dart';
import 'package:luthor_generator/helpers/validations/base_validations.dart';

String getListValidations(FormalParameterElement param) {
  final buffer = StringBuffer();

  // Check for @HasMin annotation
  final hasMinAnnotation = getAnnotation(hasMinChecker, param);
  if (hasMinAnnotation != null) {
    final min = hasMinAnnotation.getField('min')!.toIntValue();
    final message = hasMinAnnotation.getField('message')?.toStringValue();
    final messageFn = hasMinAnnotation.getField('messageFn')?.toFunctionValue();

    buffer.write('.min($min');
    if (message != null) {
      buffer.write(", message: '$message'");
    }
    if (messageFn != null) {
      buffer.write(', messageFn: ${getQualifiedFunctionName(messageFn)}');
    }
    buffer.write(')');
  }

  // Check for @HasMax annotation
  final hasMaxAnnotation = getAnnotation(hasMaxChecker, param);
  if (hasMaxAnnotation != null) {
    final max = hasMaxAnnotation.getField('max')!.toIntValue();
    final message = hasMaxAnnotation.getField('message')?.toStringValue();
    final messageFn = hasMaxAnnotation.getField('messageFn')?.toFunctionValue();

    buffer.write('.max($max');
    if (message != null) {
      buffer.write(", message: '$message'");
    }
    if (messageFn != null) {
      buffer.write(', messageFn: ${getQualifiedFunctionName(messageFn)}');
    }
    buffer.write(')');
  }

  // Check for @HasLength annotation
  final hasLengthAnnotation = getAnnotation(hasLengthChecker, param);
  if (hasLengthAnnotation != null) {
    final length = hasLengthAnnotation.getField('length')!.toIntValue();
    final message = hasLengthAnnotation.getField('message')?.toStringValue();
    final messageFn = hasLengthAnnotation.getField('messageFn')?.toFunctionValue();

    buffer.write('.length($length');
    if (message != null) {
      buffer.write(", message: '$message'");
    }
    if (messageFn != null) {
      buffer.write(', messageFn: ${getQualifiedFunctionName(messageFn)}');
    }
    buffer.write(')');
  }

  return buffer.toString();
}
