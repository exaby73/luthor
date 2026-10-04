import 'package:luthor/luthor.dart';
import 'package:source_gen/source_gen.dart';

const luthorChecker = TypeChecker.typeNamed(Luthor, inPackage: 'luthor');

const jsonKeyChecker = TypeChecker.typeNamedLiterally(
  'JsonKey',
  inPackage: 'json_annotation',
);
const jsonSerializableChecker = TypeChecker.typeNamedLiterally(
  'JsonSerializable',
  inPackage: 'json_annotation',
);
const jsonConverterChecker = TypeChecker.typeNamedLiterally(
  'JsonConverter',
  inPackage: 'json_annotation',
);
const jsonEnumChecker = TypeChecker.typeNamedLiterally(
  'JsonEnum',
  inPackage: 'json_annotation',
);
const jsonValueChecker = TypeChecker.typeNamedLiterally(
  'JsonValue',
  inPackage: 'json_annotation',
);

const freezedChecker = TypeChecker.typeNamedLiterally(
  'Freezed',
  inPackage: 'freezed_annotation',
);
const defaultChecker = TypeChecker.typeNamedLiterally(
  'Default',
  inPackage: 'freezed_annotation',
);

const mappableClassChecker = TypeChecker.typeNamedLiterally(
  'MappableClass',
  inPackage: 'dart_mappable',
);
const mappableFieldChecker = TypeChecker.typeNamedLiterally(
  'MappableField',
  inPackage: 'dart_mappable',
);
const mappableConstructorChecker = TypeChecker.typeNamedLiterally(
  'MappableConstructor',
  inPackage: 'dart_mappable',
);
const mappableEnumChecker = TypeChecker.typeNamedLiterally(
  'MappableEnum',
  inPackage: 'dart_mappable',
);
const mappableValueChecker = TypeChecker.typeNamedLiterally(
  'MappableValue',
  inPackage: 'dart_mappable',
);

const dateTimeChecker = TypeChecker.typeNamedLiterally(
  'DateTime',
  inPackage: 'core',
  inSdk: true,
);
const bigIntChecker = TypeChecker.typeNamedLiterally(
  'BigInt',
  inPackage: 'core',
  inSdk: true,
);
const uriChecker = TypeChecker.typeNamedLiterally(
  'Uri',
  inPackage: 'core',
  inSdk: true,
);
const fileChecker = TypeChecker.any([
  TypeChecker.typeNamedLiterally('File', inPackage: 'io', inSdk: true),
  TypeChecker.typeNamedLiterally('XFile', inPackage: 'cross_file'),
]);
