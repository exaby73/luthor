// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_upload_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FileUploadExample _$FileUploadExampleFromJson(Map<String, dynamic> json) =>
    _FileUploadExample(
      profileImage: json['profileImage'] as Object,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$FileUploadExampleToJson(_FileUploadExample instance) =>
    <String, dynamic>{
      'profileImage': instance.profileImage,
      'description': instance.description,
    };

// **************************************************************************
// LuthorGenerator
// **************************************************************************

// ignore: constant_identifier_names
const FileUploadExampleSchemaKeys = (
  profileImage: "profileImage",
  description: "description",
);

final SchemaValidator $FileUploadExampleSchema = l
    .schema({
      FileUploadExampleSchemaKeys.profileImage: l.file().required(),
      FileUploadExampleSchemaKeys.description: l.string(),
    })
    .withName("FileUploadExample");

ValidationResult<FileUploadExample> $FileUploadExampleValidate(Object? json) =>
    $FileUploadExampleSchema.validateSchema(
      json,
      fromJson: FileUploadExample.fromJson,
    );

extension FileUploadExampleValidationExtension on FileUploadExample {
  ValidationResult<FileUploadExample> validateSelf() =>
      $FileUploadExampleValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const FileUploadExampleErrorKeys = (
  profileImage: "profileImage",
  description: "description",
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
