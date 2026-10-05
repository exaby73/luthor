import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'ticket.freezed.dart';
part 'ticket.g.dart';

bool isEven(int value) => value.isEven;

String seatMessage(ValidationIssue issue) =>
    'Seat ${issue.params['min']} or higher';

@luthor
@freezed
abstract class Ticket with _$Ticket {
  const factory Ticket({
    @WithCustomValidator(isEven, message: 'must be even') required int seat,
    @HasMin(1, messageBuilder: seatMessage) required int row,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}
