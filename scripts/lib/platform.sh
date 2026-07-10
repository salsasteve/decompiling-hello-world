# Shared helper: figure out what machine we're running on.
#
# A "target triple" (e.g. x86_64-unknown-linux-gnu) is how rustc names a
# CPU architecture + OS + ABI combination. We detect it explicitly here,
# rather than letting rustc default to "whatever this machine is", so the
# result is easy to reason about and identical every time this script runs
# on a given machine.
#
# Sets two variables for the caller: PLAT (short name used for the
# artifacts/<PLAT> directory) and TARGET (the real rustc target triple).

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
