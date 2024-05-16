import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'title_provider.g.dart';

@riverpod
String title(TitleRef ref) {
  return 'Luthor';
}
