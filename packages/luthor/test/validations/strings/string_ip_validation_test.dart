import 'package:luthor/luthor.dart';
import 'package:test/test.dart';

void main() {
  test('should return true when value is a valid IP', () {
    final result = l.string().ip().validateValue(
      '84d5:51a0:9114:1855:4cfa:f2d7:1f12:7003',
    );

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, '84d5:51a0:9114:1855:4cfa:f2d7:1f12:7003');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when value is not a valid IP', () {
    final result = l.string().ip().validateValue('256.1.1.1');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a valid IP address']);
    }
  });

  test('should return true when value is a valid IPv4 ', () {
    final result = l
        .string()
        .ip(version: IpVersion.v4)
        .validateValue('192.168.1.1');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, '192.168.1.1');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when the value is not a valid IPv4 address', () {
    final result = l
        .string()
        .ip(version: IpVersion.v4)
        .validateValue('84d5:51a0:9114:1855:4cfa:f2d7:1f12:7003');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a valid IPv4 address']);
    }
  });

  test('should return true when value is a valid IPv6 ', () {
    final result = l
        .string()
        .ip(version: IpVersion.v6)
        .validateValue('84d5:51a0:9114:1855:4cfa:f2d7:1f12:7003');

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, '84d5:51a0:9114:1855:4cfa:f2d7:1f12:7003');
      case SingleValidationError(data: _, errors: _):
        fail('should not have errors');
    }
  });

  test('should return false when the value is not a valid IPv6 address', () {
    final result = l
        .string()
        .ip(version: IpVersion.v6)
        .validateValue('192.168.1.1');

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value must be a valid IPv6 address']);
    }
  });

  test('should return true when value is null', () {
    final result = l.string().ip().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        expect(result.data, isNull);
      case SingleValidationError(errors: _):
        fail('should not have errors');
    }
  });

  test('should return false if the value is null with required()', () {
    final result = l.string().ip().required().validateValue(null);

    switch (result) {
      case SingleValidationSuccess(data: _):
        fail('should not be a success');
      case SingleValidationError(data: _, errors: final errors):
        expect(errors, ['value is required']);
    }
  });
}
