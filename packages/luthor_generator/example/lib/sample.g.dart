// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Sample _$$_SampleFromJson(Map<String, dynamic> json) => _$_Sample(
      anyValue: json['anyValue'],
      boolValue: json['boolValue'] as bool,
      doubleValue: (json['doubleValue'] as num).toDouble(),
      intValue: json['intValue'] as int,
      listValue:
          (json['listValue'] as List<dynamic>).map((e) => e as String).toList(),
      numValue: json['numValue'] as num,
      stringValue: json['stringValue'] as String,
      email: json['email'] as String,
      date: json['date'] as String,
      exactly10Characters: json['exactly10Characters'] as String?,
      minAndMax: json['minAndMax'] as String,
      httpsLink: json['httpsLink'] as String?,
    );

Map<String, dynamic> _$$_SampleToJson(_$_Sample instance) => <String, dynamic>{
      'anyValue': instance.anyValue,
      'boolValue': instance.boolValue,
      'doubleValue': instance.doubleValue,
      'intValue': instance.intValue,
      'listValue': instance.listValue,
      'numValue': instance.numValue,
      'stringValue': instance.stringValue,
      'email': instance.email,
      'date': instance.date,
      'exactly10Characters': instance.exactly10Characters,
      'minAndMax': instance.minAndMax,
      'httpsLink': instance.httpsLink,
    };
