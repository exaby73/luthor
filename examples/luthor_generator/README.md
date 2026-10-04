Runnable examples for `luthor_generator`, covering `freezed`, `json_serializable`
and `dart_mappable` classes. Each file in `lib/` has a `main` you can run.

This package is outside the pub workspace and needs Dart 3.13 or later
(see `.tool-versions`). It depends on `luthor` and `luthor_generator` by path.

```sh
dart pub get
dart run build_runner build
dart run lib/sample.dart
```

From the repository root, `dpk run build` runs the code generation step.
