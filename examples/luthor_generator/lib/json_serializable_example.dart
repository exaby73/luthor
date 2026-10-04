import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'json_serializable_example.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum Plan { free, proMonthly }

@JsonSerializable()
class Address {
  const Address({required this.street, this.city});

  final String street;
  final String? city;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@luthor
@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Account {
  Account({
    @HasMin(3) required this.userName,
    required this.address,
    required this.plan,
    required this.tags,
  });

  final String userName;
  final Address address;
  final Plan plan;
  final List<String> tags;

  // json_serializable assigns settable fields after the constructor, so they
  // are schema fields too and survive unknown-key stripping.
  String? nickname;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

void main() {
  final valid = $AccountValidate({
    'user_name': 'ada',
    'address': {'street': 'Main St', 'unknown': 'stripped'},
    'plan': 'pro_monthly',
    'tags': ['admin'],
    'nickname': 'Ada',
  });
  switch (valid) {
    case ValidationSuccess(:final data):
      print('Valid: ${data.userName} (${data.nickname}) on ${data.plan}');
      print(data.validateSelf().isValid);
    case ValidationFailure(:final errors):
      print(errors);
  }

  final invalid = $AccountValidate({
    'user_name': 'al',
    'address': {'city': 'Paris'},
    'plan': 'enterprise',
    'tags': ['admin', 7],
  });
  print(invalid.errors);
  print(invalid.getError(AccountErrorKeys.userName));
  print(invalid.getError(AccountErrorKeys.address.street));
  print(invalid.getError(AccountErrorKeys.plan));
}
