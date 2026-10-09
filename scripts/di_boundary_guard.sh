#!/usr/bin/env bash
#
# Fails when the get_it service locator (`getIt`) appears outside the approved
# dependency-injection boundaries:
#
#   - lib/app/di/**
#   - lib/app/bootstrap.dart
#   - lib/features/*/di/**
#
# Only production code under lib/ is scanned; tests are allowed to reach the
# container directly.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

allowed_regex='^lib/app/di/|^lib/app/bootstrap\.dart$|^lib/features/[^/]+/di/'

violations=""
while IFS= read -r file; do
  if grep -Eq '\bgetIt\b' "$file" && ! [[ "$file" =~ $allowed_regex ]]; then
    violations+="${file}"$'\n'
  fi
done < <(find lib -name '*.dart' -type f | sort)

if [[ -n "$violations" ]]; then
  echo "di_boundary_guard: getIt used outside lib/app/di/**, lib/app/bootstrap.dart, and lib/features/*/di/**:" >&2
  printf '%s' "$violations" >&2
  exit 1
fi

echo "di_boundary_guard: ok - getIt is confined to the approved boundaries"
