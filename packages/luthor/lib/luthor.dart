/// A Dart validation library inspired by Zod, with typed output and
/// structured issues.
///
/// Start every validator from [l]:
///
/// ```dart
/// import 'package:luthor/luthor.dart';
///
/// final user = l.schema({
///   'email': l.string().email().required(),
///   'age': l.int().min(18),
/// });
///
/// switch (user.validate({'email': 'dev@example.com'})) {
///   case ValidationSuccess(:final data):
///     print(data);
///   case ValidationFailure(:final errors):
///     print(errors);
/// }
/// ```
library;

export 'src/annotations/luthor.dart';
export 'src/annotations/validators/contains.dart';
export 'src/annotations/validators/cuid.dart';
export 'src/annotations/validators/cuid2.dart';
export 'src/annotations/validators/custom.dart';
export 'src/annotations/validators/custom_with_schema.dart';
export 'src/annotations/validators/date_time.dart';
export 'src/annotations/validators/email.dart';
export 'src/annotations/validators/emoji.dart';
export 'src/annotations/validators/ends_with.dart';
export 'src/annotations/validators/file.dart';
export 'src/annotations/validators/forward_ref.dart';
export 'src/annotations/validators/ip.dart';
export 'src/annotations/validators/length.dart';
export 'src/annotations/validators/max.dart';
export 'src/annotations/validators/min.dart';
export 'src/annotations/validators/regex.dart';
export 'src/annotations/validators/starts_with.dart';
export 'src/annotations/validators/uri.dart';
export 'src/annotations/validators/url.dart';
export 'src/annotations/validators/uuid.dart';
export 'src/types/ip.dart';
export 'src/validation_issue.dart';
export 'src/validation_result.dart';
export 'src/validator.dart';
