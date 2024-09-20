import 'package:luthor/src/validation.dart';

class StringIpValidation extends Validation {
  StringIpValidation({this.version, required this.customMessage});

  final String? customMessage;
  final String? version;

  static const _ipv4Regex =
      r'\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b';

  static const _ipv6Regex =
      r'\b(([0-9a-fA-F]{1,4}:){7}([0-9a-fA-F]{1,4}|:)|(([0-9a-fA-F]{1,4}:){1,7}:)|(([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4})|(([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2})|(([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3})|(([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4})|(([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5})|([0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6}))|(::([0-9a-fA-F]{1,4}:){1,7}|::))\b';

  static const _ipRegex = '$_ipv4Regex|$_ipv6Regex';
  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;

    switch (version) {
      case 'v4':
        return RegExp(_ipv4Regex).hasMatch(value);
      case 'v6':
        return RegExp(_ipv6Regex).hasMatch(value);
      default:
        return RegExp(_ipRegex).hasMatch(value);
    }
  }

  @override
  // TODO: implement message
  String? get message =>
      customMessage ?? '${fieldName ?? 'value'} must be a valid ip address';

  @override
  Map<String, List<String>>? get errors => null;
}
