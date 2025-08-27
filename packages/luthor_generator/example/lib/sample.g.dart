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

Validator $SampleSchema = l.withName('Sample').schema({
  'anyValue': l.any(),
  'boolValue': l.boolean().required(),
  'doubleValue': l.double().required(),
  'intValue': l.int().required(),
  'listValue': l.list(validators: [l.string().required()]).required(),
  'numValue': l.number().required(),
  'stringValue': l.string().required(),
  'email': l.string().email().required(),
  'date': l.string().dateTime().required(),
  'dateTime': l.string().dateTime().required(),
  'exactly10Characters': l.string().length(10),
  'minAndMaxString': l.string().max(200).min(8).required(),
  'startsWithFoo': l.string().startsWith(r"foo").required(),
  'endsWithBar': l.string().endsWith(r"bar").required(),
  'containsBaz': l.string().contains(r"baz").required(),
  'minAndMaxInt': l.int().max(4).min(2).required(),
  'minAndMaxDouble': l.double().max(4.0).min(2.0).required(),
  'minAndMaxNumber': l.number().max(3.0).min(2).required(),
  'httpsLink': l.string().uri(allowedSchemes: ['https']),
  'aUrl': l.string().url(),
  'luthorPath': l
      .string()
      .regex(r"^https:\/\/pub\.dev\/packages\/luthor")
      .required(),
  'anotherSample': $AnotherSampleSchema.required(),
  'jsonKeyName': l.string().required(),
  'custom': l.string().custom(customValidatorFn).required(),
  'numbers': l.list(validators: [l.int().required()]).required(),
  'hello': l.string(),
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
    sample: (
      anyValue: "anotherSample.sample.anyValue",
      boolValue: "anotherSample.sample.boolValue",
      doubleValue: "anotherSample.sample.doubleValue",
      intValue: "anotherSample.sample.intValue",
      listValue: "anotherSample.sample.listValue",
      numValue: "anotherSample.sample.numValue",
      stringValue: "anotherSample.sample.stringValue",
      email: "anotherSample.sample.email",
      date: "anotherSample.sample.date",
      dateTime: "anotherSample.sample.dateTime",
      exactly10Characters: "anotherSample.sample.exactly10Characters",
      minAndMaxString: "anotherSample.sample.minAndMaxString",
      startsWithFoo: "anotherSample.sample.startsWithFoo",
      endsWithBar: "anotherSample.sample.endsWithBar",
      containsBaz: "anotherSample.sample.containsBaz",
      minAndMaxInt: "anotherSample.sample.minAndMaxInt",
      minAndMaxDouble: "anotherSample.sample.minAndMaxDouble",
      minAndMaxNumber: "anotherSample.sample.minAndMaxNumber",
      httpsLink: "anotherSample.sample.httpsLink",
      aUrl: "anotherSample.sample.aUrl",
      luthorPath: "anotherSample.sample.luthorPath",
      anotherSample: "anotherSample.sample.anotherSample",
      foo: "anotherSample.sample.jsonKeyName",
      custom: "anotherSample.sample.custom",
      numbers: "anotherSample.sample.numbers",
      hello: "anotherSample.sample.hello",
    ),
    optionalSample: (
      anyValue: "anotherSample.optionalSample.anyValue",
      boolValue: "anotherSample.optionalSample.boolValue",
      doubleValue: "anotherSample.optionalSample.doubleValue",
      intValue: "anotherSample.optionalSample.intValue",
      listValue: "anotherSample.optionalSample.listValue",
      numValue: "anotherSample.optionalSample.numValue",
      stringValue: "anotherSample.optionalSample.stringValue",
      email: "anotherSample.optionalSample.email",
      date: "anotherSample.optionalSample.date",
      dateTime: "anotherSample.optionalSample.dateTime",
      exactly10Characters: "anotherSample.optionalSample.exactly10Characters",
      minAndMaxString: "anotherSample.optionalSample.minAndMaxString",
      startsWithFoo: "anotherSample.optionalSample.startsWithFoo",
      endsWithBar: "anotherSample.optionalSample.endsWithBar",
      containsBaz: "anotherSample.optionalSample.containsBaz",
      minAndMaxInt: "anotherSample.optionalSample.minAndMaxInt",
      minAndMaxDouble: "anotherSample.optionalSample.minAndMaxDouble",
      minAndMaxNumber: "anotherSample.optionalSample.minAndMaxNumber",
      httpsLink: "anotherSample.optionalSample.httpsLink",
      aUrl: "anotherSample.optionalSample.aUrl",
      luthorPath: "anotherSample.optionalSample.luthorPath",
      anotherSample: "anotherSample.optionalSample.anotherSample",
      foo: "anotherSample.optionalSample.jsonKeyName",
      custom: "anotherSample.optionalSample.custom",
      numbers: "anotherSample.optionalSample.numbers",
      hello: "anotherSample.optionalSample.hello",
    ),
  ),
  foo: "jsonKeyName",
  custom: "custom",
  numbers: "numbers",
  hello: "hello",
);
