import 'package:analyzer/dart/element/element.dart';
import 'package:luthor_generator/checkers.dart';
import 'package:luthor_generator/helpers/validations/base_validations.dart';

String getStringValidations(ParameterElement param) {
  final buffer = StringBuffer();

  _checkAndWriteDateTimeValidation(buffer, param);
  _checkAndWriteEmailValidation(buffer, param);
  _checkAndWriteLengthValidation(buffer, param);
  _checkAndWriteMaxValidation(buffer, param);
  _checkAndWriteMinValidation(buffer, param);
  _checkAndWriteUriValidation(buffer, param);
  _checkAndWriteRegexValidation(buffer, param);
  _checkAndWriteStartsWithValidation(buffer, param);
  _checkAndWriteEndsWithValidation(buffer, param);
  _checkAndWriteContainsValidation(buffer, param);
  _checkAndWriteIpValidation(buffer, param);

  return buffer.toString();
}

void _checkAndWriteDateTimeValidation(
  StringBuffer buffer,
  ParameterElement param,
) {
  final dateTimeAnnotation = getAnnotation(isDateTimeChecker, param);
  if (dateTimeAnnotation != null ||
      param.type.getDisplayString(withNullability: false) == 'DateTime') {
    buffer.write('.dateTime(');
    final message = dateTimeAnnotation?.getField('message')?.toStringValue();
    if (message != null) buffer.write("message: '$message'");
    buffer.write(')');
  }
}

void _checkAndWriteEmailValidation(
  StringBuffer buffer,
  ParameterElement param,
) {
  final emailAnnotation = getAnnotation(isEmailChecker, param);
  if (emailAnnotation != null) {
    buffer.write('.email(');
    final message = emailAnnotation.getField('message')?.toStringValue();
    if (message != null) buffer.write("message: '$message'");
    buffer.write(')');
  }
}

void _checkAndWriteLengthValidation(
  StringBuffer buffer,
  ParameterElement param,
) {
  final lengthAnnotation = getAnnotation(hasLengthChecker, param);
  if (lengthAnnotation != null) {
    buffer.write('.length(');
    final message = lengthAnnotation.getField('message')?.toStringValue();
    final length = lengthAnnotation.getField('length')!.toIntValue()!;
    buffer.write(length);
    if (message != null) buffer.write(", message: '$message'");
    buffer.write(')');
  }
}

void _checkAndWriteMaxValidation(
  StringBuffer buffer,
  ParameterElement param,
) {
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

void _checkAndWriteMinValidation(
  StringBuffer buffer,
  ParameterElement param,
) {
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

void _checkAndWriteUriValidation(
  StringBuffer buffer,
  ParameterElement param,
) {
  final uriAnnotation = getAnnotation(isUriChecker, param);
  if (uriAnnotation != null) {
    buffer.write('.uri(');

    final allowedSchemas = uriAnnotation
        .getField('allowedSchemes')
        ?.toListValue()
        ?.map((e) => e.toStringValue()!)
        .toList();
    final message = uriAnnotation.getField('message')?.toStringValue();

    if (allowedSchemas != null) {
      buffer.write('allowedSchemes: [');
      buffer.write(allowedSchemas.map((e) => "'$e'").join(', '));
      buffer.write(']');
      if (message != null) buffer.write(', ');
    }

    if (message != null) buffer.write("message: '$message'");
    buffer.write(')');
  }
}

void _checkAndWriteRegexValidation(
  StringBuffer buffer,
  ParameterElement param,
) {
  final regexAnnotation = getAnnotation(matchRegexChecker, param);
  if (regexAnnotation != null) {
    buffer.write('.regex(');

    final pattern = regexAnnotation.getField('pattern')!.toStringValue();
    final message = regexAnnotation.getField('message')?.toStringValue();
    buffer.write('r"$pattern"');
    if (message != null) buffer.write(", message: '$message'");
    buffer.write(')');
  }
}

void _checkAndWriteStartsWithValidation(
  StringBuffer buffer,
  ParameterElement param,
) {
  final startsWithAnnotation = getAnnotation(startsWithChecker, param);
  if (startsWithAnnotation != null) {
    buffer.write('.startsWith(');

    final string = startsWithAnnotation.getField('string')!.toStringValue();
    final message = startsWithAnnotation.getField('message')?.toStringValue();
    buffer.write('r"$string"');
    if (message != null) buffer.write(", message: '$message'");
    buffer.write(')');
  }
}

void _checkAndWriteEndsWithValidation(
  StringBuffer buffer,
  ParameterElement param,
) {
  final endsWithAnnotation = getAnnotation(endsWithChecker, param);
  if (endsWithAnnotation != null) {
    buffer.write('.endsWith(');

    final string = endsWithAnnotation.getField('string')!.toStringValue();
    final message = endsWithAnnotation.getField('message')?.toStringValue();
    buffer.write('r"$string"');
    if (message != null) buffer.write(", message: '$message'");
    buffer.write(')');
  }
}

void _checkAndWriteContainsValidation(
  StringBuffer buffer,
  ParameterElement param,
) {
  final containsAnnotation = getAnnotation(containsChecker, param);
  if (containsAnnotation != null) {
    buffer.write('.contains(');

    final string = containsAnnotation.getField('string')!.toStringValue();
    final message = containsAnnotation.getField('message')?.toStringValue();
    buffer.write('r"$string"');
    if (message != null) buffer.write(", message: '$message'");
    buffer.write(')');
  }
}

void _checkAndWriteIpValidation(
  StringBuffer buffer,
  ParameterElement param,
) {
  final ipAnnotation = getAnnotation(isIpChecker, param);
  if (ipAnnotation != null) {
    buffer.write('.ip(');

    final version = ipAnnotation.getField('version')?.toStringValue();
    String? ipEnum;
    if (version != null) {
      if (version == 'v4') ipEnum = 'IpVersion.v4';
      if (version == 'v6') ipEnum = 'IpVersion.v6';
      buffer.write('version: $ipEnum,');
    }

    final message = ipAnnotation.getField('message')?.toStringValue();
    if (message != null) {
      buffer.write("message: '$message");
      buffer.write(')');
    }

    buffer.write(')');
  }
}
