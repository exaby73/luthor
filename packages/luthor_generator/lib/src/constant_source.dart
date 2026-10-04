import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:luthor_generator/src/dart_source.dart';
import 'package:luthor_generator/src/references.dart';
import 'package:source_gen/source_gen.dart';

final class ConstantSource {
  ConstantSource(this.references);

  final LibraryReferences references;

  String of(DartObject value, {required Element usedBy}) {
    final type = value.type;
    if (value.isNull) return 'null';
    if (type != null && type.isDartCoreBool) return '${value.toBoolValue()}';
    if (type != null && type.isDartCoreInt) return '${value.toIntValue()}';
    if (type != null && type.isDartCoreDouble) {
      return dartDoubleLiteral(value.toDoubleValue()!);
    }
    if (type != null && type.isDartCoreString) {
      return dartStringLiteral(value.toStringValue()!);
    }
    if (value.toListValue() case final items?) {
      return '[${items.map((item) => of(item, usedBy: usedBy)).join(', ')}]';
    }
    if (value.toFunctionValue() case final function?) {
      return _functionReference(function, usedBy);
    }
    if (value.variable case final FieldElement constant
        when constant.isEnumConstant) {
      final owner = references.nameOf(constant.enclosingElement);
      if (owner != null) return '$owner.${constant.name}';
    }
    throw InvalidGenerationSourceError(
      'Luthor cannot write the annotation value `$value` used on '
      '`${usedBy.displayName}` into generated code.',
      element: usedBy,
    );
  }

  String _functionReference(ExecutableElement function, Element usedBy) {
    final reference = references.functionReference(function);
    if (reference != null) return reference;
    throw InvalidGenerationSourceError(
      'The function `${function.displayName}` used on `${usedBy.displayName}` '
      'is not visible from ${references.library.uri}. Make it a public '
      'top-level or static function and import its library there.',
      element: usedBy,
    );
  }
}
