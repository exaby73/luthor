class WithCustomValidator {
  final String? message;
  final String? Function()? messageFn;
  final bool Function(Object? value) customValidator;

  const WithCustomValidator(
    this.customValidator, {
    this.message,
    this.messageFn,
  });
}
