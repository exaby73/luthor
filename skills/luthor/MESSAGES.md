# Error messages and translation

Every issue carries an English default message, such as `email must be a valid email address`. This file covers replacing it per validation, rewriting every message at once, and translating by issue code. Issues and error paths are in [SKILL.md](SKILL.md).

## Where a message comes from

The first of these that is set builds an issue's message:

1. `message:` on the validation: a fixed string.
2. `messageBuilder:` on the validation: a function of the issue.
3. `l.messageBuilder`: one global function for every issue without 1 or 2.
4. The default message.

Every type method and modifier takes `message:` and `messageBuilder:`, each covering its own issue:

```dart
final age = l
    .int(message: 'Age must be a whole number') // invalidType
    .min(18, message: 'You must be 18 or older') // tooSmall
    .required(message: 'Enter your age'); // required

final form = l.schema(
  {'age': age},
  message: 'Expected an object', // the input is not a map
).strict(message: 'Unexpected field'); // unrecognizedKey
```

`l.union([...], message: ...)` and `l.oneOf([...], message: ...)` set the message for a value that matches no option or allowed value.

## Message builders

A message builder is a `String Function(ValidationIssue issue)`. The issue it receives already holds the default message, so it can fall back to `issue.message`, and it reads `issue.code`, `issue.params`, `issue.fieldName` and `issue.path`:

```dart
final password = l.string().min(
  8,
  messageBuilder: (issue) =>
      'Use at least ${issue.params['min']} characters',
);
```

Set `l.messageBuilder` once at startup, such as in `main`, to rewrite every message. Each `validate` call reads it when it starts, so a change, such as a new locale, applies from the next call. Set it to `null` to restore the defaults.

```dart
l.messageBuilder = (issue) => switch (issue.code) {
  IssueCode.required => '${issue.fieldName ?? 'This field'} is required.',
  _ => issue.message,
};
```

`IssueCode` is an open set, and minor releases add codes: give every switch on it a `_` case.

## Translating

Switch on the issue code and read the params, never the default message text:

```dart
const labels = {'email': 'E-Mail', 'password': 'Passwort'};

String german(ValidationIssue issue) {
  final field = labels[issue.fieldName] ?? issue.fieldName ?? 'Wert';
  return switch (issue.code) {
    IssueCode.required => '$field ist erforderlich',
    IssueCode.invalidEmail => '$field ist keine gültige E-Mail-Adresse',
    IssueCode.tooShort =>
      '$field muss mindestens ${issue.params['min']} Zeichen lang sein',
    _ => issue.message,
  };
}

void main() {
  l.messageBuilder = german;
}
```

The same lookup turns field keys into labels in one language: a schema field's `fieldName` is its key, such as `confirmPassword`. For a value validated directly, set the label with `.withName('Email')`.

In Flutter, the builder has no `BuildContext`. Keep the current translations in a variable the app updates when the locale changes, and read it in the builder.

## Issue codes

| Code | Raised by | Params |
| --- | --- | --- |
| `required` | `.required()`; `validateSchema(null)` | |
| `invalidType` | the type, such as `l.string()` | `expected` |
| `tooShort`, `tooLong`, `invalidLength` | string `min`, `max`, `length` | `min`, `max`, `length` |
| `tooSmall`, `tooBig` | number `min`, `max` | `min`, `max` |
| `notFinite` | `finite()` | |
| `invalidEmail`, `invalidDateTime`, `invalidEmoji`, `invalidUuid`, `invalidCuid`, `invalidCuid2` | the string format modifiers | |
| `invalidUri`, `invalidUrl` | `uri()`, `url()` | `allowedSchemes` |
| `invalidIp` | `ip()` | `version` |
| `invalidPattern` | `regex()` | `pattern` |
| `missingPrefix`, `missingSuffix`, `missingSubstring` | `startsWith`, `endsWith`, `contains` | `prefix`, `suffix`, `substring` |
| `notOneOf` | `l.oneOf()` | `allowed` |
| `invalidUnion` | `l.union()` | `issues`: the issues of each option |
| `invalidKey` | a map key failing `keyValidator` | `key`, `issues` |
| `unrecognizedKey` | `.strict()` | `key` |
| `custom` | `custom()`, `customWithSchema()` | |
| `tooDeep` | input nested deeper than `l.maxDepth` (512) | `maxDepth` |
| `fromJsonFailed` | a `fromJson` that throws in `validateSchema` | `error` |

## Annotations

Generated models take `message:` and `messageBuilder:` on every annotation. A `messageBuilder` passed to an annotation must be a public top-level or static function, since annotation arguments are constants:

```dart
String weakPassword(ValidationIssue issue) =>
    'Use at least ${issue.params['min']} characters';

// In the model: @HasMin(8, messageBuilder: weakPassword) required String password,
```

No annotation sets a generated field's `required` or `invalidType` message: rewrite those with `l.messageBuilder`.
