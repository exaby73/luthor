#!/usr/bin/env sh
# Regenerates every Verdict figure, printed output and generated-code
# excerpt on the site from the packages in this repository.
#
#   website/scripts/run.sh
#
# DART311 runs the runtime examples (Dart 3.11, the minimum luthor supports).
# DART313 runs the generator examples (freezed 4 needs Dart 3.13).
set -eu
cd "$(dirname "$0")"
DART311="${DART311:-$HOME/.asdf/installs/flutter/3.41.9-stable/bin/cache/dart-sdk/bin/dart}"
DART313="${DART313:-$HOME/.asdf/installs/flutter/3.47.5-stable/bin/cache/dart-sdk/bin/dart}"

(cd verdicts && "$DART311" pub get >/dev/null && "$DART311" run bin/verdicts.dart)
(cd generated \
  && "$DART313" pub get >/dev/null \
  && "$DART313" run build_runner build >/dev/null \
  && "$DART313" analyze --fatal-infos lib bin \
  && "$DART313" run bin/check.dart \
  && "$DART313" run bin/extract.dart)
