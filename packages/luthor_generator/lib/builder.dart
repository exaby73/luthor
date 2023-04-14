import 'package:build/build.dart';
import 'package:luthor_generator/generators/luthor_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder luthorBuilder(BuilderOptions options) {
  return PartBuilder([LuthorGenerator()], '.luthor.dart');
}
