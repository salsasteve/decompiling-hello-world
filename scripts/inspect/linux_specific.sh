#!/usr/bin/env bash
# Inspect: Linux-specific binary details.
#
# WHAT THIS IS: Linux executables use the ELF format. `readelf -hSl`
# prints ELF's own bookkeeping -- its file header, section table, and
# program (segment) headers -- which is the metadata the OS loader reads
# to map the binary into memory and run it. `ldd` lists which shared
# libraries (e.g. libc) the binary needs at runtime.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${BINARY:?BINARY not set -- run this via scripts/run.sh, not directly}"

readelf -hSl "$BINARY" > "$OUT/bin-readelf.txt"
ldd "$BINARY" > "$OUT/bin-ldd.txt"
echo "  - bin-readelf.txt, bin-ldd.txt"
