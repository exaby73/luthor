import 'package:luthor/luthor.dart';

class StringIpValidation extends Validation {
  final IpVersion? version;
  final String? customMessage;
  final String? Function()? customMessageFn;

  StringIpValidation({
    this.version,
    String? message,
    String? Function()? messageFn,
  }) : customMessage = message,
       customMessageFn = messageFn;

  static const _ipv4Regex =
      r'\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b';
  static final _ipv4RegexObject = RegExp(_ipv4Regex);

  static const _ipv6Regex =
      r'\b(([0-9a-fA-F]{1,4}:){7}([0-9a-fA-F]{1,4}|:)|(([0-9a-fA-F]{1,4}:){1,7}:)|(([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4})|(([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2})|(([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3})|(([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4})|(([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5})|([0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6}))|(::([0-9a-fA-F]{1,4}:){1,7}|::))\b';
  static final _ipv6RegexObject = RegExp(_ipv6Regex);

  static const _ipRegex = '$_ipv4Regex|$_ipv6Regex';
  static final _ipRegexObject = RegExp(_ipRegex);

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;

    switch (version) {
      case IpVersion.v4:
        return _ipv4RegexObject.hasMatch(value);
      case IpVersion.v6:
        return _ipv6RegexObject.hasMatch(value);
      default:
        return _ipRegexObject.hasMatch(value);
    }
  }

  @override
  String? get message {
    final v = version != null ? version!.name : '';
    return customMessage ??
        '${fieldName ?? 'value'} must be a valid IP$v address';
  }

  @override
  Map<String, List<String>>? get errors => null;
}
