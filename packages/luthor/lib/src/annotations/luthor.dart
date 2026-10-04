/// Marks a class as a model that `luthor_generator` builds a schema for.
///
/// The class needs a `fromJson` factory or a `@MappableClass` annotation.
final class Luthor {
  /// Creates the annotation.
  const Luthor();
}

/// A [Luthor] annotation.
const luthor = Luthor();
