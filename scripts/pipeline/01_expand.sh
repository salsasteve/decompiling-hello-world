#!/usr/bin/env bash
# Step 01: Macro expansion.
#
# WHAT THIS IS: Rust macros (like println!) aren't real functions -- the
# compiler literally rewrites them into plain Rust code before doing
# anything else. This step dumps what println!("Hello, world!") expands
# into, which is usually a call into std::io's formatting machinery.
#
# Requires nightly rustc, because -Zunpretty is an unstable/internal flag
# not available on the stable compiler.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${SRC:?SRC not set -- run this via scripts/run.sh, not directly}"

echo "[01] Dumping macro expansion..."
rustc +nightly --edition=2021 -Zunpretty=expanded "$SRC" > "$OUT/01-expanded.rs" 2>&1 \
    || echo "WARNING: nightly not installed, skipping step 01"
