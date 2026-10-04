# Validators are optional by default

A validator accepts `null` and missing values unless it has `.required()`. Zod does the opposite, so Zod users may expect every field to be required. We chose explicit `.required()` because it matches Dart's null safety, where a type is non-nullable only when you say so, and `luthor_generator` maps that directly: a non-nullable field gets `.required()`, a nullable one doesn't.

## Consequences

- A schema validation skips a missing optional field before any of its validations run, so custom validators and schema custom validators on that field don't run either. To make a field conditionally required, put the check in a schema custom validator on a field that is always present, or on the schema itself.
