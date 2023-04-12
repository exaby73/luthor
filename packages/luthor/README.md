# Luthor

Luthor is a validation library, heavily inspired by [zod](https://zod.dev)

## Installation

Dart:

```bash
dart pub add luthor
```

Flutter:

```bash
flutter pub add luthor
```

## Usage

```dart
import 'package:luthor/luthor.dart';

void main() {
  final schema = l.string();
  final validResult = schema.validate('hello');

  print(validResult.isValid); // true
  print(validResult.message); // null
  print(validResult.data); // 'hello'

  final invalidResult = schema.validate(123);

  print(invalidResult.isValid); // false
  print(invalidResult.message); // 'value must be a string'
  print(invalidResult.data); // 123

  // Strings can have extra validations that can be applied to them
  l.string().email();
  l.string().dateTime(); // Use Dart's DateTime.tryParse
  l.string().min(3);
  l.string().max(3);

  // You can chain validations together
  // This will validate that the string is between 3 and 30 characters long
  // and is required so null is not allowed
  final usernameValidator = l.string().min(3).max(30).required();

  // NOTE: all validators allow null values unless you call .required()
  // This is different to zod where all validators are required by default

  // Other primitive types are supported with more to come
  l.number();
  l.bool();
  l.int();
  l.double();
  l.nullValue(); // Ensures the value is null
  l.any(); // Any value, null or not is allowed
}
```
