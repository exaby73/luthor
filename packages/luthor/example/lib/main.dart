import 'package:luthor/luthor.dart';

void main() {
  final aString = 'Hello World';
  final aDateTime = DateTime.now().toString();
  final anEmail = 'user@example.com';
  final aUri = 'https://example.com';
  final anEmoji = '🦄';
  final aUuid = '123e4567-e89b-12d3-a456-426614174000';
  final aCuid = 'ckjv4ys4h0000hjzv5y6y1q1t';
  final aIp = '192.168.1.1';

  final aNumber = 42;
  final anInt = 42;
  final aDouble = 42.0;
  final aBoolean = true;
  final aNullValue = null;
  final aList = [1, 2, 3];
  final aMap = {'key': 'value'};

  // All string validations
  print(l.string().validateValue(aString));
  print(l.string().dateTime().validateValue(aDateTime));
  print(l.string().email().validateValue(anEmail));
  print(l.string().min(1).validateValue(aString));
  print(l.string().max(12).validateValue(aString));
  print(l.string().length(11).validateValue(aString));
  print(l.string().uri().validateValue(aUri));
  print(l.string().emoji().validateValue(anEmoji));
  print(l.string().uuid().validateValue(aUuid));
  print(l.string().cuid().validateValue(aCuid));
  print(l.string().cuid2().validateValue(aCuid));
  print(l.string().regex(r'([A-Za-z]+)').validateValue(aString));
  print(l.string().ip().validateValue(aIp));

  // Other primitive types can be validated as well
  print(l.number().validateValue(aNumber));
  print(l.int().validateValue(anInt));
  print(l.double().validateValue(aDouble));
  print(l.boolean().validateValue(aBoolean));
  print(l.nullValue().validateValue(aNullValue));

  // General validations
  print(l.any().validateValue(aNumber));
  print(l.required().validateValue(aNumber));

  // Lists and maps (called schemas in luthor) can be validated as well
  print(l.list(validators: [l.number()]).validateValue(aList));
  print(l.schema({'key': l.string()}).validateSchema(aMap));

  // Validations can be chained
  print(
    // Value should be a string (.string()),
    // have a minimum length of 1 (.min(1)),
    // have a maximum length of 12 (.max(12))
    // and not null (.required())
    l.string().min(1).max(12).required().validateValue(aString),
  );
  print(
    // This works since all validations are optional by default
    l.string().email().validateValue(null),
  );
  print(
    // This does not since we mark the validation as required
    l.string().email().required().validateValue(null),
  );
}
