import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:luthor_generator/src/checkers.dart';
import 'package:luthor_generator/src/field_naming.dart';
import 'package:source_gen/source_gen.dart';

List<Object?> serializedEnumValues(EnumElement element) {
  final mappableEnum = mappableEnumChecker.firstAnnotationOf(element);
  if (mappableEnum != null) return _mappableValues(element, mappableEnum);
  return _jsonValues(element);
}

List<Object?> _jsonValues(EnumElement element) {
  final jsonEnum = ConstantReader(jsonEnumChecker.firstAnnotationOf(element));
  final valueField = jsonEnum.peek('valueField')?.stringValue;
  final naming = jsonSerializableNaming(
    jsonEnum.peek('fieldRename')?.objectValue,
  );
  return [
    for (final (index, constant) in element.constants.indexed)
      if (jsonValueChecker.firstAnnotationOf(constant) case final jsonValue?)
        ConstantReader(jsonValue).read('value').literalValue
      else if (valueField == null)
        naming(constant.name!)
      else if (ConstantReader(constant.computeConstantValue()).peek(valueField)
          case final value?)
        value.literalValue
      else if (valueField == 'index')
        index
      else
        throw InvalidGenerationSourceError(
          '`${element.name}` sets JsonEnum.valueField to `$valueField`, but '
          'that is not a field of `${constant.name}`.',
          element: constant,
        ),
  ];
}

List<Object?> _mappableValues(EnumElement element, DartObject mappableEnum) {
  final reader = ConstantReader(mappableEnum);
  final indexed = reader.peek('mode')?.objectValue.variable?.name == 'indexed';
  final naming = mappableNaming(reader.peek('caseStyle')?.objectValue);
  return [
    for (final (index, constant) in element.constants.indexed)
      if (mappableValueChecker.firstAnnotationOf(constant) case final value?)
        ConstantReader(value).read('value').literalValue
      else if (indexed)
        index
      else
        naming(constant.name!),
  ];
}
