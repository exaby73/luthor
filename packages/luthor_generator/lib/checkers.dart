import 'package:luthor_annotation/luthor_annotation.dart';
import 'package:source_gen/source_gen.dart';

const isEmailChecker = TypeChecker.fromRuntime(IsEmail);
const isDateTimeChecker = TypeChecker.fromRuntime(IsDateTime);
const hasLengthChecker = TypeChecker.fromRuntime(HasLength);
const hasMaxChecker = TypeChecker.fromRuntime(HasMax);
const hasMinChecker = TypeChecker.fromRuntime(HasMin);
const isUriChecker = TypeChecker.fromRuntime(IsUri);
