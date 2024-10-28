import 'package:dart_mappable/dart_mappable.dart';
import 'package:luthor/luthor.dart';

part 'without_freezed.mapper.dart';

part 'without_freezed.g.dart';

@luthor
class WithoutFreezed {
  final String name;
  final int age;

  const WithoutFreezed({
    @isEmail required this.name,
    required this.age,
  });

  factory WithoutFreezed.fromJson(Map<String, dynamic> json) {
    return WithoutFreezed(
      name: json['name'] as String,
      age: json['age'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }
}

@luthor
@MappableClass()
class WithDartMappable with WithDartMappableMappable {
  final String email;
  final String password;

  const WithDartMappable({
    @isEmail required this.email,
    @HasMin(8) required this.password,
  });
}
