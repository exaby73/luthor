class ValidationResult<T> {
  final bool isValid;
  final String? message;
  final T? data;

  ValidationResult({required this.isValid, this.message, this.data});
}
