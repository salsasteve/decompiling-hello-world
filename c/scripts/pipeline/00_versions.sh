#!/usr/bin/env bash
# Step 00: Record toolchain versions and exact machine specs.
#
# WHY THIS MATTERS: this whole project's premise is "same compiler, same
# source, different CPU" -- that only holds if clang/LLVM is actually the
# same version on both machines. apt/dnf and Homebrew often ship different
# point releases of LLVM, so before comparing assembly from two machines we
# record exactly which clang/LLVM version, CPU model, and OS build produced
# it. If the two 00-versions.txt files ever show different LLVM versions,
# that's a confound to disclose, not hide -- see the README for how to get
# matching versions on both platforms.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${PLAT:?PLAT not set -- run this via scripts/run.sh, not directly}"

echo "[00] Recording toolchain versions and machine specs..."
{
    echo "### clang --version"
    clang --version
    echo
    echo "### clang -print-target-triple / -print-targets"
    echo "native target triple: $(clang -print-target-triple)"
    echo
    echo "### llvm-objdump --version"
    llvm-objdump --version 2>&1 || echo "llvm-objdump not found"
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
