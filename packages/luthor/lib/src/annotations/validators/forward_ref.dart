const _deprecation =
    'Has no effect: luthor_generator wraps every nested schema reference in '
    'forwardRef(). Remove the annotation.';

/// Formerly marked a field whose schema must be referenced with
/// `forwardRef()`.
///
/// `luthor_generator` now wraps every nested schema reference in
/// `forwardRef()`, so recursive and mutually recursive models work without
/// this annotation. The generator still accepts it for compatibility, but it
/// has no effect, and the generated code is the same with or without it.
@Deprecated(_deprecation)
final class LuthorForwardRef {
  /// Creates the annotation.
  @Deprecated(_deprecation)
  const LuthorForwardRef();
}

/// A [LuthorForwardRef] annotation, which has no effect.
@Deprecated(_deprecation)
const luthorForwardRef = LuthorForwardRef();
