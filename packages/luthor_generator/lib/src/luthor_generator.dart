import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:luthor_generator/src/checkers.dart';
import 'package:luthor_generator/src/library_emitter.dart';
import 'package:luthor_generator/src/library_plan.dart';
import 'package:luthor_generator/src/model.dart';
import 'package:source_gen/source_gen.dart';

final class LuthorGenerator extends Generator {
  @override
  String? generate(LibraryReader library, BuildStep buildStep) {
    final annotated = library.annotatedWith(luthorChecker).toList();
    if (annotated.isEmpty) return null;

    final plan = LibraryPlan(library.element);
    final emitter = LibraryEmitter(plan);
    for (final AnnotatedElement(:element) in annotated) {
      emitter.writeModel(plan.models.read(_modelClass(element)));
    }
    return emitter.emit();
  }

  ClassElement _modelClass(Element element) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Luthor can only be applied to classes.',
        element: element,
      );
    }
    if (!ModelReader.isSerializable(element)) {
      throw InvalidGenerationSourceError(
        'Luthor can only be applied to classes with a fromJson constructor '
        'or static method, or a @MappableClass annotation.',
        element: element,
      );
    }
    return element;
  }
}
