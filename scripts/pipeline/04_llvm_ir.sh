#!/usr/bin/env bash
# Step 04: LLVM IR.
#
# WHAT THIS IS: rustc doesn't generate machine code itself -- it hands MIR
# off to LLVM, translated into LLVM's own intermediate representation. LLVM
# IR is a typed, assembly-like language that is NOT tied to any specific
# CPU yet. LLVM runs its own optimization passes on this form, and only
# converts it into real machine instructions at the very last step, once
# it knows the target CPU (see step 05).
#
# THIS IS THE KEY FILE FOR THE "SAME COMPILER, DIFFERENT CPU" ARGUMENT:
# 04-ir.ll should look nearly identical whether it was generated on
# x86-64 or AArch64, because LLVM IR is architecture-independent. Any
# divergence between platforms only becomes visible in the assembly (step
# 05), once LLVM's backend lowers this IR to a specific instruction set.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${SRC:?SRC not set -- run this via scripts/run.sh, not directly}"
: "${TARGET:?TARGET not set -- run this via scripts/run.sh, not directly}"

echo "[04] Emitting LLVM IR..."
rustc --edition=2021 -Copt-level=3 --emit=llvm-ir --target="$TARGET" "$SRC" -o "$OUT/04-ir.ll"
