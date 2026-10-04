# Luthor

Luthor is a Dart validation library inspired by [Zod](https://zod.dev). You build a schema with a fluent API, validate any value against it, and get typed data or a list of issues with flat error paths. `luthor_generator` writes the schemas for your `json_serializable`, freezed, and `dart_mappable` models.

```dart
import 'package:luthor/luthor.dart';

final user = l.schema({
  'email': l.string().email().required(),
  'age': l.int().min(18),
});

void main() {
  switch (user.validate({'email': 'ada', 'age': 16})) {
    case ValidationSuccess(:final data):
      print(data);
    case ValidationFailure(:final errors):
      print(errors);
  }
}
```

This prints `{email: [email must be a valid email address], age: [age must be greater than or equal to 18]}`.

## Packages

- [`luthor`](https://pub.dev/packages/luthor) is the validation library. It has no runtime dependencies.
- [`luthor_generator`](https://pub.dev/packages/luthor_generator) generates schemas for classes annotated with `@luthor`.

Both need Dart 3.11 or later, or Flutter 3.41 or later.

## Documentation

The full documentation is at [luthor.ex3.dev](https://luthor.ex3.dev).

To teach your coding agent the Luthor API, install the Luthor agent skill with `npx skills add exaby73/luthor`.

## Contributing

Read [`AGENTS.md`](AGENTS.md) for the repository's rules and gotchas, and [`docs/architecture.md`](docs/architecture.md) for how the runtime and the generator fit together.
