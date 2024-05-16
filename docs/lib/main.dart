import 'package:docs/app.dart';
import 'package:docs/jaspr_options.dart';
import 'package:jaspr/server.dart';

void main() {
  Jaspr.initializeApp(
    options: defaultJasprOptions,
  );

  runApp(
    Document(
      title: 'docs',
      head: [
        link(href: 'styles.css', rel: 'stylesheet'),
      ],
      body: App(),
    ),
  );
}
