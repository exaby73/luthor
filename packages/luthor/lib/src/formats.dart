import 'package:luthor/src/types/ip.dart';

final _email = RegExp(
  r'''^([-!#-'*+/-9=?A-Z^-~]+(\.[-!#-'*+/-9=?A-Z^-~]+)*|"([]!#-[^-~ \t]|(\\[\t -~]))+")@([0-9A-Za-z]([0-9A-Za-z-]{0,61}[0-9A-Za-z])?(\.[0-9A-Za-z]([0-9A-Za-z-]{0,61}[0-9A-Za-z])?)*|\[((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(\.(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])){3}|IPv6:((((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){6}|::((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){5}|[0-9A-Fa-f]{0,4}::((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){4}|(((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):)?(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}))?::((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){3}|(((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){0,2}(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}))?::((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){2}|(((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){0,3}(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}))?::(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):|(((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){0,4}(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}))?::)((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3})|(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(\.(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])){3})|(((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){0,5}(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}))?::(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3})|(((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){0,6}(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}))?::)|(?!IPv6:)[0-9A-Za-z-]*[0-9A-Za-z]:[!-Z^-~]+)])$''',
);
final _uuid = RegExp(
  r'^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$',
);
final _cuid = RegExp(r'^c[^\s-]{8,}$', caseSensitive: false);
final _cuid2 = RegExp(r'^[a-z][a-z0-9]*$');
final _emoji = RegExp(
  r'^(?:\p{Regional_Indicator}{2}'
  r'|[0-9#*]\uFE0F?\u20E3'
  r'|(?:(?=\p{Emoji_Presentation})\p{Extended_Pictographic}\uFE0F?'
  r'|\p{Extended_Pictographic}\uFE0F)'
  r'\p{Emoji_Modifier}?'
  r'(?:[\u{E0020}-\u{E007E}]+\u{E007F})?'
  r'(?:\u200D\p{Extended_Pictographic}\uFE0F?\p{Emoji_Modifier}?)*)+$',
  unicode: true,
);
final _ipv4 = RegExp(
  r'^(?:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)\.){3}'
  r'(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)$',
);
final _ipv6Group = RegExp(r'^[0-9a-fA-F]{1,4}$');
final _dateTime = RegExp(
  r'^(\d{4})-(\d{2})-(\d{2})'
  r'(?:[Tt ](\d{2}):(\d{2})(?::(\d{2})(?:[.,]\d+)?)?'
  r'(?:[Zz]|[+-](\d{2})(?::?(\d{2}))?)?)?$',
);
final _whitespace = RegExp(r'\s');

bool isEmail(String value) => _email.hasMatch(value);

bool isUuid(String value) => _uuid.hasMatch(value);

bool isCuid(String value) => _cuid.hasMatch(value);

bool isCuid2(String value) => _cuid2.hasMatch(value);

bool isEmoji(String value) => _emoji.hasMatch(value);

bool isIp(String value, IpVersion? version) {
  return switch (version) {
    IpVersion.v4 => _ipv4.hasMatch(value),
    IpVersion.v6 => _isIpv6(value),
    null => _ipv4.hasMatch(value) || _isIpv6(value),
  };
}

bool _isIpv6(String value) {
  final halves = value.split('::');
  if (halves.length > 2) return false;
  final compressed = halves.length == 2;
  final groups = [
    for (final half in halves)
      if (half.isNotEmpty) ...half.split(':'),
  ];
  var groupCount = groups.length;
  if (groups.isNotEmpty && value.endsWith(groups.last)) {
    if (_ipv4.hasMatch(groups.last)) {
      groups.removeLast();
      groupCount++;
    }
  }
  if (!groups.every(_ipv6Group.hasMatch)) return false;
  return compressed ? groupCount <= 7 : groupCount == 8;
}

bool isDateTime(String value) {
  final match = _dateTime.firstMatch(value);
  if (match == null) return false;
  int? part(int group) {
    final text = match.group(group);
    return text == null ? null : int.parse(text);
  }

  final year = part(1)!;
  final month = part(2)!;
  final day = part(3)!;
  if (month < 1 || month > 12) return false;
  if (day < 1 || day > DateTime.utc(year, month + 1, 0).day) return false;
  if ((part(4) ?? 0) > 23 || (part(5) ?? 0) > 59 || (part(6) ?? 0) > 59) {
    return false;
  }
  if ((part(7) ?? 0) > 23 || (part(8) ?? 0) > 59) return false;
  return DateTime.tryParse(value) != null;
}

bool isUri(String value, List<String>? allowedSchemes) {
  if (_whitespace.hasMatch(value)) return false;
  final uri = Uri.tryParse(value);
  if (uri == null || !uri.hasScheme) return false;
  return _isAllowedScheme(uri.scheme, allowedSchemes);
}

bool isUrl(String value, List<String>? allowedSchemes) {
  if (_whitespace.hasMatch(value)) return false;
  final uri = Uri.tryParse(value);
  if (uri == null || !uri.hasScheme || uri.host.isEmpty) return false;
  return _isAllowedScheme(uri.scheme, allowedSchemes);
}

bool _isAllowedScheme(String scheme, List<String>? allowedSchemes) {
  if (allowedSchemes == null) return true;
  final lowercase = scheme.toLowerCase();
  return allowedSchemes.any((allowed) => allowed.toLowerCase() == lowercase);
}

bool isFile(Object value) {
  final typeName = value.runtimeType.toString().toLowerCase();
  return typeName.contains('file') ||
      typeName.contains('multipart') ||
      typeName.contains('stream') ||
      typeName.contains('bytes') ||
      typeName.contains('uint8list') ||
      typeName.contains('bytedata');
}
