const validProfileSource = '''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Profile {
  final String email;
  final int age;
  final String status;
  final String? nickname;
  final String displayName;

  const Profile({
    @JsonKey(name: 'email_address') @isEmail required this.email,
    @HasMin(18) required this.age,
    @Default('active') this.status = 'active',
    this.nickname,
    @JsonKey(name: 'display"name') required this.displayName,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    email: json['email_address'] as String,
    age: json['age'] as int,
    status: json['status'] as String? ?? 'active',
    nickname: json['nickname'] as String?,
    displayName: json['display"name'] as String,
  );

  Map<String, dynamic> toJson() => {
    'email_address': email,
    'age': age,
    'status': status,
    'nickname': nickname,
    'display"name': displayName,
  };
}
''';

const allValidatorsSource = r'''
import 'dart:io';

import 'package:luthor/luthor.dart';

part 'profile.g.dart';

bool isCustomValue(Object? value) => value == 'custom';

class FieldsValidators {
  static bool matchesCustom(Object? value, Map<String, Object?> data) {
    return data['custom'] == value;
  }
}

@luthor
class Fields {
  final String email;
  final DateTime createdAt;
  final String fixed;
  final String title;
  final String shortText;
  final String uri;
  final String url;
  final String path;
  final String prefix;
  final String suffix;
  final String included;
  final String ipv4;
  final String uuid;
  final String cuid;
  final String cuid2;
  final String emoji;
  final int count;
  final double ratio;
  final num amount;
  final bool enabled;
  final dynamic anything;
  final Null nothing;
  final File upload;
  final List<String> tags;
  final Map<String, int> scores;
  final String custom;
  final String schemaCustom;

  const Fields({
    @IsEmail(message: 'can\'t email "user"') required this.email,
    @IsDateTime(message: 'can\'t parse "date"') required this.createdAt,
    @HasLength(3, message: 'can\'t length') required this.fixed,
    @HasMin(2, message: 'can\'t min') required this.title,
    @HasMax(12, message: 'can\'t max') required this.shortText,
    @IsUri(
      allowedSchemes: ['https', 'custom+scheme'],
      message: 'can\'t uri',
    )
    required this.uri,
    @IsUrl(allowedSchemes: ['https'], message: 'can\'t url') required this.url,
    @MatchRegex(r'^foo\d+$', message: 'can\'t match') required this.path,
    @StartsWith('pre"', message: 'can\'t start') required this.prefix,
    @EndsWith('suf\'', message: 'can\'t end') required this.suffix,
    @Contains('mid\\value', message: 'can\'t contain') required this.included,
    @IsIp(version: IpVersion.v4, message: 'can\'t ip') required this.ipv4,
    @IsUuid(message: 'can\'t uuid') required this.uuid,
    @IsCuid(message: 'can\'t cuid') required this.cuid,
    @IsCuid2(message: 'can\'t cuid2') required this.cuid2,
    @IsEmoji(message: 'can\'t emoji') required this.emoji,
    @HasMax(10) @HasMin(1) required this.count,
    @HasMaxDouble(1.5) @HasMinDouble(0.5) required this.ratio,
    @HasMaxNumber(99) @HasMinNumber(0) required this.amount,
    required this.enabled,
    required this.anything,
    required this.nothing,
    @isFile required this.upload,
    required this.tags,
    required this.scores,
    @WithCustomValidator(isCustomValue, message: 'can\'t custom')
    required this.custom,
    @WithSchemaCustomValidator(
      FieldsValidators.matchesCustom,
      message: 'can\'t schema',
    )
    required this.schemaCustom,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    email: json['email'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    fixed: json['fixed'] as String,
    title: json['title'] as String,
    shortText: json['shortText'] as String,
    uri: json['uri'] as String,
    url: json['url'] as String,
    path: json['path'] as String,
    prefix: json['prefix'] as String,
    suffix: json['suffix'] as String,
    included: json['included'] as String,
    ipv4: json['ipv4'] as String,
    uuid: json['uuid'] as String,
    cuid: json['cuid'] as String,
    cuid2: json['cuid2'] as String,
    emoji: json['emoji'] as String,
    count: json['count'] as int,
    ratio: json['ratio'] as double,
    amount: json['amount'] as num,
    enabled: json['enabled'] as bool,
    anything: json['anything'],
    nothing: null,
    upload: File(json['upload'] as String),
    tags: (json['tags'] as List<dynamic>).cast<String>(),
    scores: (json['scores'] as Map<String, dynamic>).cast<String, int>(),
    custom: json['custom'] as String,
    schemaCustom: json['schemaCustom'] as String,
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'createdAt': createdAt.toIso8601String(),
    'fixed': fixed,
    'title': title,
    'shortText': shortText,
    'uri': uri,
    'url': url,
    'path': path,
    'prefix': prefix,
    'suffix': suffix,
    'included': included,
    'ipv4': ipv4,
    'uuid': uuid,
    'cuid': cuid,
    'cuid2': cuid2,
    'emoji': emoji,
    'count': count,
    'ratio': ratio,
    'amount': amount,
    'enabled': enabled,
    'anything': anything,
    'nothing': nothing,
    'upload': upload.path,
    'tags': tags,
    'scores': scores,
    'custom': custom,
    'schemaCustom': schemaCustom,
  };
}
''';

const nestedSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Article {
  final Author author;
  final List<Comment> comments;

  const Article({required this.author, required this.comments});

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    author: Author.fromJson(json['author'] as Map<String, dynamic>),
    comments: (json['comments'] as List<dynamic>)
        .map((comment) => Comment.fromJson(comment as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'author': author.toJson(),
    'comments': comments.map((comment) => comment.toJson()).toList(),
  };
}

class Author {
  final String email;

  const Author({@isEmail required this.email});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(email: json['email'] as String);
  }

  Map<String, dynamic> toJson() => {'email': email};
}

class Comment {
  final String body;

  const Comment({required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(body: json['body'] as String);
  }

  Map<String, dynamic> toJson() => {'body': body};
}
''';

const recursiveSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Node {
  final String name;
  final List<Node>? children;

  const Node({required this.name, this.children});

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      name: json['name'] as String,
      children: (json['children'] as List<dynamic>?)
          ?.map((child) => Node.fromJson(child as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'children': children?.map((child) => child.toJson()).toList(),
  };
}
''';

const mappableSource = '''
import 'package:dart_mappable/dart_mappable.dart';
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@MappableClass()
@luthor
class MappedProfile {
  final String email;

  const MappedProfile({@isEmail required this.email});
}

class MappedProfileMapper {
  static MappedProfile fromMap(Map<String, Object?> map) {
    return MappedProfile(email: map['email']! as String);
  }
}

extension MappedProfileMapperExtension on MappedProfile {
  Map<String, Object?> toMap() => {'email': email};
}
''';

const invalidSource = '''
import 'package:luthor/luthor.dart';

@luthor
void validateMe() {}
''';

const noFromJsonSource = '''
import 'package:luthor/luthor.dart';

@luthor
class MissingFromJson {
  final String value;

  const MissingFromJson({required this.value});
}
''';

const unsupportedFieldSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Container {
  final Unsupported unsupported;

  const Container({required this.unsupported});

  factory Container.fromJson(Map<String, dynamic> json) {
    return Container(unsupported: Unsupported());
  }

  Map<String, dynamic> toJson() => {'unsupported': unsupported};
}

class Unsupported {}
''';
