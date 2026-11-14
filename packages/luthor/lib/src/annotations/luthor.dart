import 'package:luthor/src/unknown_keys.dart';

/// Marks a class as a model that `luthor_generator` builds a schema for.
///
/// The class needs a `fromJson` factory or a `@MappableClass` annotation.
final class Luthor {
  /// Creates the annotation.
  const Luthor({this.unknownKeys});

  /// How the generated schema handles keys the model does not declare, such
  /// as `@Luthor(unknownKeys: .strict)`.
  ///
  /// When `null`, the generator uses the `unknown_keys` builder option. Without
  /// that option, it strips unknown keys, or keeps them when the serializer
  /// reads keys that are not fields, such as with `@JsonKey(readValue: ...)`.
  final UnknownKeys? unknownKeys;
}

/// A [Luthor] annotation.
const luthor = Luthor();
