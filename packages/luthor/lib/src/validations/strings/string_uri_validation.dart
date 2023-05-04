import 'package:luthor/src/validation.dart';

class StringUriValidation extends Validation {
  final List<String>? allowedSchemes;
  final String? customMessage;

  StringUriValidation({
    this.allowedSchemes,
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;

    final uri = Uri.tryParse(value);
    if (uri != null && allowedSchemes != null) {
      return allowedSchemes!.contains(uri.scheme);
    }
    return uri != null;
  }

  @override
  String get message {
    final m = '${fieldName ?? 'value'} must be a valid uri';
    if (allowedSchemes?.isNotEmpty == true) {
      final isPlural = allowedSchemes!.length != 1;
      return '$m. Allowed ${isPlural ? 'schemes' : 'scheme'} '
          '${isPlural ? 'are' : 'is'} ${allowedSchemes!.join(', ')}';
    }
    return customMessage ?? m;
  }

  @override
  Map<String, List<String>>? get errors => null;
}
