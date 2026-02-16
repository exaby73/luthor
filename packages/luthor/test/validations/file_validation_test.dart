import 'dart:io';
import 'dart:typed_data';

import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should validate File instances', () {
    final result = l.file().validateValue(File('avatar.png'));

    switch (result) {
      case SingleValidationSuccess(data: final data):
        expect(data, isA<File>());
      case SingleValidationError(data: _, errors: final errors):
        fail('expected success but got errors: $errors');
    }
  });

  test('should validate byte arrays as file-like values', () {
    final result = l.file().validateValue(Uint8List.fromList([1, 2, 3]));

    switch (result) {
      case SingleValidationSuccess(data: final data):
        expect(data, isA<Uint8List>());
      case SingleValidationError(data: _, errors: final errors):
        fail('expected success but got errors: $errors');
    }
  });

  test('should fail for null values', () {
    final result = l.file().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a file']);
    }
  });

  test('should fail for non file-like values', () {
    final result = l.file().validateValue('not-a-file');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a file']);
    }
  });

  test('should use custom message when message is provided', () {
    final result = l
        .file(message: 'profileImage must be a file')
        .validateValue('not-a-file');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['profileImage must be a file']);
    }
  });

  test('should use messageFn when provided', () {
    final result = l
        .file(messageFn: () => 'dynamic file error')
        .validateValue('not-a-file');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['dynamic file error']);
    }
  });
}
