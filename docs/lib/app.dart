import 'package:docs/pages/home.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';

// A simple [StatelessComponent] with a [build] method.
@client
class App extends StatelessComponent {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield ProviderScope(
      child: div(classes: 'main', [
        Router(
          routes: [
            Route(
              path: '/',
              title: 'Luthor',
              builder: (context, state) => const Home(),
            ),
          ],
        ),
      ]),
    );
  }
}
