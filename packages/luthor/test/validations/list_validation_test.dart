import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true for an empty list', () {
    final result = l.list().validateValue([]);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, []);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return true for a list of any items', () {
    final result = l.list().validateValue(['a', 1.1, 1]);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, ['a', 1.1, 1]);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return true if the list contains only specified types', () {
    final result =
        l.list(validators: [l.string(), l.int()]).validateValue(['a', 1]);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, ['a', 1]);
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test(
      'should return false if the list contains an item that does not match the specified type',
      () {
    final result =
        l.list(validators: [l.string(), l.int()]).validateValue(['a', 1.1]);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(
          errors,
          ['value must be a list or does not match the validations'],
        );
    }
  });

  test(
      'should return false if the list contains an item that is null and all types are required',
      () {
    final result = l.list(
      validators: [l.string().required(), l.int().required()],
    ).validateValue(['a', null]);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(
          errors,
          ['value must be a list or does not match the validations'],
        );
    }
  });

  group('Issues', () {
    test('#33', () {
      final result = l.list(
        validators: [l.string().required()],
      ).validateValue(['a', null]);

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(
            errors,
            ['value must be a list or does not match the validations'],
          );
      }
    });
  });
}
