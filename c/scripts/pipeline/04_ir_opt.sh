#!/usr/bin/env bash
# Step 04: Optimized LLVM IR.
#
# WHAT THIS IS: the same LLVM IR as step 03, but with LLVM's -O3 middle-end
# optimization pipeline applied (mem2reg to eliminate the stack allocas,
# inlining, dead code elimination, etc). LLVM IR is architecture-independent
# -- it doesn't yet know about x86-64 vs AArch64 registers or instructions.
#
# THIS IS THE KEY FILE FOR THE "SAME COMPILER, DIFFERENT CPU" ARGUMENT, same
# as the Rust project's 04-ir.ll: this file should look nearly identical
# whether it was generated on x86-64 or AArch64 (aside from the `target
# triple` / `target datalayout` header lines, which just record which
# machine it was generated for). Any real divergence between platforms only
# shows up in the assembly (step 05), once LLVM's backend lowers this IR to
# a specific instruction set.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${SRC:?SRC not set -- run this via scripts/run.sh, not directly}"
: "${TARGET:?TARGET not set -- run this via scripts/run.sh, not directly}"

echo "[04] Emitting optimized LLVM IR..."
clang --target="$TARGET" -O3 -S -emit-llvm "$SRC" -o "$OUT/04-ir-opt.ll"
