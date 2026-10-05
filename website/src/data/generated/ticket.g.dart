// ignore: constant_identifier_names
const TicketSchemaKeys = (seat: "seat", row: "row");

final SchemaValidator $TicketSchema = l
    .schema({
      TicketSchemaKeys.seat: l.int()
          .custom(isEven, message: "must be even")
          .required(),
      TicketSchemaKeys.row: l.int()
          .min(1, messageBuilder: seatMessage)
          .required(),
    })
    .withName("Ticket");

ValidationResult<Ticket> $TicketValidate(Object? json) =>
    $TicketSchema.validateSchema(json, fromJson: Ticket.fromJson);

extension TicketValidationExtension on Ticket {
  ValidationResult<Ticket> validateSelf() =>
      $TicketValidate(_$luthorJsonMap(toJson()));
}

// ignore: constant_identifier_names
const TicketErrorKeys = (seat: "seat", row: "row");
