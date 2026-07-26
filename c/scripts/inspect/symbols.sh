#!/usr/bin/env bash
# Inspect: symbol table.
#
# WHAT THIS IS: `nm` lists every named symbol (function or static value)
# the linker recorded in the binary. Plain C doesn't mangle names the way
# Rust/C++ do, so these are already readable (`main`, `printf`, ...) --
# no demangling step needed, unlike the Rust project's symbols.sh.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${BINARY:?BINARY not set -- run this via scripts/run.sh, not directly}"

nm "$BINARY" > "$OUT/bin-nm-raw.txt"
nm "$BINARY" | wc -l > "$OUT/bin-symbol-count.txt"
echo "  - bin-nm-raw.txt, bin-symbol-count.txt"
