import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

Matcher isValidWith(Object? data) {
  return isA<ValidationSuccess<Object?>>().having(
    (result) => result.data,
    'data',
    data,
  );
}

Matcher isInvalidWith(List<String> messages) {
  return isA<ValidationFailure<Object?>>().having(
    (result) => result.messages,
    'messages',
    messages,
  );
}

Matcher hasErrors(Map<String, List<String>> errors) {
  return isA<ValidationFailure<Object?>>().having(
    (result) => result.errors,
    'errors',
    errors,
  );
}

Matcher isIssue({
  IssueCode? code,
  List<Object>? path,
  String? message,
  Object? params,
  Object? fieldName,
}) {
  var matcher = isA<ValidationIssue>();
  if (code != null) {
    matcher = matcher.having((issue) => issue.code, 'code', code);
  }
  if (path != null) {
    matcher = matcher.having((issue) => issue.path, 'path', path);
  }
  if (message != null) {
    matcher = matcher.having((issue) => issue.message, 'message', message);
  }
  if (params != null) {
    matcher = matcher.having((issue) => issue.params, 'params', params);
  }
  if (fieldName != null) {
    matcher = matcher.having(
      (issue) => issue.fieldName,
      'fieldName',
      fieldName,
    );
  }
  return matcher;
}
