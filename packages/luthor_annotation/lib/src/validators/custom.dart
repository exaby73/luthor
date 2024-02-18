class WithCustomValidator {
  final String? message;
  final bool Function(Object? value) customValidator;

  const WithCustomValidator(this.customValidator, {this.message});
}
