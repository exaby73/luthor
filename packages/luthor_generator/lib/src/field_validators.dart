import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:luthor_generator/src/annotation_rules.dart';
import 'package:luthor_generator/src/checkers.dart';
import 'package:luthor_generator/src/dart_source.dart';
import 'package:luthor_generator/src/enum_values.dart';
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
      if (!rule.appliesTo.contains(kind)) {
        throw _misplaced(rule, field, owner, kind);
      }
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
      _ when type.isDartCoreObject => (runtime.EntryType.any, FieldKind.any),
      _ when uriChecker.isExactlyType(type) => (
        runtime.EntryType.string,
        FieldKind.string,
      ),
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
    if (type is InterfaceType &&
        (type.isDartCoreList ||
            type.isDartCoreSet ||
            type.isDartCoreIterable)) {
      final (element, _) = _forType(type.typeArguments.single, context);
      return (
        ValidatorExpr(ListOf(element), required: required),
        FieldKind.list,
      );
    }
    if (type.element case final EnumElement enumElement) {
      final values = serializedEnumValues(enumElement);
      final entryType = switch (values) {
        _ when values.every((value) => value is String) =>
          runtime.EntryType.string,
        _ when values.every((value) => value is int) => runtime.EntryType.int,
        _ => runtime.EntryType.any,
      };
      return (
        entry(entryType, [
          runtime.allowedValues(values.map(jsonLiteral).toList()),
        ]),
        FieldKind.enumeration,
      );
    }
    if (type is InterfaceType && type.isDartCoreMap) {
      final key = _forKey(type.typeArguments[0], context);
      final (value, _) = _forType(type.typeArguments[1], context);
      return (
        ValidatorExpr(MapOf(key, value), required: required),
        FieldKind.map,
      );
    }
    final element = type.element;
    if (type is InterfaceType &&
        type.typeArguments.isEmpty &&
        element is ClassElement &&
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
    throw _unsupported(type, context);
  }

  InvalidGenerationSourceError _misplaced(
    AnnotationRule rule,
    ModelField field,
    Model owner,
    FieldKind kind,
  ) {
    final kinds = rule.appliesTo.map((kind) => kind.description).toList();
    final accepted = kinds.length == 1
        ? kinds.single
        : '${kinds.take(kinds.length - 1).join(', ')} or ${kinds.last}';
    final hint = kind == FieldKind.list
        ? ' Validators for list elements are not supported yet '
              '(https://github.com/exaby73/luthor/issues/71).'
        : '';
    return InvalidGenerationSourceError(
      '@${rule.annotationName} cannot be used on field `${field.name}` of '
      '`${owner.name}`: it applies to $accepted fields, but `${field.name}` '
      'is ${field.type.getDisplayString()}.$hint',
      element: field.parameter,
    );
  }

  ValidatorExpr _forKey(DartType type, _FieldContext context) {
    ValidatorExpr string([List<String> modifiers = const []]) {
      return ValidatorExpr(
        const TypeEntry(runtime.EntryType.string),
        modifiers: modifiers,
        required: true,
      );
    }

    if (type is DynamicType ||
        type.isDartCoreString ||
        type.isDartCoreObject ||
        uriChecker.isExactlyType(type)) {
      return string();
    }
    if (type.isDartCoreInt) {
      return string([runtime.parsableKey('int', 'an integer')]);
    }
    if (bigIntChecker.isExactlyType(type)) {
      return string([runtime.parsableKey('BigInt', 'an integer')]);
    }
    if (type.isDartCoreDouble || type.isDartCoreNum) {
      return string([runtime.parsableKey('num', 'a number')]);
    }
    if (dateTimeChecker.isExactlyType(type)) {
      return string([runtime.dateTime()]);
    }
    if (type.element case final EnumElement enumElement) {
      final values = serializedEnumValues(enumElement);
      return string([
        runtime.allowedValues([
          for (final value in values) dartStringLiteral('$value'),
        ]),
      ]);
    }
    throw InvalidGenerationSourceError(
      'Luthor cannot validate field `${context.field.name}` of '
      '`${context.owner.name}`: its map key type '
      '`${type.getDisplayString()}` is not supported. JSON object keys are '
      'strings, so luthor supports String, int, double, num, BigInt, '
      'DateTime, Uri and enum keys.',
      element: context.field.parameter,
    );
  }

  InvalidGenerationSourceError _unsupported(
    DartType type,
    _FieldContext context,
  ) {
    const asAny =
        'Give the field a JsonConverter or @JsonKey(fromJson:) so luthor '
        'validates its raw JSON value as any.';
    final name = type.element?.name;
    final explanation = switch (type) {
      RecordType() => 'is a record. Records are not supported.',
      FunctionType() => 'is a function, which cannot come from JSON.',
      TypeParameterType() =>
        'is a type parameter. Generic models are not '
            'supported yet.',
      InterfaceType(typeArguments: [_, ...]) =>
        'is generic. Generic models are not supported yet. $asAny',
      InterfaceType(:final element) when element.library.isInSdk =>
        'has no luthor validator. $asAny',
      _ =>
        'is not a luthor model. Annotate `$name` with @luthor, give it a '
            'fromJson factory or @MappableClass, or ${asAny[0].toLowerCase()}'
            '${asAny.substring(1)}',
    };
    return InvalidGenerationSourceError(
      'Luthor cannot validate field `${context.field.name}` of '
      '`${context.owner.name}`: its type `${type.getDisplayString()}` '
      '$explanation',
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
