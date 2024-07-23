import 'package:luthor/luthor.dart';

class KeyedValidator {
  const KeyedValidator(this.key, this.validator);

  final String key;
  final Validator validator;
}
