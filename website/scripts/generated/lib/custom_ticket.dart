import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'custom_ticket.freezed.dart';
part 'custom_ticket.g.dart';

bool isEven(int value) => value.isEven;

@luthor
@freezed
abstract class Ticket with _$Ticket {
  const factory Ticket({
    @WithCustomValidator(isEven, message: 'must be even') required int seat,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}
