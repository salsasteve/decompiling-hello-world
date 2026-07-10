#!/usr/bin/env bash
# Step 03: MIR (Mid-level Intermediate Representation).
#
# WHAT THIS IS: MIR represents the program as a control-flow graph --
# blocks of simple statements connected by jumps and conditionals. This no
# longer looks like Rust source at all. It's the form the borrow checker
# actually runs against, and where Rust does most of its own optimizations
# before handing the program off to LLVM.
#
# Requires nightly rustc, same as steps 01-02.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${SRC:?SRC not set -- run this via scripts/run.sh, not directly}"

echo "[03] Dumping MIR..."
rustc +nightly --edition=2021 -Zunpretty=mir -Copt-level=3 "$SRC" > "$OUT/03-mir.txt" 2>&1 \
    || echo "WARNING: nightly not installed, skipping step 03"
