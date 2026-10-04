import 'package:test/test.dart';

import 'utils/generator_test_utils.dart';

void main() {
  group('Given a model that recurses through nested collections', () {
    group('When the validate functions run', () {
      late Map<String, Object?> results;

      setUpAll(() async {
        results = await evaluateGenerated(_nestedCollectionsSource, {
          'grid': r'''$GridValidate({'rows': [[{'rows': []}]]})''',
          'invalidGrid': r'''$GridValidate({'rows': 'nope'})''',
          'bucket':
              r'''$BucketValidate({'groups': {'a': [{'groups': null}]}})''',
        });
      });

      test('Then a list of lists of the model validates', () {
        expect(results['grid'], 'success');
      });

      test('Then an invalid recursive field reports an error', () {
        expect(results['invalidGrid'], isA<Map<String, Object?>>());
      });

      test('Then a map of lists of the model validates', () {
        expect(results['bucket'], 'success');
      });
    });

    test('When generated code is analyzed then it compiles', () async {
      await expectGeneratedCodeCompiles(_nestedCollectionsSource);
    });
  });

  group('Given two models that reference each other', () {
    group('When the validate functions run', () {
      late Map<String, Object?> results;

      setUpAll(() async {
        results = await evaluateGenerated(_mutualSource, {
          'author':
              r'''$AuthorValidate({'name': 'A', 'books': [{'title': 'B', 'author': {'name': 'C'}}]})''',
          'org':
              r'''$OrgValidate({'dept': {'staff': [{'dept': {'staff': []}}]}})''',
        });
      });

      test('Then annotated mutual recursion validates', () {
        expect(results['author'], 'success');
      });

      test('Then auto-generated mutual recursion validates', () {
        expect(results['org'], 'success');
      });
    });
  });

  group('Given a recursive field annotated with @luthorForwardRef', () {
    group('When the builder generates the schema', () {
      late String annotated;
      late String plain;

      setUp(() async {
        annotated = (await generateSharedPart(
          _forwardRefSource.replaceFirst('/*ref*/', '@luthorForwardRef'),
        )).output;
        plain = (await generateSharedPart(
          _forwardRefSource.replaceFirst('/*ref*/', ''),
        )).output;
      });

      test('Then the annotation changes nothing', () {
        expect(annotated, plain);
      });

      test('Then the nested reference is still a forward reference', () {
        expectOutputContains(
          plain,
          r'''l.list(validators: [forwardRef(() => $TreeSchema.required())])''',
        );
      });
    });
  });
}

const _nestedCollectionsSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Grid {
  final List<List<Grid>> rows;

  const Grid({required this.rows});

  Map<String, dynamic> toJson() => {'rows': rows};

  factory Grid.fromJson(Map<String, dynamic> json) => Grid(
    rows: (json['rows'] as List<dynamic>)
        .map((row) => (row as List<dynamic>)
            .map((cell) => Grid.fromJson(cell as Map<String, dynamic>))
            .toList())
        .toList(),
  );
}

@luthor
class Bucket {
  final Map<String, List<Bucket>>? groups;

  const Bucket({this.groups});

  Map<String, dynamic> toJson() => {'groups': groups};

  factory Bucket.fromJson(Map<String, dynamic> json) => Bucket(
    groups: (json['groups'] as Map<String, dynamic>?)?.map(
      (key, value) => MapEntry(
        key,
        (value as List<dynamic>)
            .map((item) => Bucket.fromJson(item as Map<String, dynamic>))
            .toList(),
      ),
    ),
  );
}
''';

const _mutualSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Author {
  final String name;
  final List<Book>? books;

  const Author({required this.name, this.books});

  Map<String, dynamic> toJson() => {'name': name, 'books': books};

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    name: json['name'] as String,
    books: (json['books'] as List<dynamic>?)
        ?.map((book) => Book.fromJson(book as Map<String, dynamic>))
        .toList(),
  );
}

@luthor
class Book {
  final String title;
  final Author? author;

  const Book({required this.title, this.author});

  Map<String, dynamic> toJson() => {'title': title, 'author': author};

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    title: json['title'] as String,
    author: json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>),
  );
}

@luthor
class Org {
  final Dept dept;

  const Org({required this.dept});

  Map<String, dynamic> toJson() => {'dept': dept};

  factory Org.fromJson(Map<String, dynamic> json) =>
      Org(dept: Dept.fromJson(json['dept'] as Map<String, dynamic>));
}

class Dept {
  final List<Emp> staff;

  const Dept({required this.staff});

  Map<String, dynamic> toJson() => {'staff': staff};

  factory Dept.fromJson(Map<String, dynamic> json) => Dept(
    staff: (json['staff'] as List<dynamic>)
        .map((emp) => Emp.fromJson(emp as Map<String, dynamic>))
        .toList(),
  );
}

class Emp {
  final Dept? dept;

  const Emp({this.dept});

  Map<String, dynamic> toJson() => {'dept': dept};

  factory Emp.fromJson(Map<String, dynamic> json) => Emp(
    dept: json['dept'] == null
        ? null
        : Dept.fromJson(json['dept'] as Map<String, dynamic>),
  );
}
''';

const _forwardRefSource = '''
import 'package:luthor/luthor.dart';

part 'profile.g.dart';

@luthor
class Tree {
  final List<Tree> children;

  const Tree({/*ref*/ required this.children});

  Map<String, dynamic> toJson() => {'children': children};

  factory Tree.fromJson(Map<String, dynamic> json) => Tree(
    children: (json['children'] as List<dynamic>)
        .map((child) => Tree.fromJson(child as Map<String, dynamic>))
        .toList(),
  );
}
''';
