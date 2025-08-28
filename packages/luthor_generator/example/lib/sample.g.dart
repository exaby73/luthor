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
  anotherSample: AnotherSample.fromJson(
    json['anotherSample'] as Map<String, dynamic>,
  ),
  foo: json['jsonKeyName'] as String,
  custom: json['custom'] as String,
  numbers: (json['numbers'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  hello: json['hello'] as String?,
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
  'anotherSample': instance.anotherSample,
  'jsonKeyName': instance.foo,
  'custom': instance.custom,
  'numbers': instance.numbers,
  'hello': instance.hello,
};

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
  anotherSample: "anotherSample",
  foo: "jsonKeyName",
  custom: "custom",
  numbers: "numbers",
  hello: "hello",
);

Validator $SampleSchema = l.withName('Sample').schema({
  SampleSchemaKeys.anyValue: l.any(),
  SampleSchemaKeys.boolValue: l.boolean().required(),
  SampleSchemaKeys.doubleValue: l.double().required(),
  SampleSchemaKeys.intValue: l.int().required(),
  SampleSchemaKeys.listValue: l
      .list(validators: [l.string().required()])
      .required(),
  SampleSchemaKeys.numValue: l.number().required(),
  SampleSchemaKeys.stringValue: l.string().required(),
  SampleSchemaKeys.email: l
      .string()
      .email(messageFn: emailErrorMessage)
      .required(),
  SampleSchemaKeys.date: l.string().dateTime().required(),
  SampleSchemaKeys.dateTime: l.string().dateTime().required(),
  SampleSchemaKeys.exactly10Characters: l.string().length(
    10,
    messageFn: lengthErrorMessage,
  ),
  SampleSchemaKeys.minAndMaxString: l.string().max(200).min(8).required(),
  SampleSchemaKeys.startsWithFoo: l.string().startsWith(r"foo").required(),
  SampleSchemaKeys.endsWithBar: l.string().endsWith(r"bar").required(),
  SampleSchemaKeys.containsBaz: l.string().contains(r"baz").required(),
  SampleSchemaKeys.minAndMaxInt: l.int().max(4).min(2).required(),
  SampleSchemaKeys.minAndMaxDouble: l.double().max(4.0).min(2.0).required(),
  SampleSchemaKeys.minAndMaxNumber: l.number().max(3.0).min(2).required(),
  SampleSchemaKeys.httpsLink: l.string().uri(allowedSchemes: ['https']),
  SampleSchemaKeys.aUrl: l.string().url(),
  SampleSchemaKeys.luthorPath: l
      .string()
      .regex(
        r"^https:\/\/pub\.dev\/packages\/luthor",
        messageFn: regexErrorMessage,
      )
      .required(),
  SampleSchemaKeys.anotherSample: $AnotherSampleSchema.required(),
  SampleSchemaKeys.foo: l.string().required(),
  SampleSchemaKeys.custom: l
      .string()
      .custom(customValidatorFn, messageFn: customValidatorMessage)
      .required(),
  SampleSchemaKeys.numbers: l.list(validators: [l.int().required()]).required(),
  SampleSchemaKeys.hello: l.string(),
});

SchemaValidationResult<Sample> $SampleValidate(Map<String, dynamic> json) =>
    $SampleSchema.validateSchema(json, fromJson: Sample.fromJson);

extension SampleValidationExtension on Sample {
  SchemaValidationResult<Sample> validateSelf() => $SampleValidate(toJson());
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
  anotherSample: (
    id: "anotherSample.id",
    name: "anotherSample.full_name",
    email: "anotherSample.email",
    ip: "anotherSample.ip",
    password: "anotherSample.password",
    type: "anotherSample.type",
    url: "anotherSample.url",
  ),
  foo: "jsonKeyName",
  custom: "custom",
  numbers: "numbers",
  hello: "hello",
);
