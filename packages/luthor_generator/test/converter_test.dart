import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given a model whose fields use JSON converters', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_converterSource)).output;
    });

    test('Then a field converter validates the raw value as any', () {
      expectOutputContains(output, 'EventSchemaKeys.at: l.any().required(),');
    });

    test('Then a JsonKey fromJson function validates the raw value as any', () {
      expectOutputContains(
        output,
        'EventSchemaKeys.price: l.any().required(),',
      );
    });

    test('Then a class-level converter applies to fields of its type', () {
      expectOutputContains(output, 'EventSchemaKeys.endsAt: l.any(),');
    });

    group('When the validate functions run', () {
      late Map<String, Object?> results;

      setUpAll(() async {
        results = await evaluateGenerated(_converterSource, {
          'raw': r'''$EventValidate({'at': 1700000000, 'price': '1.00'})''',
          'self':
              '''Event(at: DateTime(2024), price: const Money(1)).validateSelf()''',
        });
      });

      test('Then the raw converted JSON value succeeds', () {
        expect(results['raw'], 'success');
      });

      test('Then validateSelf succeeds on the converted output', () {
        expect(results['self'], 'success');
      });
    });
  });
}

const _converterSource = r'''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

class EpochConverter implements JsonConverter<DateTime, int> {
  const EpochConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}

class Money {
  final int cents;

  const Money(this.cents);
}

Money moneyFromJson(String value) => const Money(100);

String moneyToJson(Money money) => '${money.cents / 100}';

@luthor
@JsonSerializable(converters: [EpochConverter()])
class Event {
  @EpochConverter()
  final DateTime at;
  @JsonKey(fromJson: moneyFromJson, toJson: moneyToJson)
  final Money price;
  final DateTime? endsAt;

  const Event({required this.at, required this.price, this.endsAt});

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    at: const EpochConverter().fromJson(json['at'] as int),
    price: moneyFromJson(json['price'] as String),
    endsAt: json['endsAt'] == null
        ? null
        : const EpochConverter().fromJson(json['endsAt'] as int),
  );

  Map<String, dynamic> toJson() => {
    'at': const EpochConverter().toJson(at),
    'price': moneyToJson(price),
    'endsAt': endsAt == null ? null : const EpochConverter().toJson(endsAt!),
  };
}
''';
