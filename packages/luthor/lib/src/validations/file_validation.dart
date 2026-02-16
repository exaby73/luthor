import 'package:luthor/src/validation.dart';

class FileValidation extends Validation {
  String? customMessage;
  String? Function()? customMessageFn;

  FileValidation({String? message, String? Function()? messageFn})
    : customMessage = message,
      customMessageFn = messageFn;

  @override
  bool call(String? fieldName, Object? value) {
    super.call(fieldName, value);
    if (value == null) return false;

    final typeName = value.runtimeType.toString().toLowerCase();
    return typeName.contains('file') ||
        typeName.contains('multipart') ||
        typeName.contains('xfile') ||
        typeName.contains('stream') ||
        typeName.contains('bytes') ||
        typeName.contains('uint8list') ||
        typeName.contains('bytedata');
  }

  @override
  String get message =>
      customMessage ??
      customMessageFn?.call() ??
      '${fieldName ?? 'value'} must be a file';

  @override
  Map<String, List<String>>? get errors => null;
}
