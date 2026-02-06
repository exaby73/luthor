import 'package:analyzer/dart/element/element.dart';
import 'package:luthor_generator/checkers.dart';
import 'package:luthor_generator/helpers/validations/base_validations.dart';

String getIntValidations(FormalParameterElement param) {
  final buffer = StringBuffer();

  _checkAndWriteMaxValidation(buffer, param);
  _checkAndWriteMinValidation(buffer, param);

  return buffer.toString();
}

void _checkAndWriteMaxValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final maxAnnotation = getAnnotation(hasMaxChecker, param);
  if (maxAnnotation != null) {
    buffer.write('.max(');
    final message = maxAnnotation.getField('message')?.toStringValue();
    final messageFn = maxAnnotation.getField('messageFn')?.toFunctionValue();
    final max = maxAnnotation.getField('max')!.toIntValue()!;

    final params = <String>[max.toString()];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteMinValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final minAnnotation = getAnnotation(hasMinChecker, param);
  if (minAnnotation != null) {
    buffer.write('.min(');
    final message = minAnnotation.getField('message')?.toStringValue();
    final messageFn = minAnnotation.getField('messageFn')?.toFunctionValue();
    final min = minAnnotation.getField('min')!.toIntValue()!;

    final params = <String>[min.toString()];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}
