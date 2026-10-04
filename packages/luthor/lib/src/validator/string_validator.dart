part of '../validator.dart';

/// Validates strings. Created by `l.string()`.
///
/// [O] is `String?` until `.required()` makes it `String`.
///
/// Lengths count UTF-16 code units, like [String.length], so an emoji such as
/// `'😀'` has a length of 2.
final class StringValidator<O extends String?> extends Validator<O>
    with _Modifiers<String, O, StringValidator<O>> {
  StringValidator._(super._spec) : super._();

  @override
  StringValidator<O> _copy(_Spec spec) => StringValidator<O>._(spec);

  StringValidator<O> _with(
    IssueCode code,
    bool Function(String value) test,
    String Function(String field) describe, {
    Map<String, Object?> params = const {},
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _copy(
      _spec.withCheck(
        _Check(
          code,
          (value, _) => test(value as String),
          describe,
          params: params,
          message: message,
          messageBuilder: messageBuilder,
        ),
      ),
    );
  }

  /// Returns a copy of this validator that rejects `null` and missing values.
  StringValidator<String> required({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return StringValidator<String>._(
      _spec.withRequired(message, messageBuilder),
    );
  }

  /// Requires at least [minLength] characters.
  ///
  /// Throws an [ArgumentError] if [minLength] is negative.
  StringValidator<O> min(
    int minLength, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    _checkLength(minLength, 'minLength');
    return _with(
      IssueCode.tooShort,
      (value) => value.length >= minLength,
      (field) =>
          '$field must be at least $minLength '
          'character${minLength == 1 ? '' : 's'} long',
      params: {'min': minLength},
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires at most [maxLength] characters.
  ///
  /// Throws an [ArgumentError] if [maxLength] is negative.
  StringValidator<O> max(
    int maxLength, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    _checkLength(maxLength, 'maxLength');
    return _with(
      IssueCode.tooLong,
      (value) => value.length <= maxLength,
      (field) =>
          '$field must not be more than $maxLength '
          'character${maxLength == 1 ? '' : 's'} long',
      params: {'max': maxLength},
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires exactly [length] characters.
  ///
  /// Throws an [ArgumentError] if [length] is negative.
  StringValidator<O> length(
    int length, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    _checkLength(length, 'length');
    return _with(
      IssueCode.invalidLength,
      (value) => value.length == length,
      (field) =>
          '$field must be exactly $length '
          'character${length == 1 ? '' : 's'} long',
      params: {'length': length},
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires an email address.
  ///
  /// The check follows the RFC 5322 address syntax. It accepts single-label
  /// domains such as `user@localhost`, does not limit the local part to 64
  /// characters, and rejects internationalized (Unicode) addresses.
  StringValidator<O> email({String? message, MessageBuilder? messageBuilder}) {
    return _with(
      IssueCode.invalidEmail,
      isEmail,
      (field) => '$field must be a valid email address',
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires an ISO 8601 date or date-time in extended format, such as
  /// `2026-06-17`, `2026-06-17 12:00` or `2026-06-17T12:00:00.000Z`.
  ///
  /// Impossible dates and times, such as `2023-02-30` or `25:00`, fail. The
  /// basic format without separators (`20260617`) fails. Every accepted
  /// string is also accepted by [DateTime.parse].
  StringValidator<O> dateTime({
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _with(
      IssueCode.invalidDateTime,
      isDateTime,
      (field) => '$field must be a valid date',
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires an absolute URI: one with a scheme, such as `https://x.dev` or
  /// `mailto:dev@x.dev`, and no whitespace.
  ///
  /// When [allowedSchemes] is given, the scheme must be one of them, compared
  /// case-insensitively.
  StringValidator<O> uri({
    List<String>? allowedSchemes,
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _with(
      IssueCode.invalidUri,
      (value) => isUri(value, allowedSchemes),
      (field) => _schemeMessage('$field must be a valid uri', allowedSchemes),
      params: {'allowedSchemes': allowedSchemes},
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires a URL with a scheme and a host, with a scheme in
  /// [allowedSchemes] when given, compared case-insensitively.
  ///
  /// The host and port are not checked further, so `http://exa_mple.com` and
  /// port `99999` pass.
  StringValidator<O> url({
    List<String>? allowedSchemes,
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _with(
      IssueCode.invalidUrl,
      (value) => isUrl(value, allowedSchemes),
      (field) => _schemeMessage('$field must be a valid URL', allowedSchemes),
      params: {'allowedSchemes': allowedSchemes},
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires a string made only of emoji, including skin tones, keycaps,
  /// flags and joined sequences such as `👨‍👩‍👧`.
  ///
  /// Symbols that only have a text presentation, such as `★` or `→`, fail
  /// unless followed by the emoji variation selector `U+FE0F`.
  StringValidator<O> emoji({String? message, MessageBuilder? messageBuilder}) {
    return _with(
      IssueCode.invalidEmoji,
      isEmoji,
      (field) => '$field must be a valid emoji',
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires a UUID in the 8-4-4-4-12 hexadecimal format.
  ///
  /// Any version and variant digit is accepted.
  StringValidator<O> uuid({String? message, MessageBuilder? messageBuilder}) {
    return _with(
      IssueCode.invalidUuid,
      isUuid,
      (field) => '$field must be a valid uuid',
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires a CUID: a `c` followed by at least 8 characters that are not
  /// whitespace or `-`, case-insensitively.
  ///
  /// This is a format check only.
  StringValidator<O> cuid({String? message, MessageBuilder? messageBuilder}) {
    return _with(
      IssueCode.invalidCuid,
      isCuid,
      (field) => '$field must be a valid cuid',
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires a CUID2: a lowercase letter followed by lowercase letters and
  /// digits.
  ///
  /// This is a format check only, so any lowercase word passes.
  StringValidator<O> cuid2({String? message, MessageBuilder? messageBuilder}) {
    return _with(
      IssueCode.invalidCuid2,
      isCuid2,
      (field) => '$field must be a valid cuid2',
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires an IP address of [version], or of either version when
  /// [version] is `null`.
  ///
  /// The whole string must be the address. IPv4 octets must not have leading
  /// zeros. IPv6 accepts `::` compression, such as `::1` and `::`, and an
  /// embedded IPv4 address, but not a zone such as `%eth0`.
  StringValidator<O> ip({
    IpVersion? version,
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _with(
      IssueCode.invalidIp,
      (value) => isIp(value, version),
      (field) => '$field must be a valid IP${version?.name ?? ''} address',
      params: {'version': version},
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires a match of [pattern] anywhere in the string.
  ///
  /// [pattern] is not anchored; use `^` and `$` to match the whole string.
  /// Its flags, such as `caseSensitive`, apply.
  StringValidator<O> regex(
    RegExp pattern, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _with(
      IssueCode.invalidPattern,
      pattern.hasMatch,
      (field) => '$field must match the pattern ${pattern.pattern}',
      params: {'pattern': pattern.pattern},
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires the string to start with [prefix].
  StringValidator<O> startsWith(
    String prefix, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _with(
      IssueCode.missingPrefix,
      (value) => value.startsWith(prefix),
      (field) => '$field does not start with "$prefix"',
      params: {'prefix': prefix},
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires the string to end with [suffix].
  StringValidator<O> endsWith(
    String suffix, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _with(
      IssueCode.missingSuffix,
      (value) => value.endsWith(suffix),
      (field) => '$field does not end with "$suffix"',
      params: {'suffix': suffix},
      message: message,
      messageBuilder: messageBuilder,
    );
  }

  /// Requires the string to contain [substring].
  StringValidator<O> contains(
    String substring, {
    String? message,
    MessageBuilder? messageBuilder,
  }) {
    return _with(
      IssueCode.missingSubstring,
      (value) => value.contains(substring),
      (field) => '$field does not contain "$substring"',
      params: {'substring': substring},
      message: message,
      messageBuilder: messageBuilder,
    );
  }
}

String _schemeMessage(String message, List<String>? allowedSchemes) {
  if (allowedSchemes == null || allowedSchemes.isEmpty) return message;
  final plural = allowedSchemes.length != 1;
  return '$message. Allowed ${plural ? 'schemes are' : 'scheme is'} '
      '${allowedSchemes.join(', ')}';
}
