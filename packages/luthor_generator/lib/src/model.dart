import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:luthor_generator/src/checkers.dart';
import 'package:source_gen/source_gen.dart';

enum ModelSerializer { json, mappable }

final class Model {
  const Model({
    required this.element,
    required this.constructor,
    required this.fields,
    required this.serializer,
  });

  final ClassElement element;
  final ConstructorElement constructor;
  final List<ModelField> fields;
  final ModelSerializer serializer;

  String get name => element.name!;
}

final class ModelField {
  const ModelField({
    required this.parameter,
    required this.key,
    required this.annotations,
    required this.hasDefault,
  });

  final FormalParameterElement parameter;
  final String key;
  final List<DartObject> annotations;
  final bool hasDefault;

  String get name => parameter.name!;

  DartType get type => parameter.type;

  DartObject? annotationOf(TypeChecker checker) {
    return firstAnnotation(annotations, checker);
  }
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
  final _models = <ClassElement, Model>{};

  static bool isSerializable(ClassElement element) {
    return hasFromJson(element) || isMappable(element);
  }

  static bool isMappable(ClassElement element) {
    return mappableClassChecker.hasAnnotationOf(element);
  }

  static bool hasFromJson(ClassElement element) {
    return element.constructors.any(_isFromJson);
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
    return Model(
      element: element,
      constructor: constructor,
      fields: [
        for (final parameter in constructor.formalParameters) _field(parameter),
      ],
      serializer: isMappable(element)
          ? ModelSerializer.mappable
          : ModelSerializer.json,
    );
  }

  ModelField _field(FormalParameterElement parameter) {
    final annotations = [
      for (final annotation in parameter.metadata.annotations)
        ?annotation.computeConstantValue(),
    ];
    final jsonKey = ConstantReader(
      firstAnnotation(annotations, jsonKeyChecker),
    );
    return ModelField(
      parameter: parameter,
      key: jsonKey.peek('name')?.stringValue ?? parameter.name!,
      annotations: annotations,
      hasDefault: firstAnnotation(annotations, defaultChecker) != null,
    );
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
