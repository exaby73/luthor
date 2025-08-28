class WithSchemaCustomValidator {
  final String? message;
  final String? Function()? messageFn;
  final bool Function(Object? value, Map<String, Object?> data) customValidator;

  const WithSchemaCustomValidator(this.customValidator, {this.message, this.messageFn});
}
