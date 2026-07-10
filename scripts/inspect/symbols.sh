#!/usr/bin/env bash
# Inspect: symbol table.
#
# WHAT THIS IS: `nm` lists every named symbol (function or static value)
# the linker recorded in the binary. Rust "mangles" these names to encode
# type information (so two functions with the same name but different
# generic types don't collide), which makes the raw output look cryptic
# -- e.g. `_ZN4core3fmt...`. `rustfilt`, if installed, demangles these
# back into readable Rust paths like `core::fmt::Arguments::new_v1`.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${BINARY:?BINARY not set -- run this via scripts/run.sh, not directly}"

nm "$BINARY" > "$OUT/bin-nm-raw.txt"
nm "$BINARY" | wc -l > "$OUT/bin-symbol-count.txt"
echo "  - bin-nm-raw.txt, bin-symbol-count.txt"

if command -v rustfilt >/dev/null 2>&1; then
    nm "$BINARY" | rustfilt > "$OUT/bin-nm-demangled.txt"
    echo "  - bin-nm-demangled.txt"
else
    echo "WARNING: rustfilt not found. Run: cargo install rustfilt"
fi
