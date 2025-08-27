# luthor_generator

`luthor_generator` is a package allowing you to generate luthor schemas with
code generation. It is a companion to
the [`luthor`](https://pub.dev/packages/luthor) package, and is built to work
with `freezed`.

## Features

- **Schema Generation** - Automatically generate validation schemas from annotated classes
- **Type-safe SchemaKeys** - Generated constants for defining schemas with compile-time safety
- **Type-safe ErrorKeys** - Generated constants for accessing validation errors with dot-notation support
- **Cross-field Validation** - Support for `@WithSchemaCustomValidator` to validate fields against other fields

## Generated Code

For each annotated class, luthor_generator creates:

- `$ClassNameSchema` - The validation schema
- `ClassNameSchemaKeys` - Type-safe keys for schema field access
- `ClassNameErrorKeys` - Type-safe keys for error handling with nested field support
- `$ClassNameValidate()` - Validation function with optional `fromJson` deserialization

See the [documentation][docs] for more information.

[docs]: https://luthor.netlify.app
