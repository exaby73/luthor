# Recipes

Patterns for Flutter form fields, cross-field rules, recursive schemas and enums. The API they build on is in [SKILL.md](SKILL.md).

## Flutter form fields

A text field gives `''` when it's empty, never `null`, and `.required()` accepts `''`. Pair `.required()` with `.min(1)`, and put the empty-field message on `.min(1)`:

```dart
final emailField = l
    .string()
    .required(message: 'Enter your email')
    .min(1, message: 'Enter your email')
    .email(message: 'Enter a valid email');

TextFormField(
  decoration: const InputDecoration(labelText: 'Email'),
  validator: (value) => emailField.validate(value).getError(''),
)
```

A value validated on its own reports at the empty path, so `getError('')` gives the first message or `null`, which is the `FormField.validator` contract. Every check on the value runs, so order the chain from the most basic check to the most specific: `getError('')` shows the first failure.

- Whitespace passes `.min(1)`. Validate `value?.trim()`, or add `.regex(RegExp(r'\S'))`.
- An optional field still gives `''`, and `''` fails formats such as `.email()`. Turn empty text into `null` first: `validate(value == null || value.isEmpty ? null : value)`.
- Numbers arrive as text, and `l.int()` rejects strings. Validate the text, then the parsed value:

  ```dart
  final ageField = l
      .string()
      .required()
      .min(1, message: 'Enter your age')
      .regex(RegExp(r'^\d+$'), message: 'Enter a whole number')
      .custom((text) => int.parse(text) >= 18, message: 'You must be 18 or older');
  ```

  A `custom` that throws fails the value, so `int.parse('')` here only adds one more failure after the first.

To validate a whole form at once, validate a map of the field values with a schema, and show each field's error with `errorText`:

```dart
final signup = l.schema({
  'email': l.string().required().min(1).email(),
  'password': l.string().required().min(8),
});

ValidationResult<Map<String, Object?>?> result = const ValidationSuccess(null);

void submit() {
  setState(() {
    result = signup.validate({
      'email': emailController.text,
      'password': passwordController.text,
    });
  });
  if (result case ValidationSuccess()) {
    // Send the form.
  }
}

// In build():
TextField(
  controller: emailController,
  decoration: InputDecoration(errorText: result.getError('email')),
)
```

With a generated model, validate with `$SignupFormValidate(...)` and look errors up with `SignupFormErrorKeys`; the success data is the model. Default messages use the field key (`password must be at least 8 characters long`), so set `message:` or a message builder for user-facing text (see [MESSAGES.md](MESSAGES.md)).

## Cross-field rules

Two hooks see more than one field. Pick by where the error belongs and when the rule must run.

### On a field: `customWithSchema`

`customWithSchema` reports at the field's own path, so the error shows next to that field:

```dart
final signup = l.schema({
  'password': l.string().required().min(8),
  'confirmPassword': l
      .string()
      .required()
      .customWithSchema(
        (value, data) => value == data['password'],
        message: 'Passwords must match',
      ),
});
```

- The function receives the typed value and a `SchemaData`: a read-only map of the sibling fields **as they appear in the input**, before validation, with keys turned into strings. A sibling may be missing, `null` or of the wrong type, and a sibling whose own validator fails still appears with its raw value. Test it with `is` before using it as a type, and return `true` when it has the wrong type, so only the sibling's own validator reports it. A cast such as `data['limit'] as int` throws, which counts as `false` and adds a misleading second error. `data.root` is the outermost schema's input, for rules that reach across nested schemas. To compare validated values, use `.custom()` on the schema instead.
- It runs only when its own field is present, non-null and of the right type. On an optional field, a missing value skips it. Make the field `.required()`, or put the rule on a field that is always present, or on the schema.
- Inside a list, it receives the data of the schema that holds the list.

With code generation, use `@WithSchemaCustomValidator(fn)` with a public top-level or static function:

```dart
bool passwordsMatch(String value, SchemaData data) =>
    value == data['password'];

bool atMostLimit(int value, SchemaData data) {
  final limit = data['limit'];
  if (limit is! int) return true;
  return value <= limit;
}
```

### On the schema: `custom`

`.custom()` on a schema receives the validated output map and runs only when every field passed, so values have their validated types. It reports one object-level error at the schema's path (`''` for the root schema):

```dart
final range = l.schema({
  'start': l.int().required(),
  'end': l.int().required(),
}).custom(
  (data) => (data['start']! as int) < (data['end']! as int),
  message: 'Start must be before end',
);

final result = range.validate({'start': 5, 'end': 1});
result.getError(''); // Start must be before end
```

### Conditionally required fields

A missing optional field runs none of its validations, so the condition must live elsewhere. To require `company` when `accountType` is `business`:

```dart
final account = l.schema({
  'accountType': l.oneOf(['personal', 'business']).required(),
  'company': l.string(),
}).custom(
  (data) => data['accountType'] != 'business' || data['company'] != null,
  message: 'Enter a company for a business account',
);
```

The error is object-level, at `''`. To show it next to `company`, read `getError('')` into that field's `errorText`, or put a `customWithSchema` on `accountType` (always present) that checks `data['company']`, which reports at `accountType`.

## Recursive schemas

A schema that refers to itself, or to a schema defined later, wraps the reference in `forwardRef`, which resolves it at validation time. Give the variable an explicit type, since the self-reference makes inference circular:

```dart
final SchemaValidator category = l.schema({
  'name': l.string().required(),
  'children': l.list(forwardRef(() => category.required())),
});
```

Errors nest by path, such as `children.0.children.1.name`. Mutual recursion works the same way, with `forwardRef` on each reference. Input nested deeper than `l.maxDepth` (512 levels by default) fails with a `tooDeep` issue instead of overflowing the stack.

Inside a function, declare the variable `late final` first:

```dart
SchemaValidator treeSchema() {
  late final SchemaValidator node;
  node = l.schema({
    'value': l.string().required(),
    'children': l.list(forwardRef(() => node.required())),
  });
  return node;
}
```

Generated models need none of this: the generator wraps every nested schema in `forwardRef`.

## Enums

Validate an enum's serialized values with `l.oneOf`, then convert:

```dart
enum Role { admin, member }

final role = l.oneOf(Role.values.map((role) => role.name).toList()).required();

switch (role.validate('admin')) {
  case ValidationSuccess(:final data):
    print(Role.values.byName(data)); // Role.admin
  case ValidationFailure(:final messages):
    print(messages); // [value must be one of: admin, member]
}
```

`l.oneOf` compares with `==` and outputs the matching allowed value, so `l.oneOf(Role.values)` validates enum instances already in memory. For values renamed with `@JsonValue` or `@JsonEnum`, list the serialized strings. A generated model does this for every enum field, honouring those annotations.
