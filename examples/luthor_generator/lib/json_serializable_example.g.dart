// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_serializable_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) =>
    Address(street: json['street'] as String, city: json['city'] as String?);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'street': instance.street,
  'city': instance.city,
};

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
  userName: json['user_name'] as String,
  address: Address.fromJson(json['address'] as Map<String, dynamic>),
  plan: $enumDecode(_$PlanEnumMap, json['plan']),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
)..nickname = json['nickname'] as String?;

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
  'user_name': instance.userName,
  'address': instance.address.toJson(),
  'plan': _$PlanEnumMap[instance.plan]!,
  'tags': instance.tags,
  'nickname': instance.nickname,
};

const _$PlanEnumMap = {Plan.free: 'free', Plan.proMonthly: 'pro_monthly'};

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const AccountSchemaKeys = (
  userName: "user_name",
  address: "address",
  plan: "plan",
  tags: "tags",
  nickname: "nickname",
);

final SchemaValidator $AccountSchema = l
    .schema({
      AccountSchemaKeys.userName: l.string().min(3).required(),
      AccountSchemaKeys.address: forwardRef(() => _$AddressSchema.required()),
      AccountSchemaKeys.plan: l.oneOf(["free", "pro_monthly"]).required(),
      AccountSchemaKeys.tags: l.list(l.string().required()).required(),
      AccountSchemaKeys.nickname: l.string(),
    })
    .withName("Account");

ValidationResult<Account> $AccountValidate(Object? json) =>
    $AccountSchema.validateSchema(json, fromJson: Account.fromJson);

extension AccountValidationExtension on Account {
  ValidationResult<Account> validateSelf() =>
      $AccountValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const AccountErrorKeys = (
  userName: "user_name",
  address: ($key: "address", street: "address.street", city: "address.city"),
  plan: "plan",
  tags: "tags",
  nickname: "nickname",
);

final SchemaValidator _$AddressSchema = l
    .schema({"street": l.string().required(), "city": l.string()})
    .withName("Address");

Map<String, Object?> _$luthorJsonMap(Map<Object?, Object?> map) => {
  for (final entry in map.entries)
    entry.key.toString(): _$luthorJsonValue(entry.value),
};

Object? _$luthorJsonValue(Object? value) {
  if (value == null || value is String || value is num || value is bool) {
    return value;
  }
  if (value is Map) return _$luthorJsonMap(value);
  if (value is Iterable) {
    return [for (final item in value) _$luthorJsonValue(item)];
  }
  try {
    // ignore: avoid_dynamic_calls
    return _$luthorJsonValue((value as dynamic).toJson());
    // ignore: avoid_catching_errors
  } on NoSuchMethodError {
    return value;
  }
}
