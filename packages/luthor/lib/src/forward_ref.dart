import 'package:luthor/src/validator.dart';
import 'package:luthor/src/validator_reference.dart';

/// A forward reference to a validator that will be resolved lazily.
/// This is useful for self-referential schemas where a validator
/// references itself during construction.
class _ForwardRef implements ValidatorReference {
  final Validator Function() _resolver;

  _ForwardRef(this._resolver);

  /// Resolves the forward reference to the actual validator.
  @override
  Validator resolve() => _resolver();
}

/// Creates a forward reference to a validator.
/// Use this when you need to reference a validator before it's fully defined.
///
/// Example:
/// ```dart
/// late Validator foobar;
/// foobar = l.schema({
///   'foo': l.string().required(),
///   'bar': l.list(validators: [forwardRef(() => foobar.required())]),
/// });
/// ```
_ForwardRef forwardRef(Validator Function() resolver) {
  return _ForwardRef(resolver);
}
