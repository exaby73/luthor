# luthor_generator example

Add `luthor` as a dependency, and `luthor_generator` and `build_runner` as dev
dependencies. This example also uses `json_serializable`, which is optional:
a hand-written `fromJson` works too.

```sh
dart pub add luthor json_annotation dev:luthor_generator dev:build_runner dev:json_serializable
```

Annotate a model with `@luthor`. Put validation annotations on the constructor
parameters or on the fields. The class needs a `fromJson` factory, and
`validateSelf()` is generated only when it also has a `toJson` method:

```dart
// lib/user.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'user.g.dart';

@luthor
@JsonSerializable()
class User {
  const User({
    @HasMin(2) required this.name,
    @IsEmail() required this.email,
    @HasMin(0) this.age,
  });

  final String name;
  final String email;
  final int? age;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

Generate the code:

```sh
dart run build_runner build
```

This adds `$UserSchema`, `$UserValidate`, `UserSchemaKeys`, `UserErrorKeys`
and a `validateSelf()` extension to `user.g.dart`. Validate JSON with
`$UserValidate`, and an existing instance with `validateSelf()`:

```dart
import 'package:luthor/luthor.dart';

import 'user.dart';

void main() {
  final result = $UserValidate({'name': 'A', 'email': 'not-an-email'});

  switch (result) {
    case SchemaValidationSuccess(data: final user):
      print('Valid: ${user.name}');
    case SchemaValidationError(errors: final errors):
      print(errors);
      print(result.getError(UserErrorKeys.email));
  }

  const user = User(name: 'Ada', email: 'ada@example.com');
  print(user.validateSelf().isValid); // true
}
```

The generator also works with `freezed` and `dart_mappable` classes. See
[`examples/luthor_generator`](https://github.com/exaby73/luthor/tree/main/examples/luthor_generator)
in the repository for runnable examples, and the
[documentation](https://luthor.ex3.dev) for every annotation.
