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
    final result = l.list(validators: [l.string(), l.int()]).validateValue([
      'a',
      1,
    ]);

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
      final result = l.list(validators: [l.string(), l.int()]).validateValue([
        'a',
        1.1,
      ]);

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, [
            'value must be a list or does not match the validations',
          ]);
      }
    },
  );

  test(
    'should return false if the list contains an item that is null and all types are required',
    () {
      final result = l
          .list(validators: [l.string().required(), l.int().required()])
          .validateValue(['a', null]);

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, [
            'value must be a list or does not match the validations',
          ]);
      }
    },
  );

  test('should use custom message when message is provided', () {
    final result = l
        .list(message: 'Custom list error')
        .validateValue('not a list');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Custom list error']);
    }
  });

  test('should use messageFn when messageFn is provided', () {
    final result = l
        .list(messageFn: () => 'Dynamic list error')
        .validateValue('not a list');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['Dynamic list error']);
    }
  });

  test(
    'should prioritize custom message over messageFn when both are provided',
    () {
      final result = l
          .list(message: 'Static message', messageFn: () => 'Dynamic message')
          .validateValue('not a list');

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, ['Static message']);
      }
    },
  );

  test('should handle null return from messageFn and fallback to default', () {
    final result = l.list(messageFn: () => null).validateValue('not a list');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a list']);
    }
  });

  group('Issues', () {
    test('#33', () {
      final result = l.list(validators: [l.string().required()]).validateValue([
        'a',
        null,
      ]);

      switch (result) {
        case SingleValidationSuccess(data: _):
          fail('should not be a success');
        case SingleValidationError(data: _, errors: final errors):
          expect(errors, [
            'value must be a list or does not match the validations',
          ]);
      }
    });
  });
}
