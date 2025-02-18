import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';
import 'package:source_gen/source_gen.dart';

const luthorChecker = TypeChecker.fromRuntime(Luthor);
const jsonKeyChecker = TypeChecker.fromRuntime(JsonKey);
const defaultChecker = TypeChecker.fromRuntime(Default);
const dartMappableChecker = TypeChecker.fromRuntime(MappableClass);

const isEmailChecker = TypeChecker.fromRuntime(IsEmail);
const isDateTimeChecker = TypeChecker.fromRuntime(IsDateTime);
const hasLengthChecker = TypeChecker.fromRuntime(HasLength);
const hasMaxChecker = TypeChecker.fromRuntime(HasMax);
const hasMinChecker = TypeChecker.fromRuntime(HasMin);
const isUriChecker = TypeChecker.fromRuntime(IsUri);
const isUrlChecker = TypeChecker.fromRuntime(IsUrl);
const matchRegexChecker = TypeChecker.fromRuntime(MatchRegex);
const startsWithChecker = TypeChecker.fromRuntime(StartsWith);
const endsWithChecker = TypeChecker.fromRuntime(EndsWith);
const containsChecker = TypeChecker.fromRuntime(Contains);
const isIpChecker = TypeChecker.fromRuntime(IsIp);

const hasMaxDoubleChecker = TypeChecker.fromRuntime(HasMaxDouble);
const hasMinDoubleChecker = TypeChecker.fromRuntime(HasMinDouble);
const hasMaxNumberChecker = TypeChecker.fromRuntime(HasMaxNumber);
const hasMinNumberChecker = TypeChecker.fromRuntime(HasMinNumber);

const customValidatorChecker = TypeChecker.fromRuntime(WithCustomValidator);
