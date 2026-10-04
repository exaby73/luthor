import 'package:luthor/luthor.dart';
import 'package:source_gen/source_gen.dart';

enum FieldKind {
  string('String'),
  int('int'),
  double('double'),
  number('num'),
  boolean('bool'),
  list('List'),
  map('Map'),
  schema('nested model'),
  enumeration('enum'),
  any('untyped'),
  file('file'),
  nullValue('Null');

  const FieldKind(this.description);

  final String description;
}

enum RuleEffect { entry, modifier, refinement }

final class AnnotationRule {
  const AnnotationRule(
    this.annotation,
    this.method, {
    required this.appliesTo,
    this.positional = const [],
    this.named = const [],
    this.effect = RuleEffect.modifier,
    this.integralFor = const {},
    this.regExpFlags = const {},
  });

  final Type annotation;
  final String method;
  final Set<FieldKind> appliesTo;
  final List<String> positional;
  final List<String> named;
  final RuleEffect effect;

  /// The field kinds on which the first positional value must be an `int`.
  final Set<FieldKind> integralFor;

  /// The `RegExp` flags of a pattern rule, with their default values.
  final Map<String, bool> regExpFlags;

  TypeChecker get checker =>
      TypeChecker.typeNamed(annotation, inPackage: 'luthor');

  String get annotationName => '$annotation';
}

const _string = {FieldKind.string};
const _sizable = {
  FieldKind.string,
  FieldKind.int,
  FieldKind.double,
  FieldKind.number,
};
const _integral = {FieldKind.string, FieldKind.int};
const _refinable = {
  FieldKind.string,
  FieldKind.int,
  FieldKind.double,
  FieldKind.number,
  FieldKind.boolean,
  FieldKind.list,
  FieldKind.map,
  FieldKind.schema,
  FieldKind.enumeration,
  FieldKind.any,
  FieldKind.file,
};
const _every = {..._refinable, FieldKind.nullValue};

const annotationRules = <AnnotationRule>[
  AnnotationRule(
    IsFile,
    'file',
    appliesTo: _every,
    named: ['accept'],
    effect: RuleEffect.entry,
  ),
  AnnotationRule(IsDateTime, 'dateTime', appliesTo: _string),
  AnnotationRule(IsEmail, 'email', appliesTo: _string),
  AnnotationRule(
    HasLength,
    'length',
    appliesTo: _string,
    positional: ['length'],
  ),
  AnnotationRule(
    HasMin,
    'min',
    appliesTo: _sizable,
    positional: ['min'],
    integralFor: _integral,
  ),
  AnnotationRule(
    HasMax,
    'max',
    appliesTo: _sizable,
    positional: ['max'],
    integralFor: _integral,
  ),
  AnnotationRule(IsUri, 'uri', appliesTo: _string, named: ['allowedSchemes']),
  AnnotationRule(IsUrl, 'url', appliesTo: _string, named: ['allowedSchemes']),
  AnnotationRule(
    MatchRegex,
    'regex',
    appliesTo: _string,
    positional: ['pattern'],
    regExpFlags: {
      'caseSensitive': true,
      'multiLine': false,
      'unicode': false,
      'dotAll': false,
    },
  ),
  AnnotationRule(
    StartsWith,
    'startsWith',
    appliesTo: _string,
    positional: ['string'],
  ),
  AnnotationRule(
    EndsWith,
    'endsWith',
    appliesTo: _string,
    positional: ['string'],
  ),
  AnnotationRule(
    Contains,
    'contains',
    appliesTo: _string,
    positional: ['string'],
  ),
  AnnotationRule(IsIp, 'ip', appliesTo: _string, named: ['version']),
  AnnotationRule(IsUuid, 'uuid', appliesTo: _string),
  AnnotationRule(IsCuid, 'cuid', appliesTo: _string),
  AnnotationRule(IsCuid2, 'cuid2', appliesTo: _string),
  AnnotationRule(IsEmoji, 'emoji', appliesTo: _string),
  AnnotationRule(
    WithCustomValidator,
    'custom',
    appliesTo: _refinable,
    positional: ['customValidator'],
    effect: RuleEffect.refinement,
  ),
  AnnotationRule(
    WithSchemaCustomValidator,
    'customWithSchema',
    appliesTo: _refinable,
    positional: ['customValidator'],
    effect: RuleEffect.refinement,
  ),
];
