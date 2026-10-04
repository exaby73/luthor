part of '../validator.dart';

final class _Check {
  const _Check(
    this.code,
    this.test,
    this.describe, {
    this.params = const {},
    this.message,
    this.messageBuilder,
  });

  final IssueCode code;
  final bool Function(Object value, _Context context) test;
  final String Function(String field) describe;
  final Map<String, Object?> params;
  final String? message;
  final MessageBuilder? messageBuilder;

  ValidationIssue? check(Object value, _Context context) {
    return test(value, context) ? null : issue(context);
  }

  ValidationIssue issue(_Context context, {Map<String, Object?>? params}) {
    return context.issue(
      code,
      describe,
      params: params ?? this.params,
      message: message,
      messageBuilder: messageBuilder,
    );
  }
}

_Check _typeCheck(
  String expected,
  bool Function(Object value) test,
  String Function(String field) describe,
  String? message,
  MessageBuilder? messageBuilder,
) {
  return _Check(
    IssueCode.invalidType,
    (value, _) => test(value),
    describe,
    params: {'expected': expected},
    message: message,
    messageBuilder: messageBuilder,
  );
}

_Check _requiredCheck(String? message, MessageBuilder? messageBuilder) {
  return _Check(
    IssueCode.required,
    (_, _) => false,
    (field) => '$field is required',
    message: message,
    messageBuilder: messageBuilder,
  );
}

void _checkLength(int length, String name) {
  if (length < 0) {
    throw ArgumentError.value(length, name, 'must not be negative');
  }
}
