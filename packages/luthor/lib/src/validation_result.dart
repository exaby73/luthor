/// Validation result for any single validation.
sealed class SingleValidationResult<Data> {
  Data get data;

  bool get isValid {
    return switch (this) {
      SingleValidationSuccess(data: _) => true,
      SingleValidationError(data: _, errors: _) => false,
    };
  }

  @override
  String toString() {
    return switch (this) {
      SingleValidationSuccess<Data>(data: final data) =>
        'SingleValidationSuccess(data: $data)',
      SingleValidationError<Data>(data: final data, errors: final errors) =>
        'SingleValidationError(data: $data, errors: $errors)',
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
sealed class SchemaValidationResult<T> {
  T? get data;

  bool get isValid {
    return switch (this) {
      SchemaValidationSuccess(data: _) => true,
      SchemaValidationError(data: _, errors: _) => false,
    };
  }

  @override
  String toString() {
    return switch (this) {
      SchemaValidationSuccess<T>(data: final data) =>
        'SchemaValidationSuccess(data: $data)',
      SchemaValidationError<T>(data: final data, errors: final errors) =>
        'SchemaValidationError(data: $data, errors: $errors)',
    };
  }
}

class SchemaValidationSuccess<T> extends SchemaValidationResult<T> {
  @override
  final T data;

  SchemaValidationSuccess({required this.data});
}

class SchemaValidationError<T> extends SchemaValidationResult<T> {
  @override
  final T? data;
  final Map<String, dynamic> errors;

  SchemaValidationError({this.data, required this.errors});

  String? getError(String key) {
    final nestedKeys = key.split('.');

    dynamic error = errors;
    for (final nestedKey in nestedKeys) {
      if (error is Map) {
        error = error[nestedKey];
      }
    }

    if (error is! List?) {
      throw StateError('Invalid key: $key');
    }

    return error?.firstOrNull as String?;
  }
}
