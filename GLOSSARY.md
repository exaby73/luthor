# Luthor

Luthor validates Dart values against schemas built with a fluent API, and `luthor_generator` builds those schemas from annotated models.

## Language

### Validators

**Validator**:
An immutable, chainable object that holds an ordered list of validations, checks a value against them, and produces a typed output.
_Avoid_: rule set, checker

**Validator factory**:
The `l` object that starts every validator with a type and holds the global settings, `messageBuilder` and `maxDepth`.
_Avoid_: builder, `Luthor` (the model annotation)

**Validation**:
One rule inside a validator, such as "is a string" or "has at least 3 characters".
_Avoid_: rule, check

**Modifier**:
A validator method that returns a new validator with one more validation, such as `.email()`, `.min()`, or `.required()`.
_Avoid_: rule, constraint

**Type**:
The validation that checks a value's Dart type, started from `l`, such as `l.string()`, `l.int()`, `l.num()`, `l.bool()`, or `l.list()`.
_Avoid_: single value, scalar

**Output**:
The typed value a validator produces when validation succeeds: the input itself for most types, and a new map or list for schemas and collections.
_Avoid_: parsed value, result (for the value)

**Schema**:
A validator built with `l.schema()` that checks a map against named fields.
_Avoid_: using "schema" for the field map, the model, or the validation mode

**Field**:
One named entry of a schema, pairing a key with the validator for its value.
_Avoid_: property, attribute

**Unknown key**:
A key in a schema's input that the schema does not declare; stripped from the output by default, kept by `.passthrough()`, and reported by `.strict()`.
_Avoid_: extra field, additional property

**Union**:
A validator built with `l.union()` that accepts a value passing any of its options.
_Avoid_: anyOf, `validators:` list

**Allowed values**:
The fixed list of values that a validator built with `l.oneOf()` accepts, such as the serialized values of an enum.
_Avoid_: enum validator, literal

**Required**:
A validation that rejects `null` and missing values, added by `.required()`. Unrelated to Dart's `required` keyword.
_Avoid_: mandatory, non-nullable

**Optional**:
The default state of a validator: a `null` or missing value passes.
_Avoid_: nullable (as a validator state)

**Custom validator**:
A function passed to `.custom()` that checks one typed value without access to other fields.
_Avoid_: single-value custom validation

**Schema custom validator**:
A function passed to `.customWithSchema()` that checks one field with access to the sibling fields of its schema and to the root data, through `SchemaData`.
_Avoid_: cross-field validation, schema-aware validation

**Forward reference**:
A reference to a validator that `forwardRef()` resolves at validation time, so a schema can refer to itself or to a schema defined later.
_Avoid_: ForwardRef (as a type name), circular reference (for the mechanism)

**Max depth**:
The limit on how deep schemas, lists, maps and unions may nest inside a validated value; deeper input fails with a `tooDeep` issue.
_Avoid_: recursion limit, cycle detection

### Validation and results

**Validation result**:
What `validate` and `validateSchema` return: a `ValidationSuccess` holding the output, or a `ValidationFailure` holding the issues.
_Avoid_: single validation result, schema validation result, Valid/Invalid

**Schema validation**:
Validating a map against a schema with `validate`, or with `validateSchema` to also convert it with `fromJson`.
_Avoid_: object validation, form validation

**Issue**:
One problem found during validation, with an issue code, an error path, an error message, params and a field name; the source of every error view.
_Avoid_: error object, violation

**Issue code**:
The `IssueCode` that identifies the kind of an issue, such as `required` or `tooShort`.
_Avoid_: error type, error key

**Error message**:
One human-readable string that describes an issue.
_Avoid_: error string

**Message builder**:
A function that builds an issue's error message from the issue, set per validation with `messageBuilder:` or globally with `l.messageBuilder`.
_Avoid_: messageFn, translator

**Error map**:
The flat map of error messages derived from the issues, keyed by error path.
_Avoid_: errors object, error tree

**Error path**:
A dot-separated chain of field keys, map keys and list indices that locates an issue, such as `address.street` or `items.1.id`; the validated value itself has the empty path.
_Avoid_: error key (for the path itself)

**Object-level error**:
An issue at a schema's own path, reported by `.custom()` on the schema.
_Avoid_: `[DEFAULT]` error, form error

**Field name**:
The name used in default error messages: the field key inside a schema, inherited by list elements and map values, or the name from `withName()` when validating directly.
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
