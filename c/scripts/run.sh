#!/usr/bin/env bash
# Single entry point for the C/LLVM sibling project -- same shape as the
# top-level scripts/run.sh for the Rust project, no Make, no extra tools.
#
# Usage:
#   c/scripts/run.sh pipeline        Run the full clang/LLVM pipeline dump + build
#   c/scripts/run.sh inspect         Inspect the binary for this machine's platform
#   c/scripts/run.sh all             pipeline, then inspect
#   c/scripts/run.sh clean           Remove generated C artifacts (keeps directories)
#   c/scripts/run.sh install-tools   Print instructions for installing required tools
#   c/scripts/run.sh help            Show this message
#
# Each individual compilation stage lives in its own small script under
# c/scripts/pipeline/, and each inspection step lives under
# c/scripts/inspect/. Open any one of those files if you want to see exactly
# what command produces a given artifact and why -- each starts with a
# plain-English comment explaining that stage of compilation.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
cd "$ROOT_DIR"

source "$SCRIPT_DIR/lib/platform.sh"

cmd_pipeline() {
    detect_platform
    export OUT="artifacts/$PLAT/c"
    export SRC="c/src/hello/hello.c"
    mkdir -p "$OUT"

    echo "Detected platform: $PLAT (target: $TARGET)"
    for step in "$SCRIPT_DIR"/pipeline/*.sh; do
        bash "$step"
    done
    echo "=== Done. Artifacts saved to $OUT ==="
}

cmd_inspect() {
    detect_platform
    export OUT="artifacts/$PLAT/c"
    export BINARY="$OUT/hello"

    if [[ ! -f "$BINARY" ]]; then
        echo "ERROR: binary not found at $BINARY" >&2
        echo "Run 'c/scripts/run.sh pipeline' first." >&2
        exit 1
    fi

    echo "Inspecting $BINARY..."
    bash "$SCRIPT_DIR/inspect/basic_info.sh"
    bash "$SCRIPT_DIR/inspect/symbols.sh"
    bash "$SCRIPT_DIR/inspect/disassemble.sh"

    if [[ "$PLAT" == "x86_64-linux" ]]; then
        bash "$SCRIPT_DIR/inspect/linux_specific.sh"
    elif [[ "$PLAT" == "aarch64-macos" ]]; then
        bash "$SCRIPT_DIR/inspect/macos_specific.sh"
    fi
    echo "=== Done inspecting $BINARY ==="
}

cmd_clean() {
    rm -rf artifacts/x86_64-linux/c/* artifacts/aarch64-macos/c/*
    mkdir -p artifacts/x86_64-linux/c artifacts/aarch64-macos/c
    touch artifacts/x86_64-linux/c/.gitkeep artifacts/aarch64-macos/c/.gitkeep
    echo "Cleaned artifacts/*/c/ (directories kept)"
}

cmd_install_tools() {
    cat <<'EOF'
=== Required tools ===
1. clang (part of LLVM):
     Linux:  apt install clang llvm      (or: dnf install clang llvm)
     macOS:  xcode-select --install      (ships Apple's clang)
             or: brew install llvm       (for an upstream LLVM build)

   IMPORTANT: apt/dnf and Homebrew/Xcode often package different LLVM point
   releases. If you need a *guaranteed* matching clang/LLVM version on both
   the AMD Linux box and the Mac, download the same prebuilt release for
   both platforms from https://github.com/llvm/llvm-project/releases
   instead of relying on the system package manager, and put it first on
   PATH. Either way, 00-versions.txt records exactly what was used --
   always check both machines' files agree before trusting a comparison.

2. llvm-objdump (usually installed alongside clang/LLVM above).
EOF
}

cmd_help() {
    cat <<'EOF'
Usage: c/scripts/run.sh <command>

Commands:
  pipeline       Dump clang/LLVM IRs, assembly, and build the binary
  inspect        Inspect the compiled binary for this machine's platform
  all            Run pipeline, then inspect
  clean          Remove generated C artifacts (keeps directory structure)
  install-tools  Print instructions for installing required tools
  help           Show this message
EOF
}

case "${1:-help}" in
    pipeline)       cmd_pipeline ;;
    inspect)        cmd_inspect ;;
    all)            cmd_pipeline; cmd_inspect ;;
    clean)          cmd_clean ;;
    install-tools)  cmd_install_tools ;;
    help|-h|--help) cmd_help ;;
    *)
        echo "ERROR: unknown command '$1'" >&2
        cmd_help
        exit 1
        ;;
esac
