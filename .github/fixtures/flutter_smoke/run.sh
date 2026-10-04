#!/usr/bin/env bash
# Flutter 3.41 smoke test for luthor and luthor_generator.
#
# Creates a fresh Flutter app outside the repository, adds luthor and
# luthor_generator as path dependencies next to build_runner and
# json_serializable, generates code for lib/user.dart and analyzes the app.
# Flutter pins meta, which limits analyzer to 10.0.x on Flutter 3.41, so this
# proves the generator resolves and works on the oldest supported Flutter.
#
# Usage: run.sh [app_dir]
# Needs `flutter` and `dart` from the Flutter SDK on PATH.
set -euo pipefail

fixture_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$fixture_dir/../../.." && pwd)"
app_dir="${1:-${RUNNER_TEMP:-$(mktemp -d)}/luthor_flutter_smoke}"

luthor_path="$repo_root/packages/luthor"
generator_path="$repo_root/packages/luthor_generator"

echo "::group::Create Flutter app in $app_dir"
flutter --version
flutter create --empty --no-pub --project-name luthor_flutter_smoke "$app_dir"
echo "::endgroup::"

cd "$app_dir"

echo "::group::Add dependencies"
# luthor 1.0.0 is not on pub.dev yet, and luthor_generator depends on it, so
# the override points every luthor dependency at the local package.
flutter pub add \
  "luthor:{\"path\":\"$luthor_path\"}" \
  json_annotation \
  "dev:luthor_generator:{\"path\":\"$generator_path\"}" \
  dev:build_runner \
  dev:json_serializable \
  "override:luthor:{\"path\":\"$luthor_path\"}"
cat pubspec.yaml
echo "::endgroup::"

echo "::group::Resolved versions"
dart pub deps --style=compact |
  grep -E '^- (analyzer|meta|build|source_gen|build_runner|json_serializable) ' || true
echo "::endgroup::"
analyzer_version="$(dart pub deps --style=compact | sed -n 's/^- analyzer \([^ ]*\).*/\1/p')"
echo "::notice title=Flutter smoke::Resolved analyzer $analyzer_version"

cp "$fixture_dir/lib/user.dart" lib/user.dart

echo "::group::build_runner build"
dart run build_runner build
echo "::endgroup::"

if ! grep -qF "\$UserSchema" lib/user.g.dart; then
  echo "::error::lib/user.g.dart has no \$UserSchema; luthor_generator did not run."
  exit 1
fi

echo "::group::Generated lib/user.g.dart"
cat lib/user.g.dart
echo "::endgroup::"

dart analyze
