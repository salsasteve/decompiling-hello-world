#!/usr/bin/env bash
# Inspect: disassembly.
#
# WHAT THIS IS: `llvm-objdump -d` reads the compiled machine code back out
# of the finished binary and prints it as assembly, with `--demangle`
# turning Rust's mangled symbol names back into readable paths. Unlike
# step 05's `--emit=asm` (which shows what rustc handed to the assembler),
# this reflects exactly what the linker produced in the final executable.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${BINARY:?BINARY not set -- run this via scripts/run.sh, not directly}"

llvm-objdump -d --demangle "$BINARY" > "$OUT/bin-disasm.txt"
echo "  - bin-disasm.txt"
