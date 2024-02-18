import 'package:analyzer/dart/element/element.dart';
import 'package:luthor_generator/checkers.dart';
import 'package:luthor_generator/helpers/validations/base_validations.dart';

void getCustomValidations(ParameterElement param, StringBuffer buffer) {
  _checkAndWriteCustomValidation(buffer, param);
}

void _checkAndWriteCustomValidation(
  StringBuffer buffer,
  ParameterElement param,
) {
  final customAnnotation = getAnnotation(customValidatorChecker, param);
  if (customAnnotation != null) {
    buffer.write('.custom(');
    final message = customAnnotation.getField('message')?.toStringValue();
    final customFuntion =
        customAnnotation.getField('customValidator')!.toFunctionValue()!.name;

    buffer.write(customFuntion);
    if (message != null) buffer.write(", message: '$message'");
    buffer.write(')');
  }
}
