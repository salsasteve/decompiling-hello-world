#!/usr/bin/env bash
# Inspect: disassembly.
#
# WHAT THIS IS: `llvm-objdump -d` reads the compiled machine code back out
# of the finished binary and prints it as assembly. Unlike step 05's
# `-S` output (what clang handed to the assembler), this reflects exactly
# what the linker produced in the final executable. C symbol names aren't
# mangled the way Rust/C++ names are, so `--demangle` is a no-op here but
# kept for parity with the Rust project's disassemble.sh.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${BINARY:?BINARY not set -- run this via scripts/run.sh, not directly}"

llvm-objdump -d --demangle "$BINARY" > "$OUT/bin-disasm.txt"
echo "  - bin-disasm.txt"
