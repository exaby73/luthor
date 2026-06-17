import 'dart:typed_data';

import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

import 'utils/matchers.dart';

void main() {
  group('Given named validators', () {
    test(
      'When validating single values then default messages use the name',
      () {
        expect(
          l.withName('email').string().email().validateValue('nope'),
          isSingleError<String>(['email must be a valid email address']),
        );
        expect(
          l.withName('age').int().min(18).validateValue(17),
          isSingleError<int>(['age must be greater than or equal to 18']),
        );
        expect(
          l.withName('score').double().max(1.5).validateValue(2.0),
          isSingleError<double>(['score must be less than or equal to 1.5']),
        );
        expect(
          l.withName('amount').number().max(10).validateValue(11),
          isSingleError<int>(['amount must be less than or equal to 10']),
        );
        expect(
          l.withName('enabled').boolean().validateValue('true'),
          isSingleError<String>(['enabled must be a bool']),
        );
      },
    );
  });

  group('Given nullable single-value validators', () {
    test('When value is null then optional validators accept it', () {
      expect(l.boolean().validateValue(null).isValid, isTrue);
      expect(l.double().validateValue(null).isValid, isTrue);
      expect(l.file().validateValue(null).isValid, isTrue);
      expect(l.int().validateValue(null).isValid, isTrue);
      expect(l.list().validateValue(null).isValid, isTrue);
      expect(l.map().validateValue(null).isValid, isTrue);
      expect(l.number().validateValue(null).isValid, isTrue);
      expect(l.string().validateValue(null).isValid, isTrue);
    });

    test('When value is null but required then validation fails', () {
      expect(
        l.file().required().validateValue(null),
        isSingleError<Object?>(['value is required']),
      );
    });
  });

  group('Given nullValue validators', () {
    test('When value is not null then validation fails', () {
      expect(
        l.nullValue().validateValue('not-null'),
        isSingleError<String>(['value must be null']),
      );
    });
  });

  group('Given file validators', () {
    test(
      'When value has a file-like runtime type then validation succeeds',
      () {
        expect(l.file().validateValue(Uint8List.fromList([1])).isValid, isTrue);
        expect(l.file().validateValue(ByteData(1)).isValid, isTrue);
      },
    );

    test('When value is not file-like then validation fails', () {
      expect(
        l.file().validateValue('file.txt'),
        isSingleError<String>(['value must be a file']),
      );
    });
  });

  group('Given custom validators', () {
    test('When validator returns false then custom error is returned', () {
      expect(
        l.custom((value) => value == 'ok').validateValue('bad'),
        isSingleError<String>(['value does not pass custom validation']),
      );
    });

    test('When validator throws then custom error is returned', () {
      expect(
        l.custom((value) => throw StateError('boom')).validateValue('bad'),
        isSingleError<String>(['value does not pass custom validation']),
      );
    });
  });

  group('Given collection validators', () {
    test('When list validators are absent then any list is accepted', () {
      expect(l.list().validateValue([Object(), null, 1]).isValid, isTrue);
    });

    test('When map validators are absent then any map is accepted', () {
      expect(l.map().validateValue({1: Object(), 'x': null}).isValid, isTrue);
    });

    test('When value is not a list then list validation fails', () {
      expect(
        l.list().validateValue('not-list'),
        isSingleError<String>(['value must be a list']),
      );
    });
  });
}
