import 'package:luthor/src/validation.dart';

class StringUrlValidation extends Validation {
  final List<String>? allowedSchemes;
  final String? customMessage;

  StringUrlValidation({
    this.allowedSchemes,
    String? message,
  }) : customMessage = message;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);

    if (value == null) return true;
    if (value is! String) return false;

    if (RegExp(r'\s').hasMatch(value)) return false;

    final uri = Uri.tryParse(value);
    if (uri == null) return false;

    if (uri.scheme.isEmpty || uri.host.isEmpty) return false;

    final scheme = uri.scheme.toLowerCase();
    if (allowedSchemes != null) {
      return allowedSchemes!.any((s) => s.toLowerCase() == scheme);
    }
    return true;
  }

  @override
  String get message {
    final m = '${fieldName ?? 'value'} must be a valid URL';
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
