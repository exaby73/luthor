import 'package:luthor/luthor.dart';

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
}
