#!/usr/bin/env bash
# Step 05: Target assembly.
#
# WHAT THIS IS: LLVM's backend lowers the architecture-independent IR from
# step 04 into real assembly instructions for the requested --target. This
# is where CPU-specific differences actually appear: register names,
# calling conventions, which instructions get selected, addressing modes,
# and so on. This file is the main event for the cross-architecture
# comparison in the paper.
#
# On x86-64 we ask for Intel syntax (e.g. "mov eax, 1") instead of the
# GNU/AT&T default (e.g. "mov $1, %eax"), since Intel syntax is what most
# textbooks and the AArch64 assembly we're comparing against both use.
# AArch64 only has one syntax, so no flag is needed there.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${SRC:?SRC not set -- run this via scripts/run.sh, not directly}"
: "${TARGET:?TARGET not set -- run this via scripts/run.sh, not directly}"
: "${PLAT:?PLAT not set -- run this via scripts/run.sh, not directly}"

echo "[05] Emitting assembly..."
if [[ "$PLAT" == "x86_64-linux" ]]; then
    rustc --edition=2021 -Copt-level=3 --emit=asm --target="$TARGET" \
        -C llvm-args=-x86-asm-syntax=intel "$SRC" -o "$OUT/05-hello.s"
else
    rustc --edition=2021 -Copt-level=3 --emit=asm --target="$TARGET" \
        "$SRC" -o "$OUT/05-hello.s"
fi
