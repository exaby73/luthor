import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';
import 'package:source_gen/source_gen.dart';

const luthorChecker = TypeChecker.typeNamed(Luthor);
const jsonKeyChecker = TypeChecker.typeNamed(JsonKey);
const defaultChecker = TypeChecker.typeNamed(Default);
const dartMappableChecker = TypeChecker.typeNamed(MappableClass);

const isEmailChecker = TypeChecker.typeNamed(IsEmail);
const isDateTimeChecker = TypeChecker.typeNamed(IsDateTime);
const hasLengthChecker = TypeChecker.typeNamed(HasLength);
const hasMaxChecker = TypeChecker.typeNamed(HasMax);
const hasMinChecker = TypeChecker.typeNamed(HasMin);
const isUriChecker = TypeChecker.typeNamed(IsUri);
const isUrlChecker = TypeChecker.typeNamed(IsUrl);
const matchRegexChecker = TypeChecker.typeNamed(MatchRegex);
const startsWithChecker = TypeChecker.typeNamed(StartsWith);
const endsWithChecker = TypeChecker.typeNamed(EndsWith);
const containsChecker = TypeChecker.typeNamed(Contains);
const isIpChecker = TypeChecker.typeNamed(IsIp);

const hasMaxDoubleChecker = TypeChecker.typeNamed(HasMaxDouble);
const hasMinDoubleChecker = TypeChecker.typeNamed(HasMinDouble);
const hasMaxNumberChecker = TypeChecker.typeNamed(HasMaxNumber);
const hasMinNumberChecker = TypeChecker.typeNamed(HasMinNumber);

const customValidatorChecker = TypeChecker.typeNamed(WithCustomValidator);
const schemaCustomValidatorChecker = TypeChecker.typeNamed(
  WithSchemaCustomValidator,
);
const luthorForwardRefChecker = TypeChecker.typeNamed(LuthorForwardRef);
