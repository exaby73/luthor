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

Validator $FileUploadExampleSchema = l.withName('FileUploadExample').schema({
  FileUploadExampleSchemaKeys.profileImage: l.file().required(),
  FileUploadExampleSchemaKeys.description: l.string(),
});

SchemaValidationResult<FileUploadExample> $FileUploadExampleValidate(
  Map<String, dynamic> json,
) => $FileUploadExampleSchema.validateSchema(
  json,
  fromJson: FileUploadExample.fromJson,
);

extension FileUploadExampleValidationExtension on FileUploadExample {
  SchemaValidationResult<FileUploadExample> validateSelf() =>
      $FileUploadExampleValidate(toJson());
}

// ignore: constant_identifier_names
const FileUploadExampleErrorKeys = (
  profileImage: "profileImage",
  description: "description",
);
