// Runs the generated validate functions on the inputs the docs show and
// appends the results to website/src/data/verdicts.json under "generated".
import 'dart:convert';
import 'dart:io';

import 'package:luthor/luthor.dart';
import 'package:luthor_docs_generated/json_user.dart' as json_user;
import 'package:luthor_docs_generated/mappable_user.dart' as mappable_user;
import 'package:luthor_docs_generated/node.dart';
import 'package:luthor_docs_generated/plain_user.dart' as plain_user;
import 'package:luthor_docs_generated/registration.dart';
import 'package:luthor_docs_generated/ticket.dart';
import 'package:luthor_docs_generated/tutorial_user.dart' as tutorial;
import 'package:luthor_docs_generated/user.dart';

final verdicts = <String, Object?>{};
final outputs = <String, List<String>>{};

void verdict(String id, String title, List<(String, ValidationResult<Object?>)> rows) {
  verdicts[id] = {
    'title': title,
    'cases': [
      for (final (source, result) in rows)
        {
          'input': source,
          'pass': result.isValid,
          'issues': [
            for (final issue in result.issues)
              {'path': issue.errorPath, 'code': issue.code.name, 'message': issue.message},
          ],
        },
    ],
  };
}

void out(String id, List<Object?> lines) => outputs[id] = [for (final l in lines) '$l'];

void main() {
  const address = {'street': '1 Main St', 'city': 'Springfield', 'postcode': '12345'};
  const badAddress = {'street': '1 Main St', 'city': 'Springfield', 'postcode': '12'};

  verdict('gen.tutorial', r'$UserValidate(input)', [
    ("{'name': 'Ada', 'email': 'ada@example.com', 'age': 36}", tutorial.$UserValidate({'name': 'Ada', 'email': 'ada@example.com', 'age': 36})),
    ("{'name': 'Ada', 'email': 'ada@example.com'}", tutorial.$UserValidate({'name': 'Ada', 'email': 'ada@example.com'})),
    ("{'name': 'A', 'email': 'ada', 'age': 12}", tutorial.$UserValidate({'name': 'A', 'email': 'ada', 'age': 12})),
    ("'not a map'", tutorial.$UserValidate('not a map')),
  ]);
  final tbad = tutorial.$UserValidate({'name': 'A', 'email': 'ada', 'age': 12});
  out('gen.tutorial.switch', [
    switch (tutorial.$UserValidate({'name': 'Ada', 'email': 'ada@example.com', 'age': 36})) {
      ValidationSuccess(:final data) => '+ ${data.name} <${data.email}>',
      ValidationFailure(:final errors) => '- $errors',
    },
    switch (tbad) {
      ValidationSuccess(:final data) => '+ ${data.name} <${data.email}>',
      ValidationFailure(:final errors) => '- $errors',
    },
  ]);
  out('gen.tutorial.errorKeys', [tbad.getError(tutorial.UserErrorKeys.email), tbad.getError(tutorial.UserErrorKeys.age)]);
  out('gen.tutorial.validateSelf', [
    const tutorial.User(name: 'A', email: 'ada', age: 12).validateSelf().isValid,
    const tutorial.User(name: 'A', email: 'ada', age: 12).validateSelf().errors,
  ]);

  verdict('gen.user', r'$UserValidate(input)', [
    ("{'name': 'Ada', 'email_address': 'ada@example.com', 'age': 36, 'role': 'admin', 'address': {...}}",
        $UserValidate({'name': 'Ada', 'email_address': 'ada@example.com', 'age': 36, 'role': 'admin', 'address': address})),
    ("{'name': 'A', 'email_address': 'ada', 'age': 12, 'role': 'owner', 'address': {..., 'postcode': '12'}}",
        $UserValidate({'name': 'A', 'email_address': 'ada', 'age': 12, 'role': 'owner', 'address': badAddress})),
  ]);
  final ubad = $UserValidate({'name': 'A', 'email_address': 'ada', 'age': 12, 'role': 'owner', 'address': badAddress});
  out('gen.user.errors', [const JsonEncoder.withIndent('  ').convert(ubad.errors)]);
  out('gen.user.keys', [
    ubad.getError(UserErrorKeys.email),
    ubad.getError(UserErrorKeys.address.postcode),
    ubad.getError(UserErrorKeys.address.$key),
    UserSchemaKeys.email,
    UserErrorKeys.address.$key,
  ]);
  out('gen.user.notmap', [$UserValidate({'name': 'Ada', 'email_address': 'ada@example.com', 'address': 'nowhere'}).errors]);
  out('gen.user.unknown', [
    $UserValidate({'name': 'Ada', 'email_address': 'ada@example.com', 'address': {...address, 'country': 'FR'}, 'nickname': 'A'}).isValid,
  ]);
  final u = User(name: 'A', email: 'ada', address: const Address(street: 's', city: 'c', postcode: '12345'));
  out('gen.user.validateSelf', [u.validateSelf()]);

  verdict('gen.registration', r'$RegistrationValidate(input)', [
    ("{'name': 'Ada', 'email_address': 'ada@example.com', 'password': 'hunter2hunter2', 'confirm': 'hunter2hunter2', 'accountType': 'personal', 'age': 36, 'address': {...}}",
        $RegistrationValidate({'name': 'Ada', 'email_address': 'ada@example.com', 'password': 'hunter2hunter2', 'confirm': 'hunter2hunter2', 'accountType': 'personal', 'age': 36, 'address': address})),
    ("{'name': 'A', 'email_address': 'ada', 'password': 'short', 'confirm': 'different', 'accountType': 'business', 'age': 17, 'address': {..., 'postcode': '12'}}",
        $RegistrationValidate({'name': 'A', 'email_address': 'ada', 'password': 'short', 'confirm': 'different', 'accountType': 'business', 'age': 17, 'address': badAddress})),
  ]);
  final rbad = $RegistrationValidate({'name': 'A', 'email_address': 'ada', 'password': 'short', 'confirm': 'different', 'accountType': 'business', 'age': 17, 'address': badAddress});
  out('gen.registration.lines', [
    for (final k in [RegistrationErrorKeys.name, RegistrationErrorKeys.email, RegistrationErrorKeys.password, RegistrationErrorKeys.confirm, RegistrationErrorKeys.accountType, RegistrationErrorKeys.age, RegistrationErrorKeys.address.postcode])
      '- ${rbad.getError(k)}',
  ]);

  verdict('gen.signUp', r'$SignUpValidate(input)', [
    ("{'name': 'Ada', 'email': 'ada@example.com', 'password': 'hunter2hunter2', 'confirm': 'hunter2hunter2', 'website': 'https://ada.dev'}",
        $SignUpValidate({'name': 'Ada', 'email': 'ada@example.com', 'password': 'hunter2hunter2', 'confirm': 'hunter2hunter2', 'website': 'https://ada.dev'})),
    ("{'name': 'Ada', 'email': 'ada@example.com', 'password': 'hunter2hunter2', 'confirm': 'nope', 'website': 'http://ada.dev', 'accountType': 'team'}",
        $SignUpValidate({'name': 'Ada', 'email': 'ada@example.com', 'password': 'hunter2hunter2', 'confirm': 'nope', 'website': 'http://ada.dev', 'accountType': 'team'})),
  ]);

  verdict('gen.node', r'$NodeValidate(input)', [
    ("{'value': 'root', 'children': [{'value': 'leaf'}]}", $NodeValidate({'value': 'root', 'children': [{'value': 'leaf'}]})),
    ("{'value': 'root', 'children': [{'value': 'a', 'children': [{'value': 1}]}]}", $NodeValidate({'value': 'root', 'children': [{'value': 'a', 'children': [{'value': 1}]}]})),
    ("{'value': 'root', 'parent': {'value': 2}}", $NodeValidate({'value': 'root', 'parent': {'value': 2}})),
  ]);
  out('gen.node.keys', [NodeErrorKeys.children, NodeErrorKeys.parent]);

  verdict('gen.ticket', r'$TicketValidate(input)', [
    ("{'seat': 4, 'row': 2}", $TicketValidate({'seat': 4, 'row': 2})),
    ("{'seat': 3, 'row': 0}", $TicketValidate({'seat': 3, 'row': 0})),
  ]);

  verdict('gen.models', r'$UserValidate(input), for each setup', [
    ("json_serializable: {'full_name': 'Ada', 'email': 'ada@example.com'}", json_user.$UserValidate({'full_name': 'Ada', 'email': 'ada@example.com'})),
    ("plain class: {'name': 'Ada', 'email': 'ada@example.com'}", plain_user.$UserValidate({'name': 'Ada', 'email': 'ada@example.com'})),
    ("dart_mappable: {'full_name': 'Ada', 'email': 'ada@example.com'}", mappable_user.$UserValidate({'full_name': 'Ada', 'email': 'ada@example.com'})),
    ("plain class: {'name': 'A', 'email': 'ada'}", plain_user.$UserValidate({'name': 'A', 'email': 'ada'})),
  ]);
  out('gen.models.keys', [json_user.UserSchemaKeys.fullName, mappable_user.UserSchemaKeys.fullName, plain_user.UserSchemaKeys.name]);

  final file = File('../../src/data/generated.json');
  file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert({
    'generatedBy': 'website/scripts/generated/bin/check.dart',
    'dart': Platform.version.split(' ').first,
    'verdicts': verdicts,
    'outputs': outputs,
  }));
  stdout.writeln('wrote ${file.path}: ${verdicts.length} verdicts, ${outputs.length} outputs');
}
