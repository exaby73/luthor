import 'dart:convert';

import 'package:luthor/luthor.dart';
import 'package:luthor_forms/src/keyed_validator.dart';
import 'package:state_notifier/state_notifier.dart';

abstract class LuthorForm<T> extends StateNotifier<bool> {
  LuthorForm([List<KeyedValidator>? initialKeyedValidators]) : super(true) {
    if (initialKeyedValidators != null) {
      registerNewValidators(initialKeyedValidators);
    }
  }

  final List<KeyedValidator> _keyedValidators = [];

  void registerNewValidators(
    List<KeyedValidator> keyedValidators, {
    bool clear = false,
  }) {
    if (clear) this.clear();
    _keyedValidators.addAll(keyedValidators);
  }

  void clear() => _keyedValidators.clear();

  Validator get schema {
    final s = <String, Validator>{};
    for (final kv in _keyedValidators) {
      final nestedKeys = kv.key.split('.');
      if (nestedKeys.length == 1) {
        s[kv.key] = kv.validator;
      } else {
        var previous = s.putIfAbsent(nestedKeys.first, () => l.schema({}));
        for (final key in nestedKeys.skip(1).take(nestedKeys.length - 2)) {
          previous = (previous.validations.last as SchemaValidation)
              .validatorSchema
              .putIfAbsent(key, () => l.schema({}));
        }
        (previous.validations.last as SchemaValidation)
            .validatorSchema[nestedKeys.last] = kv.validator;
      }
    }
    return l.schema(s);
  }

  T fromJson(Map<String, dynamic> json);
}

class Foo extends LuthorForm<Foo> {
  Foo() {
    registerNewValidators([name, city, street]);
  }

  final name = KeyedValidator('name', l.string().min(1).required());
  final city = KeyedValidator('address.city', l.string().min(1).required());
  final street = KeyedValidator('address.street', l.string().min(1).required());

  @override
  Foo fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

void main() {
  final foo = Foo();
  print(JsonEncoder.withIndent('  ').convert(foo.schema));
}
