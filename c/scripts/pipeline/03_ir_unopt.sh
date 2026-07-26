#!/usr/bin/env bash
# Step 03: Unoptimized LLVM IR.
#
# WHAT THIS IS: clang's frontend (Clang CodeGen) translates the AST
# directly into LLVM IR, with no optimization applied yet (-O0). This is a
# very literal, verbose translation -- every local variable gets its own
# stack slot (an `alloca`), even ones that are never reassigned. This is
# the closest analogue to the Rust project's MIR stage: a lower-level,
# no-longer-source-shaped representation, before any real optimization has
# touched it. Unlike MIR it's already LLVM's own IR, not a Rust-specific
# one -- C has no separate mid-level IR of its own; clang goes straight
# from AST to LLVM IR.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${SRC:?SRC not set -- run this via scripts/run.sh, not directly}"
: "${TARGET:?TARGET not set -- run this via scripts/run.sh, not directly}"

echo "[03] Emitting unoptimized LLVM IR..."
clang --target="$TARGET" -O0 -S -emit-llvm "$SRC" -o "$OUT/03-ir-unopt.ll"
