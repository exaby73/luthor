// ignore: constant_identifier_names
const TicketSchemaKeys = (seat: "seat");

final SchemaValidator $TicketSchema = l
    .schema({
      TicketSchemaKeys.seat: l.int()
          .custom(isEven, message: "must be even")
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
const TicketErrorKeys = (seat: "seat");
