#!/usr/bin/env bash
# Step 06: Build the release binary.
#
# WHAT THIS IS: every step so far only emitted intermediate text files --
# nothing runnable. This step does a real `cargo build --release`, which
# takes rustc's output the rest of the way through the linker and produces
# an actual executable. That binary is what the scripts/inspect/*.sh
# scripts examine (symbol tables, disassembly, section headers, etc.).
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"

echo "[06] Building release binary..."
(cd src/hello && cargo build --release) > "$OUT/06-build-log.txt" 2>&1
cp "src/hello/target/release/hello" "$OUT/hello"
