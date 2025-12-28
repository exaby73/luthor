// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/element/element2.dart';
import 'package:luthor_generator/checkers.dart';
import 'package:luthor_generator/helpers/validations/base_validations.dart';

/// Returns true if the string should be a raw string (contains backslashes)
bool _shouldUseRawString(String value) {
  return value.contains(r'\');
}

/// Formats a string literal, using raw string only if needed
String _formatStringLiteral(String value) {
  if (_shouldUseRawString(value)) {
    return 'r"$value"';
  }
  return '"$value"';
}

String getStringValidations(FormalParameterElement param) {
  final buffer = StringBuffer();

  _checkAndWriteDateTimeValidation(buffer, param);
  _checkAndWriteEmailValidation(buffer, param);
  _checkAndWriteLengthValidation(buffer, param);
  _checkAndWriteMaxValidation(buffer, param);
  _checkAndWriteMinValidation(buffer, param);
  _checkAndWriteUriValidation(buffer, param);
  _checkAndWriteUrlValidation(buffer, param);
  _checkAndWriteRegexValidation(buffer, param);
  _checkAndWriteStartsWithValidation(buffer, param);
  _checkAndWriteEndsWithValidation(buffer, param);
  _checkAndWriteContainsValidation(buffer, param);
  _checkAndWriteIpValidation(buffer, param);
  _checkAndWriteUuidValidation(buffer, param);
  _checkAndWriteCuidValidation(buffer, param);
  _checkAndWriteCuid2Validation(buffer, param);
  _checkAndWriteEmojiValidation(buffer, param);

  return buffer.toString();
}

void _checkAndWriteDateTimeValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final dateTimeAnnotation = getAnnotation(isDateTimeChecker, param);
  if (dateTimeAnnotation != null ||
      param.type.getDisplayString() == 'DateTime') {
    buffer.write('.dateTime(');
    final message = dateTimeAnnotation?.getField('message')?.toStringValue();
    final messageFn = dateTimeAnnotation
        ?.getField('messageFn')
        ?.toFunctionValue();

    final params = <String>[];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteEmailValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final emailAnnotation = getAnnotation(isEmailChecker, param);
  if (emailAnnotation != null) {
    buffer.write('.email(');
    final message = emailAnnotation.getField('message')?.toStringValue();
    final messageFn = emailAnnotation.getField('messageFn')?.toFunctionValue();

    final params = <String>[];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteLengthValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final lengthAnnotation = getAnnotation(hasLengthChecker, param);
  if (lengthAnnotation != null) {
    buffer.write('.length(');
    final message = lengthAnnotation.getField('message')?.toStringValue();
    final messageFn = lengthAnnotation.getField('messageFn')?.toFunctionValue();
    final length = lengthAnnotation.getField('length')!.toIntValue()!;

    final params = <String>[length.toString()];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
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

void _checkAndWriteUriValidation(
  StringBuffer buffer,
  FormalParameterElement param,
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
    final messageFn = uriAnnotation.getField('messageFn')?.toFunctionValue();

    final params = <String>[];
    if (allowedSchemas != null) {
      params.add(
        'allowedSchemes: [${allowedSchemas.map((e) => "'$e'").join(', ')}]',
      );
    }
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteUrlValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final urlAnnotation = getAnnotation(isUrlChecker, param);
  if (urlAnnotation != null) {
    buffer.write('.url(');

    final allowedSchemes = urlAnnotation
        .getField('allowedSchemes')
        ?.toListValue()
        ?.map((e) => e.toStringValue()!)
        .toList();
    final message = urlAnnotation.getField('message')?.toStringValue();
    final messageFn = urlAnnotation.getField('messageFn')?.toFunctionValue();

    final params = <String>[];
    if (allowedSchemes != null) {
      params.add(
        'allowedSchemes: [${allowedSchemes.map((e) => "'$e'").join(', ')}]',
      );
    }
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteRegexValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final regexAnnotation = getAnnotation(matchRegexChecker, param);
  if (regexAnnotation != null) {
    buffer.write('.regex(');

    final pattern = regexAnnotation.getField('pattern')!.toStringValue();
    final message = regexAnnotation.getField('message')?.toStringValue();
    final messageFn = regexAnnotation.getField('messageFn')?.toFunctionValue();

    final params = <String>['r"$pattern"'];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteStartsWithValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final startsWithAnnotation = getAnnotation(startsWithChecker, param);
  if (startsWithAnnotation != null) {
    buffer.write('.startsWith(');

    final string = startsWithAnnotation.getField('string')!.toStringValue();
    final message = startsWithAnnotation.getField('message')?.toStringValue();
    final messageFn = startsWithAnnotation
        .getField('messageFn')
        ?.toFunctionValue();

    final params = <String>[_formatStringLiteral(string!)];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteEndsWithValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final endsWithAnnotation = getAnnotation(endsWithChecker, param);
  if (endsWithAnnotation != null) {
    buffer.write('.endsWith(');

    final string = endsWithAnnotation.getField('string')!.toStringValue();
    final message = endsWithAnnotation.getField('message')?.toStringValue();
    final messageFn = endsWithAnnotation
        .getField('messageFn')
        ?.toFunctionValue();

    final params = <String>[_formatStringLiteral(string!)];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteContainsValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final containsAnnotation = getAnnotation(containsChecker, param);
  if (containsAnnotation != null) {
    buffer.write('.contains(');

    final string = containsAnnotation.getField('string')!.toStringValue();
    final message = containsAnnotation.getField('message')?.toStringValue();
    final messageFn = containsAnnotation
        .getField('messageFn')
        ?.toFunctionValue();

    final params = <String>[_formatStringLiteral(string!)];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteIpValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final ipAnnotation = getAnnotation(isIpChecker, param);
  if (ipAnnotation != null) {
    buffer.write('.ip(');

    final version = ipAnnotation
        .getField('version')
        ?.getField('_name')
        ?.toStringValue();
    final message = ipAnnotation.getField('message')?.toStringValue();
    final messageFn = ipAnnotation.getField('messageFn')?.toFunctionValue();

    final params = <String>[];
    if (version != null) {
      String? ipEnum;
      if (version == 'v4') ipEnum = 'IpVersion.v4';
      if (version == 'v6') ipEnum = 'IpVersion.v6';
      if (ipEnum != null) params.add('version: $ipEnum');
    }
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteUuidValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final uuidAnnotation = getAnnotation(isUuidChecker, param);
  if (uuidAnnotation != null) {
    buffer.write('.uuid(');
    final message = uuidAnnotation.getField('message')?.toStringValue();
    final messageFn = uuidAnnotation.getField('messageFn')?.toFunctionValue();

    final params = <String>[];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteCuidValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final cuidAnnotation = getAnnotation(isCuidChecker, param);
  if (cuidAnnotation != null) {
    buffer.write('.cuid(');
    final message = cuidAnnotation.getField('message')?.toStringValue();
    final messageFn = cuidAnnotation.getField('messageFn')?.toFunctionValue();

    final params = <String>[];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteCuid2Validation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final cuid2Annotation = getAnnotation(isCuid2Checker, param);
  if (cuid2Annotation != null) {
    buffer.write('.cuid2(');
    final message = cuid2Annotation.getField('message')?.toStringValue();
    final messageFn = cuid2Annotation.getField('messageFn')?.toFunctionValue();

    final params = <String>[];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}

void _checkAndWriteEmojiValidation(
  StringBuffer buffer,
  FormalParameterElement param,
) {
  final emojiAnnotation = getAnnotation(isEmojiChecker, param);
  if (emojiAnnotation != null) {
    buffer.write('.emoji(');
    final message = emojiAnnotation.getField('message')?.toStringValue();
    final messageFn = emojiAnnotation.getField('messageFn')?.toFunctionValue();

    final params = <String>[];
    if (message != null) params.add("message: '$message'");
    if (messageFn != null) {
      params.add("messageFn: ${getQualifiedFunctionName(messageFn)}");
    }

    buffer.write(params.join(', '));
    buffer.write(')');
  }
}
