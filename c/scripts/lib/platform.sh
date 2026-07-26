# Shared helper: figure out what machine we're running on.
#
# Same idea as ../../../scripts/lib/platform.sh for the Rust project: detect
# the target triple explicitly rather than letting clang default to "whatever
# this machine is", so builds are reproducible and the PLAT name matches the
# Rust project's artifacts/<PLAT>/ directories exactly.
#
# Sets two variables for the caller: PLAT (short name used for the
# artifacts/<PLAT>/c directory) and TARGET (the real clang/LLVM target triple).

detect_platform() {
    local uname_m uname_s
    uname_m="$(uname -m)"
    uname_s="$(uname -s)"

    if [[ "$uname_m" == "x86_64" && "$uname_s" == "Linux" ]]; then
        PLAT="x86_64-linux"
        TARGET="x86_64-unknown-linux-gnu"
    elif [[ "$uname_s" == "Darwin" && ( "$uname_m" == "arm64" || "$uname_m" == "aarch64" ) ]]; then
        PLAT="aarch64-macos"
        TARGET="aarch64-apple-darwin"
    else
        echo "ERROR: unrecognised platform (uname -m: $uname_m, uname -s: $uname_s)" >&2
        exit 1
    fi

    export PLAT TARGET
}
