#!/usr/bin/env bash
# Inspect: basic binary info.
#
# WHAT THIS IS: `file` reports the binary's format and architecture,
# `size` reports how big each section (code, data, etc.) is, and
# `strings` scans the raw bytes for embedded readable text -- a quick,
# low-tech way to confirm "Hello, world!" is actually baked into the
# compiled executable.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${BINARY:?BINARY not set -- run this via scripts/run.sh, not directly}"

file "$BINARY" > "$OUT/bin-file.txt"
size "$BINARY" > "$OUT/bin-size.txt"
strings "$BINARY" > "$OUT/bin-strings.txt"
echo "  - bin-file.txt, bin-size.txt, bin-strings.txt"
