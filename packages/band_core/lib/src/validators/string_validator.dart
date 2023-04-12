import 'package:band_core/src/validations/strings/string_date_time_validation.dart';
import 'package:band_core/src/validations/strings/string_min_validation.dart';
import 'package:band_core/src/validator.dart';

class StringValidator extends Validator {
  StringValidator({super.initialValidations});

  Validator dateTime([String? message]) {
    validations.add(StringDateTimeValidation(message: message));
    return this;
  }

  StringValidator min(int min, [String? message]) {
    validations.add(StringMinValidation(minLength: min, message: message));
    return this;
  }
}
