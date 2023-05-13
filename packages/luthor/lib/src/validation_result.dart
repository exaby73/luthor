/// Validation result for any single validation.
sealed class SingleValidationResult<Data> {
  Data get data;

  bool get isValid {
    return switch (this) {
      SingleValidationSuccess(data: _) => true,
      SingleValidationError(data: _, errors: _) => false,
    };
  }
}

class SingleValidationSuccess<T> extends SingleValidationResult<T> {
  @override
  final T data;

  SingleValidationSuccess({required this.data});
}

class SingleValidationError<T> extends SingleValidationResult<T> {
  @override
  final T data;
  final List<String> errors;

  SingleValidationError({required this.data, required this.errors});
}

/// Validation result for a schema validation.
sealed class SchemaValidationResult {
  Map<String, Object?> get data;

  bool get isValid {
    return switch (this) {
      SchemaValidationSuccess(data: _) => true,
      SchemaValidationError(data: _, errors: _) => false,
    };
  }
}

class SchemaValidationSuccess extends SchemaValidationResult {
  @override
  final Map<String, Object?> data;

  SchemaValidationSuccess({required this.data});
}

class SchemaValidationError extends SchemaValidationResult {
  @override
  final Map<String, Object?> data;
  final Map<String, dynamic> errors;

  SchemaValidationError({required this.data, required this.errors});
}
