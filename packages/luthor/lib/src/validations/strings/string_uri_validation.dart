import 'package:luthor/src/validation.dart';

class StringUriValidation extends Validation {
  final List<String>? allowedSchemes;
  final String? customMessage;
  final String? Function()? customMessageFn;

  StringUriValidation({
    this.allowedSchemes,
    String? message,
    String? Function()? messageFn,
  }) : customMessage = message,
       customMessageFn = messageFn;

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
    if (customMessage != null) return customMessage!;
    if (customMessageFn != null) {
      final m = customMessageFn!();
      if (m != null) return m;
    }
    final m = '${fieldName ?? 'value'} must be a valid uri';
    if (allowedSchemes?.isNotEmpty == true) {
      final isPlural = allowedSchemes!.length != 1;
      return '$m. Allowed ${isPlural ? 'schemes' : 'scheme'} '
          '${isPlural ? 'are' : 'is'} ${allowedSchemes!.join(', ')}';
    }
    return m;
  }

  @override
  Map<String, List<String>>? get errors => null;
}
