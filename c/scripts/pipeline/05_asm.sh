#!/usr/bin/env bash
# Step 05: Target assembly.
#
# WHAT THIS IS: LLVM's backend lowers the architecture-independent IR from
# step 04 into real assembly instructions for the requested --target. This
# is where CPU-specific differences actually appear: register names,
# calling conventions, which instructions get selected, addressing modes,
# and so on -- the main event for the cross-architecture comparison.
#
# On x86-64 we ask for Intel syntax (-masm=intel, e.g. "mov eax, 1") instead
# of the GNU/AT&T default (e.g. "mov $1, %eax"), matching the Rust project's
# 05-hello.s and most textbooks. AArch64 only has one syntax, so no flag is
# needed there.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${SRC:?SRC not set -- run this via scripts/run.sh, not directly}"
: "${TARGET:?TARGET not set -- run this via scripts/run.sh, not directly}"
: "${PLAT:?PLAT not set -- run this via scripts/run.sh, not directly}"

echo "[05] Emitting assembly..."
if [[ "$PLAT" == "x86_64-linux" ]]; then
    clang --target="$TARGET" -O3 -S -masm=intel "$SRC" -o "$OUT/05-hello.s"
else
    clang --target="$TARGET" -O3 -S "$SRC" -o "$OUT/05-hello.s"
fi
