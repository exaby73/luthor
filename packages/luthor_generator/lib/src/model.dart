import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:luthor/luthor.dart';
import 'package:luthor_generator/src/checkers.dart';
import 'package:luthor_generator/src/field_naming.dart';
import 'package:source_gen/source_gen.dart';

enum ModelSerializer { json, mappable }

final class Model {
  const Model({
    required this.element,
    required this.constructor,
    required this.fields,
    required this.serializer,
    required this.hasToJson,
    required this.unknownKeys,
    this.unknownKeysWarning,
  });

  final ClassElement element;
  final ConstructorElement constructor;
  final List<ModelField> fields;
  final ModelSerializer serializer;
  final bool hasToJson;

  /// How the schema handles unknown keys.
  final UnknownKeys unknownKeys;

  /// Why the schema passes unknown keys through instead of using the
  /// `unknown_keys` builder option, logged as a build warning.
  final String? unknownKeysWarning;

  String get name => element.name!;
}

final class ModelField {
  const ModelField({
    required this.element,
    required this.name,
    required this.type,
    required this.key,
    required this.annotations,
    required this.hasDefault,
    required this.usesConverter,
    required this.readsWholeMap,
    required this.acceptsUnknownEnumValues,
  });

  /// The constructor parameter or settable field the value is read into.
  final Element element;
  final String name;
  final DartType type;
  final String key;
  final List<DartObject> annotations;
  final bool hasDefault;
  final bool usesConverter;

  /// Whether the serializer reads the value from the whole map, as
  /// `@JsonKey(readValue: ...)` does, instead of from [key] alone.
  final bool readsWholeMap;

  /// Whether `@JsonKey(unknownEnumValue: ...)` maps a value that is not one
  /// of the enum's serialized values to a fallback instead of throwing.
  final bool acceptsUnknownEnumValues;
}

DartObject? firstAnnotation(
  Iterable<DartObject> annotations,
  TypeChecker checker,
) {
  for (final annotation in annotations) {
    final type = annotation.type;
    if (type != null && checker.isExactlyType(type)) return annotation;
  }
  return null;
}

final class ModelReader {
  ModelReader({this.unknownKeys});

  /// The `unknown_keys` builder option.
  final UnknownKeys? unknownKeys;

  final _models = <ClassElement, Model>{};

  static bool isSerializable(ClassElement element) {
    return hasFromJson(element) || isMappable(element);
  }

  static bool isMappable(ClassElement element) {
    return mappableClassChecker.hasAnnotationOf(element);
  }

  static bool hasFromJson(ClassElement element) {
    return element.constructors.any(_isFromJson) ||
        (element.getMethod('fromJson')?.isStatic ?? false);
  }

  Model read(ClassElement element) => _models[element] ??= _read(element);

  Model _read(ClassElement element) {
    if (element.typeParameters.isNotEmpty) {
      throw InvalidGenerationSourceError(
        '`${element.name}` is generic. Generic models are not supported yet.',
        element: element,
      );
    }
    final variants = element.constructors.where(_isUnionVariant).toList();
    if (variants.length > 1) {
      throw InvalidGenerationSourceError(
        '`${element.name}` is a union of '
        '${variants.map((variant) => variant.displayName).join(', ')}. '
        'Luthor validates one constructor per model, and union dispatch is '
        'not supported yet.',
        element: element,
      );
    }
    final constructor = _selectConstructor(element);
    final context = _ClassContext(element, constructor);
    final parameterNames = {
      for (final parameter in constructor.formalParameters) parameter.name,
    };
    final fields = [
      for (final parameter in constructor.formalParameters)
        ?_parameterField(parameter, context),
      if (!context.mappable && jsonSerializableChecker.hasAnnotationOf(element))
        for (final field in _settableFields(element))
          if (!parameterNames.contains(field.name))
            ?_settableField(field, context),
    ];
    final (mode, warning) = _unknownKeys(
      element,
      _unreadableKeys(element, context, fields),
    );
    return Model(
      element: element,
      constructor: constructor,
      fields: fields,
      serializer: context.mappable
          ? ModelSerializer.mappable
          : ModelSerializer.json,
      hasToJson: context.mappable || _hasToJson(element, context),
      unknownKeys: mode,
      unknownKeysWarning: warning,
    );
  }

  /// What makes the serializer read keys that are not fields, as the element
  /// responsible and a description of it, or `null` if nothing does.
  (Element, String)? _unreadableKeys(
    ClassElement element,
    _ClassContext context,
    List<ModelField> fields,
  ) {
    for (final field in fields) {
      if (field.readsWholeMap) {
        return (
          field.element,
          'field `${field.name}` uses `@JsonKey(readValue: ...)`',
        );
      }
    }
    if (context.privateFieldRead case final field?) {
      return (
        field,
        'private field `${field.name}` uses '
            '`@JsonKey(includeFromJson: true)`',
      );
    }
    if (context.mappable && context.hasMappableHook) {
      return (element, 'it uses `@MappableClass(hook: ...)`');
    }
    return null;
  }

  (UnknownKeys, String?) _unknownKeys(
    ClassElement element,
    (Element, String)? unreadableKeys,
  ) {
    final index = ConstantReader(
      luthorChecker.firstAnnotationOf(element),
    ).peek('unknownKeys')?.objectValue.getField('index')?.toIntValue();
    if (index != null) {
      final annotated = UnknownKeys.values[index];
      if (unreadableKeys != null && annotated != UnknownKeys.passthrough) {
        final (source, reason) = unreadableKeys;
        throw InvalidGenerationSourceError(
          '`${element.name}` sets `unknownKeys: .${annotated.name}`, but '
          '$reason, which '
          'can read keys the schema does not declare. Remove `unknownKeys`, '
          'or set it to `.passthrough`.',
          element: source,
        );
      }
      return (annotated, null);
    }
    if (unreadableKeys == null) return (unknownKeys ?? UnknownKeys.strip, null);
    final option = unknownKeys;
    if (option == null || option == UnknownKeys.passthrough) {
      return (UnknownKeys.passthrough, null);
    }
    final (_, reason) = unreadableKeys;
    final hint = luthorChecker.hasAnnotationOf(element)
        ? ' Annotate it `@Luthor(unknownKeys: .passthrough)` to silence this '
              'warning.'
        : '';
    return (
      UnknownKeys.passthrough,
      '`${element.name}` passes unknown keys through instead of using the '
          '`unknown_keys: ${option.name}` builder option, because $reason.'
          '$hint',
    );
  }

  /// The instance fields that `json_serializable` assigns after calling the
  /// constructor: public fields with a getter and a setter, declared on the
  /// class or inherited.
  Iterable<FieldElement> _settableFields(ClassElement element) sync* {
    final seen = <String>{};
    for (final type in [
      element,
      for (final supertype in element.allSupertypes)
        if (!supertype.isDartCoreObject) supertype.element,
    ]) {
      for (final field in type.fields) {
        final name = field.name;
        if (name == null || field.isStatic || !seen.add(name)) continue;
        if (field.getter == null) continue;
        if (element.lookUpSetter(name: name, library: element.library) ==
            null) {
          continue;
        }
        yield field;
      }
    }
  }

  ModelField? _parameterField(
    FormalParameterElement parameter,
    _ClassContext context,
  ) {
    return _field(
      element: parameter,
      name: parameter.name!,
      type: parameter.type,
      annotations: [
        for (final source in _annotationSources(parameter, context.element))
          for (final annotation in source.metadata.annotations)
            ?annotation.computeConstantValue(),
      ],
      hasDefault: _hasDefaultValue(parameter),
      context: context,
    );
  }

  ModelField? _settableField(FieldElement field, _ClassContext context) {
    final annotations = [
      for (final annotation in field.metadata.annotations)
        ?annotation.computeConstantValue(),
    ];
    if (!field.isPublic) {
      final jsonKey = ConstantReader(
        firstAnnotation(annotations, jsonKeyChecker),
      );
      if (jsonKey.peek('includeFromJson')?.boolValue == true) {
        context.privateFieldRead ??= field;
      }
      return null;
    }
    return _field(
      element: field,
      name: field.name!,
      type: field.type,
      annotations: annotations,
      hasDefault: false,
      context: context,
    );
  }

  bool _hasToJson(ClassElement element, _ClassContext context) {
    final declaresToJson = [
      element,
      ...element.allSupertypes.map((supertype) => supertype.element),
    ].any((type) => type.getMethod('toJson') != null);
    if (declaresToJson) return true;
    final freezed = freezedChecker.firstAnnotationOf(element);
    return freezed != null &&
        hasFromJson(element) &&
        ConstantReader(freezed).peek('toJson')?.boolValue != false &&
        context.createsToJson;
  }

  ModelField? _field({
    required Element element,
    required String name,
    required DartType type,
    required List<DartObject> annotations,
    required bool hasDefault,
    required _ClassContext context,
  }) {
    final jsonKey = ConstantReader(
      firstAnnotation(annotations, jsonKeyChecker),
    );
    if (!context.mappable &&
        (jsonKey.peek('includeFromJson')?.boolValue == false ||
            jsonKey.peek('ignore')?.boolValue == true)) {
      return null;
    }
    final explicitKey = context.mappable
        ? ConstantReader(
            firstAnnotation(annotations, mappableFieldChecker),
          ).peek('key')?.stringValue
        : jsonKey.peek('name')?.stringValue;
    return ModelField(
      element: element,
      name: name,
      type: type,
      key: explicitKey ?? context.naming(name),
      annotations: annotations,
      hasDefault:
          hasDefault ||
          firstAnnotation(annotations, defaultChecker) != null ||
          jsonKey.peek('defaultValue') != null,
      usesConverter:
          jsonKey.peek('fromJson') != null ||
          annotations.any(_isConverter) ||
          context.isConverted(type),
      readsWholeMap: !context.mappable && jsonKey.peek('readValue') != null,
      acceptsUnknownEnumValues:
          !context.mappable && jsonKey.peek('unknownEnumValue') != null,
    );
  }

  bool _hasDefaultValue(FormalParameterElement parameter) {
    if (parameter.hasDefaultValue) return true;
    return switch (parameter) {
      SuperFormalParameterElement(
        superConstructorParameter: final inherited?,
      ) =>
        _hasDefaultValue(inherited),
      _ => false,
    };
  }

  Iterable<Element> _annotationSources(
    FormalParameterElement parameter,
    InterfaceElement owner,
  ) sync* {
    yield parameter;
    if (parameter case SuperFormalParameterElement(
      superConstructorParameter: final inherited?,
    )) {
      if (inherited.enclosingElement?.enclosingElement
          case final InterfaceElement superclass) {
        yield* _annotationSources(inherited, superclass);
      }
      return;
    }
    final field = parameter is FieldFormalParameterElement
        ? parameter.field
        : _lookUpField(owner, parameter.name!);
    if (field != null) yield field;
  }

  FieldElement? _lookUpField(InterfaceElement owner, String name) {
    return owner.getField(name) ??
        owner.allSupertypes
            .map((supertype) => supertype.element.getField(name))
            .nonNulls
            .firstOrNull;
  }

  ConstructorElement _selectConstructor(ClassElement element) {
    final requested = ConstantReader(
      jsonSerializableChecker.firstAnnotationOf(element),
    ).peek('constructor')?.stringValue;
    if (requested != null) {
      for (final constructor in element.constructors) {
        if (_constructorName(constructor) == requested) return constructor;
      }
      throw InvalidGenerationSourceError(
        '`${element.name}` names the constructor `$requested` in '
        '@JsonSerializable, but it has no such constructor.',
        element: element,
      );
    }

    final candidates = element.constructors
        .where(
          (constructor) => constructor.isPublic && !_isFromJson(constructor),
        )
        .toList();
    for (final constructor in candidates) {
      if (mappableConstructorChecker.hasAnnotationOf(constructor)) {
        return constructor;
      }
    }
    for (final constructor in candidates) {
      if (_constructorName(constructor).isEmpty) return constructor;
    }
    for (final constructor in candidates) {
      if (constructor.formalParameters.isNotEmpty) return constructor;
    }
    throw InvalidGenerationSourceError(
      '`${element.name}` has no public constructor that luthor can read '
      'fields from. Add an unnamed constructor, or name one with '
      "@JsonSerializable(constructor: '...').",
      element: element,
    );
  }

  static String _constructorName(ConstructorElement constructor) {
    final name = constructor.name;
    return name == null || name == 'new' ? '' : name;
  }

  static bool _isFromJson(ConstructorElement constructor) {
    return constructor.name == 'fromJson';
  }

  static bool _isUnionVariant(ConstructorElement constructor) {
    return constructor.isFactory &&
        constructor.isPublic &&
        !_isFromJson(constructor) &&
        _isRedirecting(constructor);
  }

  static bool _isRedirecting(ConstructorElement constructor) {
    if (constructor.redirectedConstructor != null) return true;
    final parsed = constructor.session?.getParsedLibraryByElement(
      constructor.library,
    );
    if (parsed is! ParsedLibraryResult) return false;
    final node = parsed.getFragmentDeclaration(constructor.firstFragment)?.node;
    return node is ConstructorDeclaration && node.redirectedConstructor != null;
  }
}

final class _ClassContext {
  _ClassContext(this.element, ConstructorElement constructor)
    : mappable = ModelReader.isMappable(element),
      _jsonSerializable = ConstantReader(
        jsonSerializableChecker.firstAnnotationOf(constructor) ??
            jsonSerializableChecker.firstAnnotationOf(element),
      );

  final ClassElement element;
  final bool mappable;
  final ConstantReader _jsonSerializable;

  /// A private field marked with `@JsonKey(includeFromJson: true)`, which
  /// `json_serializable` reads but a schema key cannot name.
  FieldElement? privateFieldRead;

  /// Whether a `@MappableClass(hook: ...)` may read the whole map before
  /// decoding.
  bool get hasMappableHook =>
      ConstantReader(
        mappableClassChecker.firstAnnotationOf(element),
      ).peek('hook') !=
      null;

  bool get createsToJson =>
      _jsonSerializable.peek('createToJson')?.boolValue != false;

  late final KeyNaming naming = mappable
      ? mappableNaming(
          ConstantReader(
            mappableClassChecker.firstAnnotationOf(element),
          ).peek('caseStyle')?.objectValue,
        )
      : jsonSerializableNaming(
          _jsonSerializable.peek('fieldRename')?.objectValue,
        );

  late final List<DartType> _convertedTypes = [
    for (final converter in [
      ...?_jsonSerializable.peek('converters')?.listValue,
      for (final annotation in element.metadata.annotations)
        if (annotation.computeConstantValue() case final value?
            when _isConverter(value))
          value,
    ])
      ?_convertedType(converter),
  ];

  bool isConverted(DartType type) {
    final typeSystem = element.library.typeSystem;
    final target = typeSystem.promoteToNonNull(type);
    return _convertedTypes.any(
      (converted) => typeSystem.promoteToNonNull(converted) == target,
    );
  }
}

bool _isConverter(DartObject annotation) {
  final type = annotation.type;
  return type is InterfaceType &&
      jsonConverterChecker.isAssignableFromType(type);
}

DartType? _convertedType(DartObject converter) {
  final type = converter.type;
  if (type is! InterfaceType) return null;
  for (final supertype in [type, ...type.allSupertypes]) {
    if (jsonConverterChecker.isExactlyType(supertype)) {
      return supertype.typeArguments.first;
    }
  }
  return null;
}
