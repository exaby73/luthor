import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true for an empty list', () {
    final result = l.list().validate([]);
    expect(result.isValid, true);
    expect(result.message, isNull);
  });

  test('should return true for a list of any items', () {
    final result = l.list().validate(['a', 1.1, 1]);
    expect(result.isValid, true);
    expect(result.message, isNull);
  });

  test('should return true if the list contains only specified types', () {
    final result = l.list(validators: [l.string(), l.int()]).validate(['a', 1]);
    expect(result.isValid, true);
    expect(result.message, isNull);
  });

  test(
      'should return false if the list contains an item that does not match the specified type',
      () {
    final result =
        l.list(validators: [l.string(), l.int()]).validate(['a', 1.1]);
    expect(result.isValid, false);
    expect(
      result.message,
      'value must be a list or does not match the validations',
    );
  });

  test(
      'should return false if the list contains an item that is null and all types are required',
      () {
    final result = l.list(validators: [
      l.string().required(),
      l.int().required(),
    ],).validate(['a', null]);

    expect(result.isValid, false);
    expect(
      result.message,
      'value must be a list or does not match the validations',
    );
  });
}
