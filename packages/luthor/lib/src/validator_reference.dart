import 'package:luthor/src/validator.dart';

/// A reference to a validator that can be resolved when needed.
/// This allows both [Validator] and [ForwardRef] to be used interchangeably
/// in contexts where a validator is needed.
abstract class ValidatorReference {
  /// Resolves this reference to a concrete [Validator].
  Validator resolve();
}
