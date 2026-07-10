#!/usr/bin/env bash
# Step 02: HIR (High-level Intermediate Representation).
#
# WHAT THIS IS: after macro expansion, rustc turns the source into HIR --
# still recognisably Rust, but "desugared" (e.g. for loops become explicit
# iterator calls) and with types starting to get resolved. This is the
# form most of the compiler's own error messages and the borrow checker
# work with.
#
# Requires nightly rustc, same as step 01.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${SRC:?SRC not set -- run this via scripts/run.sh, not directly}"

echo "[02] Dumping HIR..."
rustc +nightly --edition=2021 -Zunpretty=hir "$SRC" > "$OUT/02-hir.rs" 2>&1 \
    || echo "WARNING: nightly not installed, skipping step 02"
