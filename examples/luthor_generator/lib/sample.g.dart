// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Sample _$SampleFromJson(Map<String, dynamic> json) => _Sample(
  anyValue: json['anyValue'],
  boolValue: json['boolValue'] as bool,
  doubleValue: (json['doubleValue'] as num).toDouble(),
  intValue: (json['intValue'] as num).toInt(),
  listValue: (json['listValue'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  numValue: json['numValue'] as num,
  stringValue: json['stringValue'] as String,
  email: json['email'] as String,
  date: json['date'] as String,
  dateTime: DateTime.parse(json['dateTime'] as String),
  exactly10Characters: json['exactly10Characters'] as String?,
  minAndMaxString: json['minAndMaxString'] as String,
  startsWithFoo: json['startsWithFoo'] as String,
  endsWithBar: json['endsWithBar'] as String,
  containsBaz: json['containsBaz'] as String,
  minAndMaxInt: (json['minAndMaxInt'] as num).toInt(),
  minAndMaxDouble: (json['minAndMaxDouble'] as num).toDouble(),
  minAndMaxNumber: json['minAndMaxNumber'] as num,
  httpsLink: json['httpsLink'] as String?,
  aUrl: json['aUrl'] as String?,
  luthorPath: json['luthorPath'] as String,
  uuid: json['uuid'] as String,
  cuid: json['cuid'] as String,
  cuid2: json['cuid2'] as String,
  emoji: json['emoji'] as String,
  anotherSample: AnotherSample.fromJson(
    json['anotherSample'] as Map<String, dynamic>,
  ),
  foo: json['jsonKeyName'] as String,
  custom: json['custom'] as String,
  numbers: (json['numbers'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  hello: json['hello'] as String?,
  size: $enumDecodeNullable(_$SizeEnumMap, json['size']) ?? Size.small,
);

Map<String, dynamic> _$SampleToJson(_Sample instance) => <String, dynamic>{
  'anyValue': instance.anyValue,
  'boolValue': instance.boolValue,
  'doubleValue': instance.doubleValue,
  'intValue': instance.intValue,
  'listValue': instance.listValue,
  'numValue': instance.numValue,
  'stringValue': instance.stringValue,
  'email': instance.email,
  'date': instance.date,
  'dateTime': instance.dateTime.toIso8601String(),
  'exactly10Characters': instance.exactly10Characters,
  'minAndMaxString': instance.minAndMaxString,
  'startsWithFoo': instance.startsWithFoo,
  'endsWithBar': instance.endsWithBar,
  'containsBaz': instance.containsBaz,
  'minAndMaxInt': instance.minAndMaxInt,
  'minAndMaxDouble': instance.minAndMaxDouble,
  'minAndMaxNumber': instance.minAndMaxNumber,
  'httpsLink': instance.httpsLink,
  'aUrl': instance.aUrl,
  'luthorPath': instance.luthorPath,
  'uuid': instance.uuid,
  'cuid': instance.cuid,
  'cuid2': instance.cuid2,
  'emoji': instance.emoji,
  'anotherSample': instance.anotherSample,
  'jsonKeyName': instance.foo,
  'custom': instance.custom,
  'numbers': instance.numbers,
  'hello': instance.hello,
  'size': _$SizeEnumMap[instance.size]!,
};

const _$SizeEnumMap = {Size.small: 'small', Size.large: 'L'};

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const SampleSchemaKeys = (
  anyValue: "anyValue",
  boolValue: "boolValue",
  doubleValue: "doubleValue",
  intValue: "intValue",
  listValue: "listValue",
  numValue: "numValue",
  stringValue: "stringValue",
  email: "email",
  date: "date",
  dateTime: "dateTime",
  exactly10Characters: "exactly10Characters",
  minAndMaxString: "minAndMaxString",
  startsWithFoo: "startsWithFoo",
  endsWithBar: "endsWithBar",
  containsBaz: "containsBaz",
  minAndMaxInt: "minAndMaxInt",
  minAndMaxDouble: "minAndMaxDouble",
  minAndMaxNumber: "minAndMaxNumber",
  httpsLink: "httpsLink",
  aUrl: "aUrl",
  luthorPath: "luthorPath",
  uuid: "uuid",
  cuid: "cuid",
  cuid2: "cuid2",
  emoji: "emoji",
  anotherSample: "anotherSample",
  foo: "jsonKeyName",
  custom: "custom",
  numbers: "numbers",
  hello: "hello",
  size: "size",
);

final SchemaValidator $SampleSchema = l
    .schema({
      SampleSchemaKeys.anyValue: l.any(),
      SampleSchemaKeys.boolValue: l.bool().required(),
      SampleSchemaKeys.doubleValue: l.double().required(),
      SampleSchemaKeys.intValue: l.int().required(),
      SampleSchemaKeys.listValue: l.list(l.string().required()).required(),
      SampleSchemaKeys.numValue: l.num().required(),
      SampleSchemaKeys.stringValue: l.string().required(),
      SampleSchemaKeys.email: l
          .string()
          .email(messageBuilder: emailErrorMessage)
          .required(),
      SampleSchemaKeys.date: l.string().dateTime().required(),
      SampleSchemaKeys.dateTime: l.string().dateTime().required(),
      SampleSchemaKeys.exactly10Characters: l.string().length(
        10,
        messageBuilder: lengthErrorMessage,
      ),
      SampleSchemaKeys.minAndMaxString: l.string().min(8).max(200).required(),
      SampleSchemaKeys.startsWithFoo: l.string().startsWith("foo").required(),
      SampleSchemaKeys.endsWithBar: l.string().endsWith("bar").required(),
      SampleSchemaKeys.containsBaz: l.string().contains("baz").required(),
      SampleSchemaKeys.minAndMaxInt: l.int().min(2).max(4).required(),
      SampleSchemaKeys.minAndMaxDouble: l.double().min(2.0).max(4.0).required(),
      SampleSchemaKeys.minAndMaxNumber: l.num().min(2).max(3.0).required(),
      SampleSchemaKeys.httpsLink: l.string().uri(allowedSchemes: ["https"]),
      SampleSchemaKeys.aUrl: l.string().url(),
      SampleSchemaKeys.luthorPath: l
          .string()
          .regex(
            RegExp(
              r'^https:\/\/pub\.dev\/packages\/luthor',
              caseSensitive: false,
            ),
            messageBuilder: regexErrorMessage,
          )
          .required(),
      SampleSchemaKeys.uuid: l.string().uuid().required(),
      SampleSchemaKeys.cuid: l.string().cuid().required(),
      SampleSchemaKeys.cuid2: l.string().cuid2().required(),
      SampleSchemaKeys.emoji: l.string().emoji().required(),
      SampleSchemaKeys.anotherSample: forwardRef(
        () => $AnotherSampleSchema.required(),
      ),
      SampleSchemaKeys.foo: l.string().required(),
      SampleSchemaKeys.custom: l
          .string()
          .custom(
            customValidatorFn,
            messageBuilder: Sample.customValidatorMessage,
          )
          .required(),
      SampleSchemaKeys.numbers: l.list(l.int().required()).required(),
      SampleSchemaKeys.hello: l.string(),
      SampleSchemaKeys.size: l.oneOf(["small", "L"]),
    })
    .withName("Sample");

ValidationResult<Sample> $SampleValidate(Object? json) =>
    $SampleSchema.validateSchema(json, fromJson: Sample.fromJson);

extension SampleValidationExtension on Sample {
  ValidationResult<Sample> validateSelf() =>
      $SampleValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const SampleErrorKeys = (
  anyValue: "anyValue",
  boolValue: "boolValue",
  doubleValue: "doubleValue",
  intValue: "intValue",
  listValue: "listValue",
  numValue: "numValue",
  stringValue: "stringValue",
  email: "email",
  date: "date",
  dateTime: "dateTime",
  exactly10Characters: "exactly10Characters",
  minAndMaxString: "minAndMaxString",
  startsWithFoo: "startsWithFoo",
  endsWithBar: "endsWithBar",
  containsBaz: "containsBaz",
  minAndMaxInt: "minAndMaxInt",
  minAndMaxDouble: "minAndMaxDouble",
  minAndMaxNumber: "minAndMaxNumber",
  httpsLink: "httpsLink",
  aUrl: "aUrl",
  luthorPath: "luthorPath",
  uuid: "uuid",
  cuid: "cuid",
  cuid2: "cuid2",
  emoji: "emoji",
  anotherSample: (
    $key: "anotherSample",
    id: "anotherSample.id",
    name: "anotherSample.full_name",
    email: "anotherSample.email",
    ip: "anotherSample.ip",
    password: "anotherSample.password",
    type: "anotherSample.type",
    url: "anotherSample.url",
    roles: "anotherSample.roles",
  ),
  foo: "jsonKeyName",
  custom: "custom",
  numbers: "numbers",
  hello: "hello",
  size: "size",
);

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
