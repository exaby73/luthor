// Runs the docs' runtime examples against packages/luthor and writes the
// results to website/src/data/verdicts.json. Every Verdict figure and every
// printed output on the site comes from this file. Rerun with
// `website/scripts/run.sh` after changing luthor or an example.
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:luthor/luthor.dart';

typedef Case = (String source, Object? value);

final verdicts = <String, Object?>{};
final outputs = <String, List<String>>{};

void verdict(String id, String title, Validator<Object?> v, List<Case> cases) {
  verdicts[id] = {
    'title': title,
    'cases': [for (final (source, value) in cases) _row(source, v.validate(value))],
  };
}

void verdictSchema<T>(
  String id,
  String title,
  SchemaValidator<Map<String, Object?>?> v,
  FromJson<T> fromJson,
  List<Case> cases,
) {
  verdicts[id] = {
    'title': title,
    'cases': [
      for (final (source, value) in cases)
        _row(source, v.validateSchema(value, fromJson: fromJson)),
    ],
  };
}

Map<String, Object?> _row(String source, ValidationResult<Object?> result) => {
  'input': source,
  'pass': result.isValid,
  'issues': [
    for (final issue in result.issues)
      {'path': issue.errorPath, 'code': issue.code.name, 'message': issue.message},
  ],
};

void out(String id, List<Object?> lines) {
  outputs[id] = [for (final l in lines) '$l'];
}

// Functions shared by several examples. They mirror the ones in the docs.
bool isEven(int value) => value.isEven;
bool matchesPassword(String value, SchemaData data) =>
    value == data['password'];
bool phoneForBusiness(String value, SchemaData data) {
  if (value != 'business') return true;
  final phone = data['phone'];
  return phone is String && phone.isNotEmpty;
}
bool endAfterStart(Map<String, Object?> data) {
  final start = DateTime.tryParse('${data['start']}');
  final end = DateTime.tryParse('${data['end']}');
  return start != null && end != null && end.isAfter(start);
}
String? _nothing(ValidationIssue issue) => null;

class User {
  const User({required this.email, this.age});
  final String email;
  final int? age;
  factory User.fromJson(Map<String, Object?> json) =>
      User(email: json['email']! as String, age: json['age'] as int?);
  @override
  String toString() => 'User(email: $email, age: $age)';
}

void main() {
  // ---- Landing and tutorials -------------------------------------------
  final email = l.string().email().required();
  verdict('email', 'email.validate(input)', email, [
    ("'dev@example.com'", 'dev@example.com'),
    ("'bad'", 'bad'),
    ('null', null),
  ]);
  out('email.isValid', [
    email.validate('dev@example.com').isValid,
    email.validate('bad').isValid,
    email.validate(null).isValid,
  ]);
  out('email.switch', [
    for (final input in ['dev@example.com', 'bad', null])
      switch (email.validate(input)) {
        ValidationSuccess(:final data) => '+ $data',
        ValidationFailure(:final messages) => '- $input: ${messages.first}',
      },
  ]);
  final named = l.string().email().required().withName('email');
  verdict('email.named', 'email.validate(input)', named, [
    ("'bad'", 'bad'),
    ('null', null),
  ]);
  final text = l.string();
  out('reuse', [
    text.validate('anything').isValid,
    text.email().validate('anything').isValid,
    text.uuid().validate('anything').isValid,
  ]);

  final user = l.schema({
    'email': l.string().email().required(),
    'age': l.int().min(18),
    'profile': l.schema({
      'displayName': l.string().min(2).required(),
    }).required(),
  });
  const okUser = {'email': 'dev@example.com', 'profile': {'displayName': 'Ada'}};
  const badUser = {'email': 'bad', 'age': 12, 'profile': {'displayName': 'x'}};
  verdict('hero', 'user.validate(input)', user, [
    ("{'email': 'dev@example.com', 'profile': {'displayName': 'Ada'}}", okUser),
    ("{'email': 'dev@example.com', 'age': 42, 'profile': {'displayName': 'Ada'}}",
        {'email': 'dev@example.com', 'age': 42, 'profile': {'displayName': 'Ada'}}),
    ("{'email': 'bad', 'age': 12, 'profile': {'displayName': 'x'}}", badUser),
  ]);
  out('user.print', [user.validate(badUser)]);
  out('user.errors', [const JsonEncoder.withIndent('  ').convert(user.validate(badUser).errors)]);
  out('user.getError', [
    user.validate(badUser).getError('email'),
    user.validate(badUser).getError('profile.displayName'),
    user.validate(badUser).getError('profile'),
    user.validate(badUser).getError('age'),
  ]);
  out('user.switch', [
    switch (user.validate(badUser)) {
      ValidationSuccess(:final data) => '+ $data',
      final ValidationFailure f => '- ${f.getError('profile.displayName')}',
    },
  ]);
  out('user.output', [user.validate({...okUser, 'extra': 1})]);
  final typed = user.validateSchema(okUser, fromJson: User.fromJson);
  out('user.fromJson', [
    typed,
    if (typed case ValidationSuccess(:final data)) data.email,
  ]);
  out('user.fromJson.fail', [user.validateSchema(badUser, fromJson: User.fromJson)]);

  // ---- Concepts: validators ---------------------------------------------
  out('chain.messages', [l.string().min(8).contains('@').validate('ab').messages]);
  out('typefail', [l.string().email().validate(42).messages]);
  out('names', [
    l.string().email().validate('bad').messages.first,
    l.string().email().withName('email').validate('bad').messages.first,
    l.schema({'email': l.string().email()}).validate({'email': 'bad'}).errors,
  ]);
  out('required.anywhere', [
    l.string().required().min(3).validate('ab').messages,
    l.string().min(3).required().validate('ab').messages,
  ]);
  out('typed.output', [
    (l.int().required().validate(42) as ValidationSuccess<int>).data.runtimeType,
    (l.list(l.string().required()).required().validate(['a']) as ValidationSuccess<List<String>>).data.runtimeType,
  ]);

  // ---- Concepts: optional by default ------------------------------------
  verdict('optional.email', 'l.string().email().validate(input)', l.string().email(), [
    ('null', null),
    ("'dev@example.com'", 'dev@example.com'),
    ("'bad'", 'bad'),
  ]);
  final optionalSchema = l.schema({
    'email': l.string().email().required(),
    'nickname': l.string().min(2),
  });
  out('optional.schema', [
    optionalSchema.validate({'email': 'dev@example.com'}).isValid,
    optionalSchema.validate({'email': 'dev@example.com', 'nickname': null}).isValid,
    optionalSchema.validate({'email': 'dev@example.com', 'nickname': 'x'}).isValid,
  ]);
  verdict('required.empty', 'l.string().required().validate(input)', l.string().required(), [
    ("''", ''),
    ('null', null),
  ]);

  // ---- Concepts: results, errors, paths ---------------------------------
  final order = l.schema({
    'id': l.string().uuid().required(),
    'items': l.list(l.schema({
      'sku': l.string().required(),
      'qty': l.int().min(1).required(),
    }).required()).required(),
    'address': l.schema({'city': l.string().required()}).required(),
    'scores': l.map(keyValidator: l.string().email().required(), valueValidator: l.int().required()),
  }).custom((data) => (data['items']! as List).isNotEmpty, message: 'order must have at least one item');
  const badOrder = {
    'id': 'nope',
    'items': [{'sku': 'A1', 'qty': 1}, {'sku': 'B2', 'qty': 0}, {'qty': 'two'}],
    'address': {},
    'scores': {'not-an-email': 'x', 'dev@example.com': 7},
  };
  final orderResult = order.validate(badOrder);
  out('order.errors', [const JsonEncoder.withIndent('  ').convert(orderResult.errors)]);
  out('order.issues', [for (final i in orderResult.issues) i]);
  out('order.getErrors', [
    orderResult.getError('items.1.qty'),
    orderResult.getErrors('items.2'),
    orderResult.getError('scores'),
    orderResult.getError('scores.not-an-email'),
    orderResult.getError('address.city'),
    orderResult.getError('address'),
  ]);
  final emptyOrder = order.validate({'id': '123e4567-e89b-12d3-a456-426614174000', 'items': [], 'address': {'city': 'Paris'}});
  out('order.objectLevel', [emptyOrder.errors, emptyOrder.getError('')]);
  out('order.isValid', [orderResult.isValid, orderResult.messages.length]);
  final issue = l.int().min(18).withName('age').validate(12).issues.single;
  out('issue.fields', [issue.code, issue.code.name, issue.path, issue.errorPath, issue.message, issue.params, issue.fieldName]);
  out('issue.toString', [issue]);
  out('issue.code.switch', [
    for (final v in [12, 'x', null])
      switch (l.int().min(18).required().validate(v).issues.first.code) {
        IssueCode.tooSmall => 'too small',
        IssueCode.invalidType => 'wrong type',
        IssueCode.required => 'missing',
        _ => 'other',
      },
  ]);
  out('success.views', [
    l.int().validate(1).errors,
    l.int().validate(1).messages,
    l.int().validate(1).getError(''),
    l.int().validate(1).issues,
  ]);
  out('result.toString', [
    l.string().email().validate('dev@example.com'),
    l.string().email().validate('bad'),
    l.schema({'email': l.string().email()}).validate({'email': 'bad'}),
  ]);
  out('no.shortcircuit', [l.int().min(5).validate('x').messages, l.string().min(8).contains('@').validate('ab').messages]);

  // ---- Concepts: messages ----------------------------------------------
  final emailMsg = l.string().email(message: 'Enter an email address').required(message: 'Email is required');
  verdict('messages.fixed', 'email.validate(input)', emailMsg, [
    ("'dev@example.com'", 'dev@example.com'),
    ("'bad'", 'bad'),
    ('null', null),
  ]);
  out('messages.builder', [
    l.string().min(8, messageBuilder: (issue) => 'at least ${issue.params['min']} characters').validate('ab').messages,
    l.string().min(8, messageBuilder: (issue) => 'at least ${issue.params['min']} characters').withName('password').validate('ab').messages,
    l.string().min(8, messageBuilder: (issue) => '${issue.fieldName}: ${issue.message}').withName('password').validate('ab').messages,
  ]);
  out('messages.precedence', [
    l.string().min(8, message: 'fixed', messageBuilder: (issue) => 'built').validate('ab').messages,
  ]);
  l.messageBuilder = (issue) => switch (issue.code) {
    IssueCode.required => '${issue.fieldName ?? 'Wert'} fehlt',
    IssueCode.invalidEmail => 'keine gültige E-Mail-Adresse',
    _ => issue.message,
  };
  out('messages.global', [
    l.schema({'email': l.string().email().required(), 'age': l.int().min(18)}).validate({'email': 'bad', 'age': 3}).errors,
    l.string().required().validate(null).messages,
    l.string().required(message: 'Pflichtfeld').validate(null).messages,
  ]);
  l.messageBuilder = null;
  out('messages.global.reset', [l.string().required().validate(null).messages]);

  // ---- Concepts: schemas -----------------------------------------------
  final address = l.schema({
    'street': l.string().required(),
    'city': l.string().required(),
    'postcode': l.string().regex(RegExp(r'^\d{5}$')).required(),
  });
  final person = l.schema({
    'name': l.string().required(),
    'home': address.required(),
    'work': address,
  });
  out('person.nested', [
    person.validate({'name': 'Ada', 'home': {'street': '1 Main St', 'city': 'Paris', 'postcode': '12'}}).errors,
    person.validate({'name': 'Ada', 'home': {'street': '1 Main St', 'city': 'Paris', 'postcode': '12'}}).getError('home.postcode'),
  ]);
  final strip = l.schema({'name': l.string().required()});
  out('unknown.strip', [strip.validate({'name': 'Ada', 'role': 'admin'})]);
  out('unknown.passthrough', [strip.passthrough().validate({'name': 'Ada', 'role': 'admin'})]);
  out('unknown.strict', [strip.strict().validate({'name': 'Ada', 'role': 'admin'}), strip.strict().validate({'name': 'Ada', 'role': 'admin'}).getError('role')]);
  verdict('passthrough', "l.schema({'name': l.string().required()}).passthrough().validate(input)", strip.passthrough(), [
    ("{'name': 'Ada', 'role': 'admin'}", {'name': 'Ada', 'role': 'admin'}),
    ("{'role': 'admin'}", {'role': 'admin'}),
  ]);
  verdict('strict', "l.schema({'name': l.string().required()}).strict().validate(input)", strip.strict(), [
    ("{'name': 'Ada'}", {'name': 'Ada'}),
    ("{'name': 'Ada', 'role': 'admin'}", {'name': 'Ada', 'role': 'admin'}),
  ]);
  final dateRange = l.schema({
    'start': l.string().dateTime().required(),
    'end': l.string().dateTime().required(),
  }).custom(endAfterStart, message: 'end must be after start');
  verdict('schema.custom', 'dateRange.validate(input)', dateRange, [
    ("{'start': '2026-01-01', 'end': '2026-02-01'}", {'start': '2026-01-01', 'end': '2026-02-01'}),
    ("{'start': '2026-02-01', 'end': '2026-01-01'}", {'start': '2026-02-01', 'end': '2026-01-01'}),
    ("{'start': 'yesterday', 'end': '2026-01-01'}", {'start': 'yesterday', 'end': '2026-01-01'}),
  ]);
  out('schema.custom.getError', [dateRange.validate({'start': '2026-02-01', 'end': '2026-01-01'}).getError('')]);
  late final SchemaValidator<Map<String, Object?>?> node;
  node = l.schema({
    'value': l.string().required(),
    'children': l.list(forwardRef(() => node.required())),
  });
  verdict('node', 'node.validate(input)', node, [
    ("{'value': 'root', 'children': [{'value': 'leaf'}]}", {'value': 'root', 'children': [{'value': 'leaf'}]}),
    ("{'value': 'root', 'children': [{'value': 'a', 'children': [{'value': 1}]}]}",
        {'value': 'root', 'children': [{'value': 'a', 'children': [{'value': 1}]}]}),
  ]);
  out('node.getError', [node.validate({'value': 'root', 'children': [{'value': 'a', 'children': [{'value': 1}]}]}).getError('children.0.children.0.value')]);
  late final SchemaValidator<Map<String, Object?>?> author;
  late final SchemaValidator<Map<String, Object?>?> post;
  author = l.schema({'name': l.string().required(), 'posts': l.list(forwardRef(() => post.required()))});
  post = l.schema({'title': l.string().required(), 'author': forwardRef(() => author)});
  out('mutual', [author.validate({'name': 'Ada', 'posts': [{'title': 'Hi', 'author': {'name': 7}}]}).errors]);
  out('schema.notmap', [l.schema({'a': l.int()}).validate('x').messages, l.schema({'a': l.int()}, message: 'send an object').validate('x').messages]);
  out('schema.nested.notmap', [l.schema({'profile': l.schema({'a': l.int()}).required()}).validate({'profile': 1}).errors]);
  out('fromJson.throws', [
    l.schema({'email': l.string().required()}).validateSchema({'email': 'x'}, fromJson: (json) => throw StateError('boom')),
    l.schema({'email': l.string().required()}).validateSchema(null, fromJson: User.fromJson),
  ]);

  // ---- Concepts: max depth ---------------------------------------------
  Object deep(int n) => n == 0 ? {'value': 'leaf'} : {'value': 'n$n', 'children': [deep(n - 1)]};
  out('depth.default', [l.maxDepth, node.validate(deep(100)).isValid]);
  l.maxDepth = 4;
  final tooDeep = node.validate(deep(5));
  out('depth.small', [tooDeep, tooDeep.issues.single.params]);
  verdict('maxDepth', 'node.validate(input) with l.maxDepth = 4', node, [
    ('deep(1)', deep(1)),
    ('deep(5)', deep(5)),
  ]);
  l.maxDepth = ValidatorFactory.defaultMaxDepth;
  out('depth.reset', [l.maxDepth]);

  // ---- Concepts: custom validators --------------------------------------
  final evenNumber = l.int().custom(isEven, message: 'must be even');
  verdict('custom', 'evenNumber.validate(input)', evenNumber, [
    ('4', 4),
    ('3', 3),
    ('null', null),
    ("'4'", '4'),
  ]);
  out('custom.default', [l.int().custom(isEven).validate(3).messages, l.int().custom((v) => throw StateError('x')).validate(3).messages]);
  final signUp = l.schema({
    'password': l.string().min(8).required(),
    'confirm': l.string().customWithSchema(matchesPassword, message: 'Passwords must match').required(),
  });
  verdict('signUp', 'signUp.validate(input)', signUp, [
    ("{'password': 'hunter2hunter2', 'confirm': 'hunter2hunter2'}", {'password': 'hunter2hunter2', 'confirm': 'hunter2hunter2'}),
    ("{'password': 'hunter2hunter2', 'confirm': 'nope'}", {'password': 'hunter2hunter2', 'confirm': 'nope'}),
    ("{'password': 'hunter2hunter2'}", {'password': 'hunter2hunter2'}),
  ]);
  final account = l.schema({
    'accountType': l.oneOf(['personal', 'business']).customWithSchema(phoneForBusiness, message: 'A business account needs a phone number').required(),
    'phone': l.string(),
  });
  verdict('account', 'account.validate(input)', account, [
    ("{'accountType': 'personal'}", {'accountType': 'personal'}),
    ("{'accountType': 'business', 'phone': '+44 20 7946 0958'}", {'accountType': 'business', 'phone': '+44 20 7946 0958'}),
    ("{'accountType': 'business'}", {'accountType': 'business'}),
  ]);
  final rooted = l.schema({
    'currency': l.string().required(),
    'lines': l.list(l.schema({
      'amount': l.num().required(),
      'currency': l.string().customWithSchema((value, data) => value == data.root['currency'], message: 'line currency must match the order currency').required(),
    }).required()),
  });
  out('schemaData.root', [rooted.validate({'currency': 'EUR', 'lines': [{'amount': 1, 'currency': 'EUR'}, {'amount': 2, 'currency': 'USD'}]}).errors]);
  out('customWithSchema.outside', [l.string().customWithSchema((v, data) => data.isEmpty).validate('x').isValid]);

  // ---- Reference: types -------------------------------------------------
  verdict('type.string', 'name.validate(input)', l.string(), [("'Ada'", 'Ada'), ('null', null), ('42', 42)]);
  verdict('type.int', 'count.validate(input)', l.int(), [('42', 42), ('42.0', 42.0), ("'42'", '42')]);
  verdict('type.double', 'ratio.validate(input)', l.double(), [('0.75', 0.75), ('42', 42), ('double.nan', double.nan)]);
  verdict('type.num', 'amount.validate(input)', l.num(), [('42', 42), ('4.2', 4.2), ("'1'", '1')]);
  verdict('type.bool', 'flag.validate(input)', l.bool(), [('true', true), ('false', false), ("'true'", 'true')]);
  verdict('type.list', 'tags.validate(input)', l.list(l.string().required()), [
    ("['a', 'b']", ['a', 'b']),
    ('[]', []),
    ("['a', 1, null]", ['a', 1, null]),
    ("'a'", 'a'),
  ]);
  out('type.list.nullable', [l.list(l.int()).validate([1, null]), l.list(l.int().required()).validate([1, null])]);
  verdict('type.map', 'scores.validate(input)', l.map(keyValidator: l.string().email().required(), valueValidator: l.int().required()), [
    ("{'dev@example.com': 10}", {'dev@example.com': 10}),
    ("{'not-an-email': 'x'}", {'not-an-email': 'x'}),
    ('[]', []),
  ]);
  out('type.map.errors', [l.map(keyValidator: l.string().email().required(), valueValidator: l.int().required()).validate({'not-an-email': 'x'}).errors]);
  out('type.map.plain', [l.map<String, int>().validate({'a': 1}), l.map<String, int>().validate({'a': 'x'}).errors]);
  final schemaRef = l.schema({'email': l.string().email().required(), 'age': l.int().min(18)});
  verdict('type.schema', 'user.validate(input)', schemaRef, [
    ("{'email': 'dev@example.com'}", {'email': 'dev@example.com'}),
    ("{'email': 'dev@example.com', 'age': 30, 'extra': true}", {'email': 'dev@example.com', 'age': 30, 'extra': true}),
    ("{'email': 'bad', 'age': 12}", {'email': 'bad', 'age': 12}),
    ("{'age': 30}", {'age': 30}),
    ("'not a map'", 'not a map'),
  ]);
  out('type.schema.output', [schemaRef.validate({'email': 'dev@example.com', 'age': 30, 'extra': true})]);
  final idOrEmail = l.union([l.int().min(1), l.string().email()]);
  verdict('type.union', 'idOrEmail.validate(input)', idOrEmail, [
    ('42', 42),
    ("'dev@example.com'", 'dev@example.com'),
    ("'bad'", 'bad'),
    ('0', 0),
    ('null', null),
  ]);
  final unionIssue = idOrEmail.validate('bad').issues.single;
  out('type.union.issue', [unionIssue.code, for (final option in unionIssue.params['issues'] as List) option]);
  final role = l.oneOf(['admin', 'member']);
  verdict('type.oneOf', 'role.validate(input)', role, [
    ("'admin'", 'admin'),
    ("'owner'", 'owner'),
    ("'Admin'", 'Admin'),
    ('null', null),
  ]);
  out('type.oneOf.output', [l.oneOf([1, 2]).validate(1.0), l.oneOf(['admin', 'member']).required().validate('admin')]);
  verdict('type.file', 'upload.validate(input)', l.file(), [
    ('Uint8List.fromList([1, 2, 3])', Uint8List.fromList([1, 2, 3])),
    ('<int>[1, 2, 3]', <int>[1, 2, 3]),
    ('null', null),
    ("'avatar.png'", 'avatar.png'),
    ("{'path': 'avatar.png'}", {'path': 'avatar.png'}),
  ]);
  out('type.file.accept', [l.file(accept: (value) => value is User).validate(const User(email: 'x')).isValid]);
  verdict('type.any', 'payload.validate(input)', l.any(), [('42', 42), ('null', null), ("{'k': 'v'}", {'k': 'v'})]);
  out('type.any.required', [l.any().required().validate(null).messages]);
  verdict('type.nullValue', 'cleared.validate(input)', l.nullValue(), [('null', null), ('1', 1)]);

  // ---- Reference: modifiers ---------------------------------------------
  verdict('mod.required', 'name.validate(input)', l.string().required(), [("'Ada'", 'Ada'), ("''", ''), ('null', null)]);
  verdict('mod.withName', 'l.string().email().withName(\'email\').validate(input)', l.string().email().withName('email'), [("'bad'", 'bad')]);
  out('mod.withName.schema', [l.schema({'contact': l.string().email().withName('email')}).validate({'contact': 'bad'}).errors]);

  // ---- Reference: string modifiers --------------------------------------
  verdict('str.min', 'password.validate(input)', l.string().min(8), [("'hunter2hunter2'", 'hunter2hunter2'), ("'abc'", 'abc')]);
  verdict('str.max', 'code.validate(input)', l.string().max(3), [("'abc'", 'abc'), ("'abcd'", 'abcd')]);
  verdict('str.length', 'iso.validate(input)', l.string().length(3), [("'abc'", 'abc'), ("'abcd'", 'abcd')]);
  verdict('str.contains', 'handle.validate(input)', l.string().contains('@'), [("'dev@example.com'", 'dev@example.com'), ("'a'", 'a')]);
  verdict('str.startsWith', 'phone.validate(input)', l.string().startsWith('+'), [("'+44 20 7946 0958'", '+44 20 7946 0958'), ("'020 7946 0958'", '020 7946 0958')]);
  verdict('str.endsWith', 'path.validate(input)', l.string().endsWith('.dart'), [("'main.dart'", 'main.dart'), ("'main.js'", 'main.js')]);
  verdict('str.regex', 'slug.validate(input)', l.string().regex(RegExp(r'^[a-z0-9-]+$')), [("'hello-world'", 'hello-world'), ("'Hello World'", 'Hello World')]);
  out('str.regex.flags', [
    l.string().regex(RegExp(r'^[a-z]+$', caseSensitive: false)).validate('Hello').isValid,
    l.string().regex(RegExp(r'[0-9]')).validate('abc1def').isValid,
  ]);
  verdict('str.email', 'email.validate(input)', l.string().email(), [("'dev@example.com'", 'dev@example.com'), ("'user@localhost'", 'user@localhost'), ("'bad'", 'bad')]);
  verdict('str.uri', 'link.validate(input)', l.string().uri(allowedSchemes: ['https']), [
    ("'https://example.com'", 'https://example.com'),
    ("'HTTPS://example.com'", 'HTTPS://example.com'),
    ("'mailto:dev@example.com'", 'mailto:dev@example.com'),
    ("'not a uri at all'", 'not a uri at all'),
  ]);
  out('str.uri.plain', [l.string().uri().validate('mailto:dev@example.com').isValid, l.string().uri().validate('example.com').isValid]);
  verdict('str.url', 'avatar.validate(input)', l.string().url(), [
    ("'https://example.com/docs'", 'https://example.com/docs'),
    ("'example.com'", 'example.com'),
    ("'mailto:dev@example.com'", 'mailto:dev@example.com'),
  ]);
  out('str.url.schemes', [l.string().url(allowedSchemes: ['https']).validate('http://example.com').messages]);
  verdict('str.ip', 'v4.validate(input)', l.string().ip(version: IpVersion.v4), [
    ("'192.168.0.1'", '192.168.0.1'),
    ("'::1'", '::1'),
    ("'999.1.1.1'", '999.1.1.1'),
  ]);
  out('str.ip.any', [l.string().ip().validate('::1').isValid, l.string().ip().validate('999.1.1.1').messages, l.string().ip(version: IpVersion.v6).validate('192.168.0.1').messages]);
  verdict('str.uuid', 'id.validate(input)', l.string().uuid(), [("'123e4567-e89b-12d3-a456-426614174000'", '123e4567-e89b-12d3-a456-426614174000'), ("'123'", '123')]);
  verdict('str.cuid', 'id.validate(input)', l.string().cuid(), [("'cjld2cjxh0000qzrmn831i7rn'", 'cjld2cjxh0000qzrmn831i7rn'), ("'xcjld2cjxh0000qzrmn831i7rn'", 'xcjld2cjxh0000qzrmn831i7rn'), ("'123'", '123')]);
  verdict('str.cuid2', 'id.validate(input)', l.string().cuid2(), [("'tz4a98xxat96iws9zmbrgj3a'", 'tz4a98xxat96iws9zmbrgj3a'), ("'a'", 'a'), ("'123'", '123')]);
  verdict('str.dateTime', 'date.validate(input)', l.string().dateTime(), [
    ("'2026-10-04'", '2026-10-04'),
    ("'2026-10-04T10:15:00Z'", '2026-10-04T10:15:00Z'),
    ("'2023-02-30'", '2023-02-30'),
    ("'20261004'", '20261004'),
    ("'yesterday'", 'yesterday'),
  ]);
  verdict('str.emoji', 'reaction.validate(input)', l.string().emoji(), [("'🎉'", '🎉'), ("'👨‍👩‍👧'", '👨‍👩‍👧'), ("'→'", '→'), ("'a'", 'a')]);

  // ---- Reference: number modifiers --------------------------------------
  verdict('num.min', 'age.validate(input)', l.int().min(18), [('18', 18), ('17', 17)]);
  verdict('num.min.double', 'ratio.validate(input)', l.double().min(0.5), [('0.75', 0.75), ('0.25', 0.25)]);
  verdict('num.max', 'age.validate(input)', l.int().max(100), [('100', 100), ('101', 101)]);
  verdict('num.max.double', 'ratio.validate(input)', l.double().max(1.5), [('1.5', 1.5), ('2.0', 2.0)]);
  verdict('num.finite', 'price.validate(input)', l.double().finite(), [('19.99', 19.99), ('double.nan', double.nan), ('double.infinity', double.infinity)]);
  out('num.finite.without', [l.double().validate(double.nan).isValid, l.num().validate(double.infinity).isValid]);

  // ---- Errors reference: default messages, generated by running ----------
  final defaults = <String, ValidationResult<Object?>>{
    'l.string()': l.string().validate(1),
    'l.int()': l.int().validate('1'),
    'l.double()': l.double().validate(1),
    'l.num()': l.num().validate('1'),
    'l.bool()': l.bool().validate('true'),
    'l.list(...)': l.list(l.any()).validate('x'),
    'l.map()': l.map().validate('x'),
    'l.schema({...})': l.schema({}).validate('x'),
    'l.file()': l.file().validate('x'),
    'l.nullValue()': l.nullValue().validate(1),
    'l.union([...])': l.union([l.int()]).validate('x'),
    "l.oneOf(['a', 'b'])": l.oneOf(['a', 'b']).validate('c'),
    '.required()': l.string().required().validate(null),
    '.custom(f)': l.int().custom((v) => false).validate(1),
    '.customWithSchema(f)': l.int().customWithSchema((v, d) => false).validate(1),
    '.min(8) on a string': l.string().min(8).validate('a'),
    '.max(3) on a string': l.string().max(3).validate('abcd'),
    '.length(3)': l.string().length(3).validate('ab'),
    ".contains('@')": l.string().contains('@').validate('a'),
    ".startsWith('+')": l.string().startsWith('+').validate('a'),
    ".endsWith('.dart')": l.string().endsWith('.dart').validate('a'),
    r".regex(RegExp(r'^\d+$'))": l.string().regex(RegExp(r'^\d+$')).validate('a'),
    '.email()': l.string().email().validate('a'),
    '.uri()': l.string().uri().validate('a'),
    ".uri(allowedSchemes: ['https'])": l.string().uri(allowedSchemes: ['https']).validate('a'),
    '.url()': l.string().url().validate('a'),
    ".url(allowedSchemes: ['http', 'https'])": l.string().url(allowedSchemes: ['http', 'https']).validate('a'),
    '.ip()': l.string().ip().validate('a'),
    '.ip(version: IpVersion.v4)': l.string().ip(version: IpVersion.v4).validate('a'),
    '.uuid()': l.string().uuid().validate('a'),
    '.cuid()': l.string().cuid().validate('a'),
    '.cuid2()': l.string().cuid2().validate('1'),
    '.dateTime()': l.string().dateTime().validate('a'),
    '.emoji()': l.string().emoji().validate('a'),
    '.min(18) on a number': l.int().min(18).validate(1),
    '.max(100) on a number': l.int().max(100).validate(101),
    '.finite()': l.double().finite().validate(double.nan),
    '.strict() unknown key': l.schema({}).strict().validate({'role': 1}),
    'map key validator': l.map(keyValidator: l.string().email().required()).validate({'x': 1}),
    'l.maxDepth exceeded': (() { l.maxDepth = 1; final r = l.list(l.list(l.list(l.any()))).validate([[[]]]); l.maxDepth = ValidatorFactory.defaultMaxDepth; return r; })(),
    'fromJson threw': l.schema({}).validateSchema({}, fromJson: (j) => throw StateError('x')),
  };
  verdicts['defaults'] = {
    'title': 'default messages',
    'rows': [
      for (final e in defaults.entries)
        if (e.value.issues.isEmpty)
          throw StateError('defaults: ${e.key} passed; it is meant to fail')
        else
          {'validation': e.key, 'code': e.value.issues.first.code.name, 'message': e.value.issues.first.message},
    ],
  };

  final file = File('../../src/data/verdicts.json');
  file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert({
    'generatedBy': 'website/scripts/verdicts/bin/verdicts.dart',
    'dart': Platform.version.split(' ').first,
    'verdicts': verdicts,
    'outputs': outputs,
  }));
  stdout.writeln('wrote ${file.path}: ${verdicts.length} verdicts, ${outputs.length} outputs');
}
