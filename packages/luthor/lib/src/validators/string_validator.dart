import 'package:luthor/src/validations/strings/string_date_time_validation.dart';
import 'package:luthor/src/validations/strings/string_email_validation.dart';
import 'package:luthor/src/validations/strings/string_emoji_validation.dart';
import 'package:luthor/src/validations/strings/string_length_validation.dart';
import 'package:luthor/src/validations/strings/string_max_validation.dart';
import 'package:luthor/src/validations/strings/string_min_validation.dart';
import 'package:luthor/src/validations/strings/string_uri_validation.dart';
import 'package:luthor/src/validations/strings/string_uuid_validation.dart';
import 'package:luthor/src/validator.dart';

class StringValidator extends Validator {
  StringValidator({super.initialValidations});

  Validator dateTime({String? message}) {
    validations.add(StringDateTimeValidation(message: message));
    return this;
  }

  Validator email({String? message}) {
    validations.add(StringEmailValidation(message: message));
    return this;
  }

  StringValidator min(int minLength, {String? message}) {
    validations
        .add(StringMinValidation(minLength: minLength, message: message));
    return this;
  }

  StringValidator max(int maxLength, {String? message}) {
    validations
        .add(StringMaxValidation(maxLength: maxLength, message: message));
    return this;
  }

  StringValidator length(int length, {String? message}) {
    validations.add(StringLengthValidation(length: length, message: message));
    return this;
  }

  StringValidator uri({List<String>? allowedSchemes, String? message}) {
    validations.add(
      StringUriValidation(allowedSchemes: allowedSchemes, message: message),
    );
    return this;
  }

  StringValidator emoji({String? message}) {
    validations.add(StringEmojiValidation(message: message));
    return this;
  }

  StringValidator uuid({String? message}) {
    validations.add(StringUuidValidation(message: message));
    return this;
  }
}
