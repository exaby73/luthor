import 'package:luthor_generator/src/runtime_api.dart' as runtime;

final class ValidatorExpr {
  const ValidatorExpr(
    this.base, {
    this.modifiers = const [],
    this.required = false,
  });

  final ValidatorBase base;
  final List<String> modifiers;
  final bool required;

  ValidatorExpr copyWith({List<String>? modifiers, bool? required}) {
    return ValidatorExpr(
      base,
      modifiers: modifiers ?? this.modifiers,
      required: required ?? this.required,
    );
  }

  String emit() => runtime.validator(this);
}

sealed class ValidatorBase {
  const ValidatorBase();
}

final class TypeEntry extends ValidatorBase {
  const TypeEntry(this.type, [this.arguments = const []]);

  final runtime.EntryType type;
  final List<String> arguments;
}

final class ListOf extends ValidatorBase {
  const ListOf(this.element);

  final ValidatorExpr element;
}

final class MapOf extends ValidatorBase {
  const MapOf(this.key, this.value);

  final ValidatorExpr key;
  final ValidatorExpr value;
}

final class SchemaRef extends ValidatorBase {
  const SchemaRef(this.reference);

  final String reference;
}
