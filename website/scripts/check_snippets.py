#!/usr/bin/env python3
"""Analyzes every ```dart block in src/content/docs against the packages in
this repository.

Runtime blocks are analyzed in scripts/verdicts (Dart 3.11). Blocks that use
generated symbols are analyzed in scripts/generated (Dart 3.13), after its
build. Blocks that define a @luthor model are checked to be verbatim copies of
a model under scripts/generated/lib, which the generated excerpts on the site
were built from. Blocks under a "Signature" heading, annotation parameter
lines, lines with `...`, and diff-marked tutorial steps are illustrative and are
listed instead of analyzed.

Earlier blocks on the same page are prepended as context, so a snippet may
refer to a `result` or `user` defined a few paragraphs up.

  website/scripts/check_snippets.py
"""
import os, re, subprocess, sys, pathlib, shutil, textwrap

ROOT = pathlib.Path(__file__).resolve().parent.parent
DOCS = ROOT / 'src' / 'content' / 'docs'
DART311 = os.environ.get('DART311', os.path.expanduser('~/.asdf/installs/flutter/3.41.9-stable/bin/cache/dart-sdk/bin/dart'))
DART313 = os.environ.get('DART313', os.path.expanduser('~/.asdf/installs/flutter/3.47.5-stable/bin/cache/dart-sdk/bin/dart'))

TOKEN = re.compile(r'^(#{2,4}) ([^\n]*)$|^```dart([^\n]*)\n(.*?)^```', re.M | re.S)
PARAM_LINE = re.compile(r'^\s*(@\w+(\([^)]*\))?\s*)*(required\s+)?[A-Za-z_][\w<>?,\s]*?\s+\$?\w+(\s*=\s*[^,;]+)?,\s*(//.*)?$')
DECL = re.compile(r'^(class|enum|abstract class|final class|typedef|late final|bool|String|Object|void|Object\?|int|double|num)\b')

def norm(s): return re.sub(r'\s+', ' ', s).strip()

models_text = norm(''.join(p.read_text() for p in (ROOT/'scripts/generated/lib').glob('*.dart')
                           if not p.name.endswith(('.g.dart', '.freezed.dart', '.mapper.dart'))))

PRELUDE_IMPORTS = """// ignore_for_file: unused_local_variable, unused_element, unnecessary_statements, unused_import, avoid_print, unnecessary_cast, prefer_function_declarations_over_variables, non_constant_identifier_names
import 'dart:typed_data';
import 'package:luthor/luthor.dart';
"""
PRELUDE = """Object? input;
Map<String, Object?> json = {};
void sendTo(Object? o) {}
void save(Object? o) {}
void log(Object? a, [Object? b, Object? c]) {}
String tr(String key) => key;
class XFile { const XFile(); }
bool isXFile(Object value) => value is XFile;
"""
USER_CLASS = """class User {
  const User({required this.email, this.age});
  final String email;
  final int? age;
  factory User.fromJson(Map<String, Object?> json) =>
      User(email: json['email']! as String, age: json['age'] as int?);
}
"""
GEN_IMPORTS = [
  ('Registration', "import 'package:luthor_docs_generated/registration.dart';"),
  ('SignUp', "import 'package:luthor_docs_generated/registration.dart';"),
  ('Node', "import 'package:luthor_docs_generated/node.dart';"),
  ('Ticket', "import 'package:luthor_docs_generated/ticket.dart';"),
]

def split_statements(code):
    """Splits top-level code into statements, tracking brace and paren depth."""
    out, cur, depth, in_str = [], [], 0, None
    for line in code.split('\n'):
        stripped = line.strip()
        if not cur and (not stripped or stripped.startswith('//')):
            continue
        cur.append(line)
        i = 0
        while i < len(line):
            c = line[i]
            if in_str:
                if c == '\\': i += 1
                elif c == in_str: in_str = None
            elif c in '\'"': in_str = c
            elif c == '/' and line[i:i+2] == '//': break
            elif c in '([{': depth += 1
            elif c in ')]}': depth -= 1
            i += 1
        if depth == 0 and (stripped.endswith(';') or stripped.endswith('}')):
            out.append('\n'.join(cur)); cur = []
    if cur: out.append('\n'.join(cur))
    return out

def declared_name(stmt):
    m = re.match(r'\s*(?:late\s+)?(?:final|const|var)\s+(?:[\w<>?, ]+\s+)?(\$?\w+)\s*[=;]', stmt)
    return m.group(1) if m else None

def classify(section, meta, code):
    if section.lower().startswith('signature'): return 'skip: signature'
    if 'del=' in meta: return 'skip: diff step'
    if re.search(r'^\s*\.\.\.\s*$|\{\.\.\.\}|\(\.\.\.\)|\[\.\.\.\]|, \.\.\.|\.\.\.,', code, re.M): return 'skip: has ...'
    if '@luthor' in code and 'class ' in code: return 'model'
    depth = 0; params = 0
    for line in code.split('\n'):
        if depth == 0 and PARAM_LINE.match(line): params += 1
        depth += line.count('{') + line.count('(') - line.count('}') - line.count(')')
    if params: return 'skip: parameter lines'
    if re.search(r'\$\w+Validate|\w+ErrorKeys|\w+SchemaKeys|\$\w+Schema|validateSelf', code): return 'generated'
    return 'runtime'

def build(kind, blocks, page):
    """blocks: earlier context blocks plus the block under test, last."""
    top, main_body, seen = [], [], set()
    for code in blocks:
        code = '\n'.join(l for l in code.split('\n') if not re.match(r"^\s*(import|part) ", l))
        if 'void main' in code:
            # A full program: hoist everything except main into top-level, keep main's body.
            m = re.search(r'void main\(\)\s*\{(.*)\}\s*$', code, re.S)
            pre = code[:m.start()] if m else code
            body = m.group(1) if m else ''
            for stmt in split_statements(pre):
                name = declared_name(stmt) or stmt.split('(')[0].split()[-1]
                if name in seen: continue
                seen.add(name); top.append(stmt)
            main_body.append(textwrap.dedent(body))
            continue
        for stmt in split_statements(code):
            if DECL.match(stmt.strip()) or stmt.strip().startswith('@'):
                name = declared_name(stmt) or re.sub(r'[^\w$]', ' ', stmt).split()[1] if len(stmt.split()) > 1 else stmt
                if name in seen: continue
                seen.add(name); top.append(stmt)
            else:
                name = declared_name(stmt)
                if name and name in seen: continue
                if name: seen.add(name)
                main_body.append(stmt)
    imports = ''
    if kind == 'generated':
        imports = ("import 'package:luthor_docs_generated/tutorial_user.dart';"
                   if ('start/code-generation' in page or page.endswith('index.mdx')) else
                   "import 'package:luthor_docs_generated/user.dart';")
        joined = '\n'.join(blocks)
        for name, imp in GEN_IMPORTS:
            if re.search(r'\b' + name, joined) and imp not in imports: imports += '\n' + imp
        imports += "\nValidationResult<Object?> result = l.any().validate(null);\n"
    joined = '\n'.join(blocks)
    if kind == 'runtime' and 'User.fromJson' in joined and 'class User' not in joined:
        imports += USER_CLASS
    gen_imports = '\n'.join(l for l in imports.split('\n') if l.startswith('import '))
    rest = '\n'.join(l for l in imports.split('\n') if not l.startswith('import '))
    return PRELUDE_IMPORTS + gen_imports + '\n' + PRELUDE + rest + '\n' + '\n\n'.join(top) + '\n\nvoid main() {\n' + textwrap.indent('\n'.join(main_body), '  ') + '\n}\n'

def main():
    dirs = {'runtime': ROOT/'scripts/verdicts/snippets', 'generated': ROOT/'scripts/generated/snippets'}
    for d in dirs.values():
        if d.exists(): shutil.rmtree(d)
        d.mkdir()
    counts = {'runtime': 0, 'generated': 0, 'model': 0}
    skipped, model_fail, index = [], [], 0
    for page in sorted(DOCS.rglob('*.mdx')):
        rel = str(page.relative_to(DOCS)); section = ''; context = []
        for m in TOKEN.finditer(page.read_text()):
            if m.group(1):
                section = m.group(2); continue
            meta, code = m.group(3), m.group(4)
            kind = classify(section, meta, code)
            index += 1
            if kind.startswith('skip'):
                skipped.append((rel, kind)); continue
            if kind == 'model':
                counts['model'] += 1
                body = code[code.index('@luthor'):]
                end = body.find('\n}\n')
                if end > 0: body = body[:end + 2]
                if norm(body) not in models_text: model_fail.append(rel)
                continue
            counts[kind] += 1
            name = re.sub(r'[^a-z0-9]+', '_', rel.lower()).strip('_')
            (dirs[kind] / f'{name}_{index}.dart').write_text(build(kind, context + [code], rel))
            context.append(code)
    ok = True
    for label, dart in (('runtime', DART311), ('generated', DART313)):
        d = dirs[label]
        r = subprocess.run([dart, 'analyze', '--no-fatal-warnings', str(d)], cwd=d.parent, capture_output=True, text=True)
        errors = [l.strip() for l in r.stdout.splitlines() if l.strip().startswith('error')]
        print(f'{label}: {counts[label]} blocks analyzed, {len(errors)} errors')
        for e in errors: print('  ', e)
        ok = ok and not errors
    print(f"model definitions: {counts['model']} checked, {len(model_fail)} not matching scripts/generated/lib")
    for f in model_fail: print('  ', f)
    ok = ok and not model_fail
    print(f'skipped {len(skipped)} illustrative blocks')
    if '-v' in sys.argv:
        for rel, why in skipped: print(f'   {rel}: {why}')
    sys.exit(0 if ok else 1)

if __name__ == '__main__':
    main()
