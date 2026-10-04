import 'package:luthor/luthor.dart';

void main() {
  // Every validator starts from `l` and is optional by default.
  print(l.string().email().validate(null));
  print(l.string().email().required().validate(null));

  // Modifiers chain in any order, and every chain is a new validator.
  final username = l.string().required().min(3).max(20);
  print(username.validate('lu'));

  // Required validators have typed output, without code generation.
  switch (l.int().required().min(18).validate(42)) {
    case ValidationSuccess(:final data):
      print('An int: ${data + 1}');
    case ValidationFailure(:final messages):
      print(messages);
  }

  // Strings support common formats.
  print(l.string().dateTime().validate('2026-06-17T12:00:00Z'));
  print(l.string().uri(allowedSchemes: ['https']).validate('https://x.dev'));
  print(l.string().emoji().validate('🦄'));
  print(l.string().uuid().validate('123e4567-e89b-12d3-a456-426614174000'));
  print(l.string().ip(version: IpVersion.v4).validate('192.168.1.1'));
  print(l.string().regex(RegExp(r'^[a-z]+$')).validate('luthor'));

  // Other types mirror Dart types.
  print(l.num().validate(1.5));
  print(l.double().finite().validate(double.nan));
  print(l.bool().validate(true));
  print(l.nullValue().validate(null));
  print(l.any().required().validate('anything'));
  print(l.oneOf(['admin', 'member']).validate('owner'));

  // Lists take one element validator; unions accept any of their options.
  print(l.list(l.union([l.string().email(), l.int().min(1)])).validate([0]));

  // Schemas report issues by path, and strip unknown keys by default.
  final signup = l.schema({
    'email': l.string().email().required(),
    'password': l.string().min(8).required(),
    'confirmPassword': l
        .string()
        .customWithSchema(
          (value, data) => value == data['password'],
          message: 'Passwords must match',
        )
        .required(),
    'tags': l.list(l.string().min(2).required()),
  });

  final result = signup.validate({
    'email': 'user@example.com',
    'password': 'secret123',
    'confirmPassword': 'secret',
    'tags': ['ok', 'x'],
  });
  print(result.errors);
  print(result.getError('confirmPassword'));
  print(result.getError('tags.1'));

  // validateSchema converts valid data with fromJson.
  final user = signup.validateSchema({
    'email': 'user@example.com',
    'password': 'secret123',
    'confirmPassword': 'secret123',
  }, fromJson: (json) => json['email']! as String);
  print(user);

  // One global hook translates or rewrites every default message.
  l.messageBuilder = (issue) => switch (issue.code) {
    IssueCode.required => 'Please fill in ${issue.fieldName ?? 'this field'}',
    _ => issue.message,
  };
  print(signup.validate(<String, Object?>{}).messages);
  l.messageBuilder = null;
}
