import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:luthor_generator/src/annotation_rules.dart';
import 'package:luthor_generator/src/checkers.dart';
import 'package:luthor_generator/src/library_plan.dart';
import 'package:luthor_generator/src/model.dart';
import 'package:luthor_generator/src/runtime_api.dart' as runtime;
import 'package:luthor_generator/src/validator_expr.dart';
import 'package:source_gen/source_gen.dart';

final class FieldValidators {
  FieldValidators(this.plan);

  final LibraryPlan plan;

  ValidatorExpr forField(ModelField field, Model owner) {
    final applied = [
      for (final annotation in field.annotations)
        if (_ruleFor(annotation) case final rule?) (rule, annotation),
    ];
    final explicitDateTime = applied.any(
      (entry) => entry.$1.method == 'dateTime',
    );
    var (expr, kind) = _forType(
      field.type,
      _FieldContext(field, owner),
      implicitDateTime: !explicitDateTime,
    );

    final modifiers = <String>[];
    final refinements = <String>[];
    for (final (rule, annotation) in applied) {
      if (!rule.appliesTo.contains(kind)) continue;
      final call = _call(rule, annotation, field);
      switch (rule.effect) {
        case RuleEffect.entry:
          expr = ValidatorExpr(
            TypeEntry(
              runtime.EntryType.file,
              _arguments(rule, annotation, field),
            ),
          );
          kind = FieldKind.file;
        case RuleEffect.modifier:
          modifiers.add(call);
        case RuleEffect.refinement:
          refinements.add(call);
      }
    }

    return expr.copyWith(
      modifiers: [...expr.modifiers, ...modifiers, ...refinements],
      required: _isRequired(field.type) && !field.hasDefault,
    );
  }

  (ValidatorExpr, FieldKind) _forType(
    DartType type,
    _FieldContext context, {
    bool implicitDateTime = true,
  }) {
    final required = _isRequired(type);

    ValidatorExpr entry(
      runtime.EntryType entryType, [
      List<String> modifiers = const [],
    ]) {
      return ValidatorExpr(
        TypeEntry(entryType),
        modifiers: modifiers,
        required: required,
      );
    }

    final scalar = switch (type) {
      DynamicType() => (runtime.EntryType.any, FieldKind.any),
      _ when type.isDartCoreBool => (
        runtime.EntryType.boolean,
        FieldKind.boolean,
      ),
      _ when type.isDartCoreInt => (runtime.EntryType.int, FieldKind.int),
      _ when type.isDartCoreDouble => (
        runtime.EntryType.double,
        FieldKind.double,
      ),
      _ when type.isDartCoreNum => (runtime.EntryType.number, FieldKind.number),
      _ when type.isDartCoreString => (
        runtime.EntryType.string,
        FieldKind.string,
      ),
      _ when type.isDartCoreNull => (
        runtime.EntryType.nullValue,
        FieldKind.nullValue,
      ),
      _ => null,
    };
    if (scalar case (final entryType, final kind)) {
      return (entry(entryType), kind);
    }
    if (dateTimeChecker.isExactlyType(type)) {
      return (
        entry(runtime.EntryType.string, [
          if (implicitDateTime) runtime.dateTime(),
        ]),
        FieldKind.string,
      );
    }
    if (fileChecker.isExactlyType(type)) {
      return (entry(runtime.EntryType.file), FieldKind.file);
    }
    if (type is InterfaceType && type.isDartCoreList) {
      final (element, _) = _forType(type.typeArguments.single, context);
      return (
        ValidatorExpr(ListOf(element), required: required),
        FieldKind.list,
      );
    }
    if (type is InterfaceType && type.isDartCoreMap) {
      final (key, _) = _forType(type.typeArguments[0], context);
      final (value, _) = _forType(type.typeArguments[1], context);
      return (
        ValidatorExpr(MapOf(key, value), required: required),
        FieldKind.map,
      );
    }
    final element = type.element;
    if (element is ClassElement &&
        (luthorChecker.hasAnnotationOf(element) ||
            ModelReader.isSerializable(element))) {
      return (
        ValidatorExpr(
          SchemaRef(plan.schemaReference(element)),
          required: required,
        ),
        FieldKind.schema,
      );
    }
    throw InvalidGenerationSourceError(
      'Type ${type.getDisplayString()} does not have @luthor annotation and is '
      'not compatible for auto-generation. To make it compatible, ensure it '
      'has A fromJson factory constructor OR @MappableClass annotation.',
      element: context.field.parameter,
    );
  }

  bool _isRequired(DartType type) {
    return type is! DynamicType &&
        !type.isDartCoreNull &&
        type.nullabilitySuffix != NullabilitySuffix.question;
  }

  AnnotationRule? _ruleFor(DartObject annotation) {
    final type = annotation.type;
    if (type == null) return null;
    for (final rule in annotationRules) {
      if (rule.checker.isExactlyType(type)) return rule;
    }
    return null;
  }

  String _call(AnnotationRule rule, DartObject annotation, ModelField field) {
    return runtime.modifier(rule.method, _arguments(rule, annotation, field));
  }

  List<String> _arguments(
    AnnotationRule rule,
    DartObject annotation,
    ModelField field,
  ) {
    final reader = ConstantReader(annotation);
    String source(DartObject value) {
      return plan.constants.of(value, usedBy: field.parameter);
    }

    return [
      for (final name in rule.positional) source(reader.read(name).objectValue),
      for (final name in [...rule.named, 'message', 'messageFn'])
        if (reader.peek(name) case final value?)
          '$name: ${source(value.objectValue)}',
    ];
  }
}

final class _FieldContext {
  const _FieldContext(this.field, this.owner);

  final ModelField field;
  final Model owner;
}
