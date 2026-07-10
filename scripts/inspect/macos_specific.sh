#!/usr/bin/env bash
# Inspect: macOS-specific binary details.
#
# WHAT THIS IS: macOS executables use the Mach-O format instead of ELF.
# `otool -l` prints its load commands (Mach-O's equivalent of ELF's
# program headers), and `otool -L` lists linked dynamic libraries. We also
# count pointer-authentication instructions (paciasp/autiasp) in the
# step-05 assembly -- an Apple Silicon / AArch64 security feature that
# signs return addresses on the stack, with no x86-64 equivalent. Its
# presence (or absence) is itself a notable architectural difference worth
# reporting in the paper.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${BINARY:?BINARY not set -- run this via scripts/run.sh, not directly}"
: "${PLAT:?PLAT not set -- run this via scripts/run.sh, not directly}"

otool -l "$BINARY" > "$OUT/bin-loadcmds.txt"
otool -L "$BINARY" > "$OUT/bin-dylibs.txt"
grep -c "paciasp\|autiasp" "artifacts/$PLAT/05-hello.s" > "$OUT/bin-pac-count.txt" 2>/dev/null \
    || echo "0" > "$OUT/bin-pac-count.txt"
echo "  - bin-loadcmds.txt, bin-dylibs.txt, bin-pac-count.txt"
