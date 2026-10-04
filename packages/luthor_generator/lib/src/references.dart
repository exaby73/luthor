import 'package:analyzer/dart/element/element.dart';

final class LibraryReferences {
  LibraryReferences(this.library);

  final LibraryElement library;

  late final List<LibraryImport> _imports = [
    for (final fragment in library.fragments) ...fragment.libraryImports,
  ];

  late final List<PrefixElement> _prefixes = {
    for (final import in _imports)
      if (import.prefix?.element case final prefix?) prefix,
  }.toList();

  String? nameOf(Element element) {
    final name = element.name;
    if (name == null) return null;
    if (_isSame(library.firstFragment.scope.lookup(name).getter, element)) {
      return name;
    }
    for (final prefix in _prefixes) {
      if (_isSame(prefix.scope.lookup(name).getter, element)) {
        return '${prefix.name}.$name';
      }
    }
    return null;
  }

  String? functionReference(ExecutableElement function) {
    final enclosing = function.enclosingElement;
    if (enclosing is LibraryElement) return nameOf(function);
    if (enclosing is InstanceElement && function.isStatic) {
      final owner = nameOf(enclosing);
      return owner == null ? null : '$owner.${function.name}';
    }
    return null;
  }

  String? publicSchemaReference(ClassElement model, String schemaName) {
    final declaring = model.library;
    if (declaring == library) return schemaName;
    for (final import in _imports) {
      final imported = import.importedLibrary;
      if (imported == null || !_allows(import.combinators, schemaName)) {
        continue;
      }
      if (!_exports(imported, declaring, schemaName, {})) continue;
      final prefix = import.prefix?.element.name;
      return prefix == null ? schemaName : '$prefix.$schemaName';
    }
    return null;
  }

  bool _isSame(Element? found, Element expected) {
    return found != null && found.baseElement == expected.baseElement;
  }

  bool _exports(
    LibraryElement from,
    LibraryElement target,
    String name,
    Set<LibraryElement> visited,
  ) {
    if (from == target) return true;
    if (!visited.add(from)) return false;
    for (final fragment in from.fragments) {
      for (final export in fragment.libraryExports) {
        final exported = export.exportedLibrary;
        if (exported != null &&
            _allows(export.combinators, name) &&
            _exports(exported, target, name, visited)) {
          return true;
        }
      }
    }
    return false;
  }

  bool _allows(List<NamespaceCombinator> combinators, String name) {
    for (final combinator in combinators) {
      if (combinator is ShowElementCombinator &&
          !combinator.shownNames.contains(name)) {
        return false;
      }
      if (combinator is HideElementCombinator &&
          combinator.hiddenNames.contains(name)) {
        return false;
      }
    }
    return true;
  }
}
