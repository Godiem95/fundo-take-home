#!/usr/bin/env bash
# Design-system drift: counts literals that bypass tokens.json, per surface, on every commit.
# Usage: scripts/drift.sh <dir> [<dir> ...]   e.g. scripts/drift.sh apps/apply apps/portal wordpress/theme email/templates
# Prints one line per surface. Wire it into CI and fail the build when a number rises.
set -euo pipefail
TOKENS="${TOKENS:-tokens.json}"
known=$(grep -oE '#[0-9a-fA-F]{6}' "$TOKENS" | tr 'A-F' 'a-f' | sort -u)
for dir in "$@"; do
  files=$(find "$dir" -type f \( -name '*.tsx' -o -name '*.ts' -o -name '*.jsx' -o -name '*.css' -o -name '*.php' -o -name '*.html' -o -name '*.mjml' \) 2>/dev/null || true)
  [ -z "$files" ] && { echo "$dir: no files"; continue; }
  hex=$(cat $files | grep -oE '#[0-9a-fA-F]{6}\b' | tr 'A-F' 'a-f' | sort | uniq -c | sort -rn)
  unknown=$(echo "$hex" | awk '{print $2}' | grep -vxF -f <(echo "$known") | wc -l | tr -d ' ')
  rgba=$(cat $files | grep -oE 'rgba?\(' | wc -l | tr -d ' ')
  fonts=$(cat $files | grep -oE 'font-family:[^;"]+' | grep -viE 'Outfit|Roboto|Arial|inherit' | wc -l | tr -d ' ')
  radii=$(cat $files | grep -oE 'border-radius:\s*[0-9]+px' | grep -vE '(4|8|10|12|16|24|9999)px' | wc -l | tr -d ' ')
  refs=$(cat $files | grep -oE 'var\(--[a-z0-9-]+\)' | wc -l | tr -d ' ')
  echo "$dir: token refs $refs | unknown hex $unknown | rgba literals $rgba | off-system fonts $fonts | off-scale radii $radii"
done
