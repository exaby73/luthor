# Luthor

Luthor is a validation library for Dart and Flutter, heavily inspired by [zod](https://zod.dev).

- Build validators with a fluent API: `l.string().email().required()`.
- Get typed output without code generation: `l.int().required()` validates to an `int`.
- Read structured issues, each with a code, a path, a message and params.
- Translate or rewrite every message with one message builder.

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

final signup = l.schema({
  'email': l.string().email().required(),
  'password': l.string().min(8).required(),
  'tags': l.list(l.string().required()),
});

void main() {
  final result = signup.validate({
    'email': 'not-an-email',
    'password': 'short',
    'tags': ['dart', 1],
  });

  switch (result) {
    case ValidationSuccess(:final data):
      print('Valid: $data');
    case ValidationFailure(:final errors):
      // {email: [email must be a valid email address],
      //  password: [password must be at least 8 characters long],
      //  tags.1: [tags must be a string]}
      print(errors);
  }

  print(result.getError('tags.1')); // tags must be a string
}
```

Validators are optional by default: `null`, and a missing schema field, pass unless `.required()` is present.

### Code Generation (Optional)

Luthor supports code generation for enhanced type safety and developer experience:

```bash
dart pub add dev:build_runner dev:luthor_generator
```

Features include:
- **Type-safe ErrorKeys** - Generated constants for accessing validation errors
- **Type-safe SchemaKeys** - Generated constants for defining schemas
- **Cross-field validation** - Validate fields against other fields in the same schema

See the [documentation][docs] for usage.

[docs]: https://luthor.ex3.dev
