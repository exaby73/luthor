import 'package:build/build.dart';
import 'package:luthor/luthor.dart';
import 'package:luthor_generator/src/luthor_generator.dart';
import 'package:source_gen/source_gen.dart';

const _unknownKeysOption = 'unknown_keys';

/// Creates the luthor builder.
///
/// The `unknown_keys` option sets how generated schemas handle unknown keys
/// when a model's `@Luthor(unknownKeys: ...)` does not: `strip`,
/// `passthrough` or `strict`. Throws an [ArgumentError] for any other value
/// or option.
Builder luthorBuilder(BuilderOptions options) {
  return SharedPartBuilder([
    LuthorGenerator(unknownKeys: _readUnknownKeys(options.config)),
  ], 'luthor');
}

UnknownKeys? _readUnknownKeys(Map<String, Object?> config) {
  for (final key in config.keys) {
    if (key != _unknownKeysOption) {
      throw ArgumentError.value(
        key,
        'options',
        'is not a luthor option. The only option is $_unknownKeysOption',
      );
    }
  }
  final value = config[_unknownKeysOption];
  if (value == null) return null;
  for (final mode in UnknownKeys.values) {
    if (mode.name == value) return mode;
  }
  throw ArgumentError.value(
    value,
    _unknownKeysOption,
    'must be one of ${UnknownKeys.values.map((mode) => mode.name).join(', ')}',
  );
}
