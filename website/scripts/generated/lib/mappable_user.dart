import 'package:dart_mappable/dart_mappable.dart';
import 'package:luthor/luthor.dart';

part 'mappable_user.g.dart';
part 'mappable_user.mapper.dart';

@luthor
@MappableClass(caseStyle: CaseStyle.snakeCase)
class User with UserMappable {
  const User({
    @HasMin(2) required this.fullName,
    @IsEmail() required this.email,
    @HasMin(18) this.age,
  });

  final String fullName;
  final String email;
  final int? age;
}
