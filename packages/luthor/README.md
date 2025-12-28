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
