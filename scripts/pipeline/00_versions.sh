#!/usr/bin/env bash
# Step 00: Record toolchain versions and exact machine specs.
#
# WHY THIS MATTERS: compiler output can change between rustc/LLVM versions,
# and "AMD Ryzen 7" / "Apple M4" aren't specific enough for a paper -- there
# are many SKUs and generations of each. Before comparing assembly from two
# different machines, we record exactly which compiler, CPU model, and OS
# build produced it, so any differences we find can be attributed to CPU
# architecture -- not to the two machines quietly differing in compiler
# version, CPU generation, or OS version.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${PLAT:?PLAT not set -- run this via scripts/run.sh, not directly}"

echo "[00] Recording toolchain versions and machine specs..."
{
    echo "### rustc --version --verbose"
    rustc --version --verbose
    echo
    echo "### rustup show active-toolchain"
    rustup show active-toolchain
    echo
    echo "### uname -a"
    uname -a
    echo

    if [[ "$PLAT" == "x86_64-linux" ]]; then
        echo "### lscpu (exact CPU model, core/thread count, cache sizes)"
        if command -v lscpu >/dev/null 2>&1; then
            lscpu
        else
            echo "lscpu not found -- falling back to /proc/cpuinfo"
            grep -m1 "model name" /proc/cpuinfo
        fi
        echo
        echo "### /etc/os-release (exact Linux distro name and version)"
        cat /etc/os-release
    elif [[ "$PLAT" == "aarch64-macos" ]]; then
        echo "### system_profiler SPHardwareDataType (exact chip model, core count, memory)"
        system_profiler SPHardwareDataType
        echo
        echo "### sw_vers (exact macOS product name, version, build)"
        sw_vers
    fi
} > "$OUT/00-versions.txt"
