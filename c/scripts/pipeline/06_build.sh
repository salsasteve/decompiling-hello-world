#!/usr/bin/env bash
# Step 06: Build the release binary.
#
# WHAT THIS IS: every step so far only emitted intermediate text files --
# nothing runnable. This step runs clang the rest of the way through the
# linker and produces an actual executable. That binary is what the
# scripts/inspect/*.sh scripts examine (symbol tables, disassembly, section
# headers, etc.).
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${SRC:?SRC not set -- run this via scripts/run.sh, not directly}"
: "${TARGET:?TARGET not set -- run this via scripts/run.sh, not directly}"

echo "[06] Building release binary..."
clang --target="$TARGET" -O3 "$SRC" -o "$OUT/hello" > "$OUT/06-build-log.txt" 2>&1
