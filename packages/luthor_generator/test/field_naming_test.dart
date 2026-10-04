import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given a model whose annotations sit on fields', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_fieldAnnotatedSource)).output;
    });

    test('Then the field JsonKey name is the schema key', () {
      expectOutputContains(output, 'fullName: "full_name",');
    });

    test('Then field validators are applied', () {
      expectOutputContains(
        output,
        'FieldAnnotatedSchemaKeys.fullName: l.string().min(2).required(),',
      );
      expectOutputContains(
        output,
        'FieldAnnotatedSchemaKeys.email: l.string().email().required(),',
      );
    });

    test(
      'When the validate function runs then only the bad email fails',
      () async {
        final results = await evaluateGenerated(_fieldAnnotatedSource, {
          'result':
              r'''$FieldAnnotatedValidate({'full_name': 'Al', 'email': 'nope'})''',
        });

        expect(results['result'], {
          'email': ['email must be a valid email address'],
        });
      },
    );
  });

  group('Given models with a json_serializable fieldRename', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_fieldRenameSource)).output;
    });

    test('Then snake case keys are generated', () {
      expectOutputContains(
        output,
        'const SnakeSchemaKeys = (firstName: "first_name", homeURL: "home_u_r_l", renamed: "custom", owner: "owner");',
      );
    });

    test('Then kebab, pascal and screaming snake keys are generated', () {
      expectOutputContains(output, 'firstName: "first-name"');
      expectOutputContains(output, 'firstName: "FirstName"');
      expectOutputContains(output, 'firstName: "FIRST_NAME"');
    });

    test('Then nested error keys use the nested class rename', () {
      expectOutputContains(
        output,
        r'''owner: ($key: "owner", firstName: "owner.first_name")''',
      );
    });
  });

  group('Given a freezed model with fieldRename on its factory', () {
    test(
      'When the builder generates the schema then keys are renamed',
      () async {
        final generation = await generateSharedPart(_freezedRenameSource);

        expectOutputContains(
          generation.output,
          'const IssueSchemaKeys = (firstName: "first_name");',
        );
      },
    );
  });

  group('Given dart_mappable models with keys and a case style', () {
    late String output;

    setUp(() async {
      output = (await generateSharedPart(_mappableSource)).output;
    });

    test('Then MappableField keys on fields and parameters are used', () {
      expectOutputContains(
        output,
        'const MapUserSchemaKeys = (userName: "user_name", nickName: "nick");',
      );
    });

    test('Then the class case style renames keys', () {
      expectOutputContains(
        output,
        'const MapSnakeSchemaKeys = (firstName: "first_name", lastName: "surname");',
      );
      expectOutputContains(
        output,
        'const MapParamSchemaKeys = (firstName: "first-name");',
      );
    });
  });

  group('Given a model built from super parameters', () {
    test(
      'When the builder generates the schema then base field annotations apply',
      () async {
        final generation = await generateSharedPart(_superParameterSource);

        expectOutputContains(generation.output, 'id: "ID",');
        expectOutputContains(
          generation.output,
          'ChildSchemaKeys.id: l.string().uuid().required(),',
        );
      },
    );
  });
}

const _fieldAnnotatedSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
@JsonSerializable()
class FieldAnnotated {
  @JsonKey(name: 'full_name')
  @HasMin(2)
  final String fullName;

  @isEmail
  final String email;

  const FieldAnnotated({required this.fullName, required this.email});

  factory FieldAnnotated.fromJson(Map<String, dynamic> json) => FieldAnnotated(
    fullName: json['full_name'] as String,
    email: json['email'] as String,
  );

  Map<String, dynamic> toJson() => {'full_name': fullName, 'email': email};
}
''';

const _fieldRenameSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
@JsonSerializable(fieldRename: FieldRename.snake)
class Snake {
  final String firstName;
  final String homeURL;
  @JsonKey(name: 'custom')
  final String renamed;
  final Owner? owner;

  const Snake({
    required this.firstName,
    required this.homeURL,
    required this.renamed,
    this.owner,
  });

  factory Snake.fromJson(Map<String, dynamic> json) => throw UnimplementedError();

  Map<String, dynamic> toJson() => {};
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Owner {
  final String firstName;

  const Owner({required this.firstName});

  factory Owner.fromJson(Map<String, dynamic> json) => throw UnimplementedError();
}

@luthor
@JsonSerializable(fieldRename: FieldRename.kebab)
class Kebab {
  final String firstName;

  const Kebab({required this.firstName});

  factory Kebab.fromJson(Map<String, dynamic> json) => throw UnimplementedError();

  Map<String, dynamic> toJson() => {};
}

@luthor
@JsonSerializable(fieldRename: FieldRename.pascal)
class Pascal {
  final String firstName;

  const Pascal({required this.firstName});

  factory Pascal.fromJson(Map<String, dynamic> json) => throw UnimplementedError();

  Map<String, dynamic> toJson() => {};
}

@luthor
@JsonSerializable(fieldRename: FieldRename.screamingSnake)
class Screaming {
  final String firstName;

  const Screaming({required this.firstName});

  factory Screaming.fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();

  Map<String, dynamic> toJson() => {};
}
''';

const _freezedRenameSource = r'''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
@freezed
abstract class Issue with _$Issue {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Issue({required String firstName}) = _Issue;

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
}
''';

const _mappableSource = '''
import 'package:dart_mappable/dart_mappable.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
@MappableClass()
class MapUser {
  @MappableField(key: 'user_name')
  final String userName;
  final String nickName;

  const MapUser({
    required this.userName,
    @MappableField(key: 'nick') required this.nickName,
  });
}

@luthor
@MappableClass(caseStyle: CaseStyle.snakeCase)
class MapSnake {
  final String firstName;
  @MappableField(key: 'surname')
  final String lastName;

  const MapSnake({required this.firstName, required this.lastName});
}

@luthor
@MappableClass(caseStyle: CaseStyle(tail: TextTransform.lowerCase, separator: '-'))
class MapParam {
  final String firstName;

  const MapParam({required this.firstName});
}
''';

const _superParameterSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

class Base {
  @JsonKey(name: 'ID')
  @isUuid
  final String id;

  const Base({required this.id});
}

@luthor
class Child extends Base {
  const Child({required super.id});

  factory Child.fromJson(Map<String, dynamic> json) =>
      Child(id: json['ID'] as String);

  Map<String, dynamic> toJson() => {'ID': id};
}
''';
