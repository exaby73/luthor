import 'package:analyzer/dart/element/element.dart';
import 'package:luthor_generator/src/checkers.dart';
import 'package:luthor_generator/src/constant_source.dart';
import 'package:luthor_generator/src/model.dart';
import 'package:luthor_generator/src/references.dart';

final class LibraryPlan {
  LibraryPlan(this.library) : references = LibraryReferences(library);

  final LibraryElement library;
  final LibraryReferences references;
  final models = ModelReader();
  late final constants = ConstantSource(references);

  final _autoSchemas = <ClassElement, String>{};

  Map<ClassElement, String> get autoSchemas => Map.unmodifiable(_autoSchemas);

  static String publicSchemaName(String modelName) => '\$${modelName}Schema';

  String schemaReference(ClassElement target) {
    if (luthorChecker.hasAnnotationOf(target)) {
      final reference = references.publicSchemaReference(
        target,
        publicSchemaName(target.name!),
      );
      if (reference != null) return reference;
    }
    return _autoSchemas[target] ??= _privateSchemaName(target.name!);
  }

  String _privateSchemaName(String className) {
    final taken = _autoSchemas.values.toSet();
    var candidate = '_\$${className}Schema';
    for (var suffix = 2; taken.contains(candidate); suffix++) {
      candidate = '_\$$className${suffix}Schema';
    }
    return candidate;
  }
}
