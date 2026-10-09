#!/usr/bin/env bash
#
# Runs the full local check suite and stops at the first failing step:
# dependencies, formatting, analysis, the DI boundary guard, and tests.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

echo '==> flutter pub get'
flutter pub get

echo '==> dart format --output=none --set-exit-if-changed .'
dart format --output=none --set-exit-if-changed .

echo '==> flutter analyze'
flutter analyze

echo '==> bash scripts/di_boundary_guard.sh'
bash scripts/di_boundary_guard.sh

echo '==> flutter test'
flutter test
