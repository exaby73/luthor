import 'package:luthor/src/types/ip.dart';

final _email = RegExp(
  r'''^([-!#-'*+/-9=?A-Z^-~]+(\.[-!#-'*+/-9=?A-Z^-~]+)*|"([]!#-[^-~ \t]|(\\[\t -~]))+")@([0-9A-Za-z]([0-9A-Za-z-]{0,61}[0-9A-Za-z])?(\.[0-9A-Za-z]([0-9A-Za-z-]{0,61}[0-9A-Za-z])?)*|\[((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(\.(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])){3}|IPv6:((((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){6}|::((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){5}|[0-9A-Fa-f]{0,4}::((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){4}|(((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):)?(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}))?::((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){3}|(((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){0,2}(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}))?::((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){2}|(((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){0,3}(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}))?::(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):|(((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){0,4}(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}))?::)((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3})|(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(\.(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])){3})|(((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){0,5}(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}))?::(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3})|(((0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}):){0,6}(0|[1-9A-Fa-f][0-9A-Fa-f]{0,3}))?::)|(?!IPv6:)[0-9A-Za-z-]*[0-9A-Za-z]:[!-Z^-~]+)])$''',
);
final _uuid = RegExp(
  r'^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$',
);
final _cuid = RegExp(r'c[^\s-]{8,}$', caseSensitive: false);
final _cuid2 = RegExp(r'^[a-z][a-z0-9]*$');
final _emoji = RegExp(
  r'^(©|®|[ -㌀]|\ud83c[퀀-\udfff]|\ud83d[퀀-\udfff]|\ud83e[퀀-\udfff])+$',
);
const _ipv4 =
    r'\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b';
const _ipv6 =
    r'\b(([0-9a-fA-F]{1,4}:){7}([0-9a-fA-F]{1,4}|:)|(([0-9a-fA-F]{1,4}:){1,7}:)|(([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4})|(([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2})|(([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3})|(([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4})|(([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5})|([0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6}))|(::([0-9a-fA-F]{1,4}:){1,7}|::))\b';
final _ipv4Pattern = RegExp(_ipv4);
final _ipv6Pattern = RegExp(_ipv6);
final _whitespace = RegExp(r'\s');

bool isEmail(String value) => _email.hasMatch(value);

bool isUuid(String value) => _uuid.hasMatch(value);

bool isCuid(String value) => _cuid.hasMatch(value);

bool isCuid2(String value) => _cuid2.hasMatch(value);

bool isEmoji(String value) => _emoji.hasMatch(value);

bool isIp(String value, IpVersion? version) {
  return switch (version) {
    IpVersion.v4 => _ipv4Pattern.hasMatch(value),
    IpVersion.v6 => _ipv6Pattern.hasMatch(value),
    null => _ipv4Pattern.hasMatch(value) || _ipv6Pattern.hasMatch(value),
  };
}

bool isDateTime(String value) => DateTime.tryParse(value) != null;

bool isUri(String value, List<String>? allowedSchemes) {
  final uri = Uri.tryParse(value);
  if (uri == null) return false;
  if (allowedSchemes == null) return true;
  return allowedSchemes.contains(uri.scheme);
}

bool isUrl(String value, List<String>? allowedSchemes) {
  if (_whitespace.hasMatch(value)) return false;
  final uri = Uri.tryParse(value);
  if (uri == null || uri.scheme.isEmpty || uri.host.isEmpty) return false;
  if (allowedSchemes == null) return true;
  final scheme = uri.scheme.toLowerCase();
  return allowedSchemes.any((allowed) => allowed.toLowerCase() == scheme);
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
