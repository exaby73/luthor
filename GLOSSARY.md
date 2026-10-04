# Luthor

Luthor validates Dart values against schemas built with a fluent API, and `luthor_generator` builds those schemas from annotated models.

## Language

### Validators

**Validator**:
An immutable, chainable object that holds an ordered list of validations and checks a value against them.
_Avoid_: rule set, checker

**Validation**:
One rule inside a validator, such as "is a string" or "has at least 3 characters".
_Avoid_: rule, check

**Modifier**:
A validator method that returns a new validator with one more validation, such as `.email()`, `.min()`, or `.required()`.
_Avoid_: rule, constraint

**Type**:
The validation that checks a value's Dart type, started from `l`, such as `l.string()`, `l.int()`, or `l.list()`.
_Avoid_: single value, scalar

**Schema**:
A validator built with `l.schema()` that checks a map against named fields.
_Avoid_: using "schema" for the field map, the model, or the validation mode

**Field**:
One named entry of a schema, pairing a key with the validator for its value.
_Avoid_: property, attribute

**Required**:
A validation that rejects `null` and missing values, added by `.required()`. Unrelated to Dart's `required` keyword.
_Avoid_: mandatory, non-nullable

**Optional**:
The default state of a validator: a `null` or missing value passes.
_Avoid_: nullable (as a validator state)

**Custom validator**:
A function passed to `.custom()` that checks one value without access to other fields.
_Avoid_: single-value custom validation

**Schema custom validator**:
A function passed to `.customWithSchema()` that checks one field with access to the sibling fields of its schema.
_Avoid_: cross-field validation, schema-aware validation

**Forward reference**:
A reference to a validator that `forwardRef()` resolves at validation time, so a schema can refer to itself or to a schema defined later.
_Avoid_: ForwardRef (as a type name), circular reference (for the mechanism)

### Validation and results

**Single-value validation**:
Validating one value with `validateValue`, which returns a `SingleValidationResult`.
_Avoid_: value validation, scalar validation

**Schema validation**:
Validating a map against a schema with `validateSchema`, which returns a `SchemaValidationResult`.
_Avoid_: object validation, form validation

**Error message**:
One human-readable string a validation produces when it fails.
_Avoid_: error string

**Error map**:
The nested map of error messages that schema validation returns, keyed by field.
_Avoid_: errors object, error tree

**Error path**:
A dot-separated chain of field keys that locates an error message inside an error map, such as `address.street`.
_Avoid_: error key (for the path itself)

**Field name**:
The name a validation uses in its error messages, taken from the field key inside a schema or from `withName()`.
_Avoid_: label, display name

### Code generation

**Model**:
A Dart class annotated with `@luthor` that `luthor_generator` builds a schema for.
_Avoid_: schema class, naming model classes `*Schema`

**Generated schema**:
The `$<Model>Schema` validator that `luthor_generator` emits for a model.
_Avoid_: schema variable

**Auto-generated schema**:
A generated schema for a class without `@luthor`, emitted because a model's field uses that class.
_Avoid_: discovered class

**Schema keys**:
The generated `<Model>SchemaKeys` record of field keys as they appear in the input map.
_Avoid_: field keys

**Error keys**:
The generated `<Model>ErrorKeys` record of error paths for the model's fields.
_Avoid_: error names

**Validate function**:
The generated `$<Model>Validate` function that validates a map against the generated schema and converts it to the model.
_Avoid_: validation function, validator function

**`validateSelf` extension**:
The generated extension method that validates an existing model instance against its generated schema.
_Avoid_: self-validation
