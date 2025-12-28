# GitHub Copilot Instructions for Luthor

## Project Overview

Luthor is a pure Dart validation library heavily inspired by [Zod](https://zod.dev). It provides a fluent API for building type-safe validation schemas with optional code generation support through `luthor_generator`.

## Project Structure

This is a monorepo with the following packages:
- `packages/luthor` - Core validation library
- `packages/luthor_generator` - Code generation package for enhanced type safety
- Each package has its own `example` directory with usage examples

## Development Workflow

### Setup

**Prerequisites:**
- Dart SDK >= 3.8.0 (project requirement)
- Dart SDK 3.10+ recommended for using `dart install dpk` command

**Install dpk (Dartpack - monorepo management CLI):**
```bash
# For Dart 3.10+
dart install dpk

# Add Dart bin to PATH
echo "$HOME/.local/state/Dart/install/bin" >> $HOME/.bashrc
source $HOME/.bashrc

# Or manually add to PATH for the current session
export PATH="$PATH:$HOME/.local/state/Dart/install/bin"
```

**For Dart versions before 3.10:**
```bash
dart pub global activate dpk
```

**Get dependencies:**
```bash
dpk get
```

### Commands
- **Format code**: `dpk run format`
- **Analyze code**: `dpk run analyze`
- **Run tests**: `dpk run test`
- **Fix issues**: `dpk run fix`

### Code Generation
When working with `luthor_generator/example`:
```bash
cd packages/luthor_generator/example
dart run build_runner build -d
```

### Documentation
The documentation site is located in `./docs` and is built with Astro.

**Setup (first time):**
```bash
cd docs
bun install  # or npm install
```

**Development:**
```bash
cd docs
bun run dev  # or npm run dev
# Visit http://localhost:4321
```

**Build:**
```bash
cd docs
bun run build  # or npm run build
```

**Preview production build:**
```bash
cd docs
bun run preview  # or npm run preview
```

## Coding Conventions

### Language & Style
- Use Dart SDK >= 3.8.0
- Follow `package:lint/strict.yaml` linting rules
- Use `dart format` for code formatting
- Prefer immutability and functional patterns

### Validation Classes

#### Base Classes
- All validations extend `Validation` abstract class
- Validators extend `Validator` class
- Use `@mustCallSuper` when overriding methods that should call parent implementation

#### Validation Pattern
```dart
class CustomValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;

  CustomValidation({String? message, String? Function()? messageFn})
    : customMessage = message,
      customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    // Validation logic here
    return isValid;
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must be valid';

  @override
  Map<String, List<String>>? get errors => null;
}
```

#### Validator Pattern
Validators provide fluent APIs and return `this` for method chaining:
```dart
class CustomValidator extends Validator {
  CustomValidator({super.initialValidations});

  CustomValidator someValidation({
    String? message,
    String? Function()? messageFn,
  }) {
    validations.add(
      SomeValidation(message: message, messageFn: messageFn),
    );
    return this;
  }
}
```

For `StringValidator`, create new instances to maintain immutability:
```dart
StringValidator someValidation({String? message, String? Function()? messageFn}) {
  final newValidations = List<Validation>.from(validations)
    ..add(SomeValidation(message: message, messageFn: messageFn));
  final newValidator = StringValidator(initialValidations: newValidations);
  if (name != null) {
    newValidator.withName(name);
  }
  return newValidator;
}
```

### Testing

#### Test Structure
- Use the `test` package
- Follow pattern matching with sealed classes for validation results
- Use descriptive test names starting with 'should'

#### Test Pattern
```dart
import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is valid', () {
    final result = l.string().validateValue('valid');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, 'valid');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is invalid', () {
    final result = l.string().validateValue(123);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should have errors');
      case SingleValidationError(data: _, errors: _):
        expect(result.errors, isNotEmpty);
    }
  });
}
```

### Documentation
- All public APIs must have documentation comments
- Use `///` for documentation comments
- Reference related validators/validations using `[ClassName]` syntax
- Keep descriptions concise and clear

### Error Messages
- Provide both `message` (String) and `messageFn` (String Function()?) parameters for custom error messages
- Default error messages should use pattern: `'${fieldName ?? 'value'} must be <condition>'`
- Error messages should be user-friendly and actionable

### Exports
- Export all public APIs through the main library file (`luthor.dart`)
- Group related exports together
- Maintain alphabetical order within export groups

## Code Generation (luthor_generator)

### Annotations
- Work with `freezed` classes
- Support `@Luthor()` annotation for schema generation
- Support field-level validators like `@Email()`, `@Min()`, `@Max()`, etc.
- Support `@WithSchemaCustomValidator` for cross-field validation

### Generated Code
For each annotated class, generate:
- `$ClassNameSchema` - The validation schema
- `ClassNameSchemaKeys` - Type-safe keys for field access
- `ClassNameErrorKeys` - Type-safe keys for error handling
- `$ClassNameValidate()` - Validation function with optional `fromJson` deserialization

## Best Practices

1. **Immutability**: Prefer creating new instances over mutating existing ones
2. **Type Safety**: Leverage Dart's type system and null safety features
3. **Method Chaining**: Support fluent APIs by returning the validator instance
4. **Error Handling**: Always provide clear, actionable error messages
5. **Testing**: Write comprehensive tests for all validation logic
6. **Code Generation**: Keep generated code in sync with core library patterns
7. **Documentation**: Document all public APIs with clear examples when appropriate

## Common Patterns

### Creating a New Validator
1. Create validator class extending `Validator` in `lib/src/validators/`
2. Add validation methods that accept `message` and `messageFn` parameters
3. Create corresponding validation classes in `lib/src/validations/`
4. Add tests in `test/validations/`
5. Export in `lib/luthor.dart`

### Adding a String Validation
1. Create validation class in `lib/src/validations/strings/`
2. Extend `Validation` and implement the validation logic
3. Add method to `StringValidator` that creates new instance with validation
4. Add tests in `test/validations/string_validation_test.dart` or create new test file
5. Export in `lib/luthor.dart`

### Supporting Code Generation
1. Create annotation in `lib/src/annotations/validators/`
2. Update generator to handle the new annotation
3. Add tests for generated code
4. Update example to demonstrate usage

## Resources
- Main documentation: https://luthor.netlify.app
- Repository: https://github.com/exaby73/luthor
- Inspired by: https://zod.dev
