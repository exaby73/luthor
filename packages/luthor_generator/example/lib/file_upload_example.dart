import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'file_upload_example.freezed.dart';
part 'file_upload_example.g.dart';

@luthor
@freezed
abstract class FileUploadExample with _$FileUploadExample {
  const factory FileUploadExample({
    @IsFile() required Object profileImage,
    String? description,
  }) = _FileUploadExample;

  factory FileUploadExample.fromJson(Map<String, dynamic> json) =>
      _$FileUploadExampleFromJson(json);
}

void main() {
  final valid = $FileUploadExampleValidate({
    'profileImage': Uint8List.fromList([1, 2, 3]),
    'description': 'Avatar upload',
  });

  final invalid = $FileUploadExampleValidate({'profileImage': 'not-a-file'});

  print(valid);
  print(invalid);
}
