import 'dart:convert';

String dartStringLiteral(String value) {
  return jsonEncode(value).replaceAll(r'$', r'\$');
}

String dartRawStringLiteral(String value) {
  if (value.contains("'") || value.contains('\n') || value.contains('\r')) {
    return dartStringLiteral(value);
  }
  return "r'$value'";
}

String jsonLiteral(Object? value) {
  return switch (value) {
    final String string => dartStringLiteral(string),
    final double number => dartDoubleLiteral(number),
    _ => '$value',
  };
}

String dartDoubleLiteral(double value) {
  if (value.isNaN) return 'double.nan';
  if (value == double.infinity) return 'double.infinity';
  if (value == double.negativeInfinity) return 'double.negativeInfinity';
  return value.toString();
}
