import 'dart:io';
import 'dart:typed_data';

import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'utils/matchers.dart';

void main() {
  group('Given the file validator', () {
    test('When the value is bytes or a byte stream then it passes', () {
      for (final value in <Object>[
        Uint8List.fromList([1]),
        ByteData(1),
        Uint8List(2).buffer,
        <int>[1, 2],
        Stream<List<int>>.value([1]),
        Stream<Uint8List>.value(Uint8List(1)),
      ]) {
        expect(l.file().validate(value).isValid, isTrue, reason: '$value');
      }
    });

    test('When the value is a dart:io File then it passes', () {
      expect(l.file().validate(File('missing.txt')).isValid, isTrue);
    }, testOn: 'vm');

    test('When a class name merely contains file, stream or bytes then it '
        'fails', () {
      for (final value in <Object>[
        Profile(),
        UserStream(),
        MultipartFile(),
        const FileSystemExceptionLike(),
        Stream.value(1),
        'file.txt',
        <Object?>[1, 2],
      ]) {
        expect(
          l.file().validate(value),
          isInvalidWith(['value must be a file']),
          reason: '$value',
        );
      }
    });

    test('When an accept predicate matches a package type then it passes', () {
      final validator = l.file(accept: (value) => value is MultipartFile);

      expect(validator.validate(MultipartFile()).isValid, isTrue);
      expect(validator.validate(Profile()).isValid, isFalse);
    });

    test('When the accept predicate throws then the value fails', () {
      final validator = l.file(accept: (value) => throw StateError('boom'));

      expect(validator.validate(Profile()).isValid, isFalse);
    });
  });
}

final class Profile {}

final class UserStream {}

final class MultipartFile {}

final class FileSystemExceptionLike {
  const FileSystemExceptionLike();
}
