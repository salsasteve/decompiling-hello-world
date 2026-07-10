#!/usr/bin/env bash
# Single entry point for this project -- no Make, no extra tools to install.
#
# Usage:
#   scripts/run.sh pipeline        Run the full compiler pipeline dump + build
#   scripts/run.sh inspect         Inspect the binary for this machine's platform
#   scripts/run.sh all             pipeline, then inspect
#   scripts/run.sh clean           Remove generated artifacts (keeps directories)
#   scripts/run.sh install-tools   Print instructions for installing required tools
#   scripts/run.sh help            Show this message
#
# Each individual compilation stage lives in its own small script under
# scripts/pipeline/, and each inspection step lives under scripts/inspect/.
# Open any one of those files if you want to see exactly what command
# produces a given artifact and why -- each starts with a plain-English
# comment explaining that stage of compilation.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT_DIR"

source "$SCRIPT_DIR/lib/platform.sh"

cmd_pipeline() {
    detect_platform
    export OUT="artifacts/$PLAT"
    export SRC="src/hello/src/main.rs"
    mkdir -p "$OUT"

    echo "Detected platform: $PLAT (target: $TARGET)"
    for step in "$SCRIPT_DIR"/pipeline/*.sh; do
        bash "$step"
    done
    echo "=== Done. Artifacts saved to $OUT ==="
}

cmd_inspect() {
    detect_platform
    export OUT="artifacts/$PLAT"
    export BINARY="$OUT/hello"

    if [[ ! -f "$BINARY" ]]; then
        echo "ERROR: binary not found at $BINARY" >&2
        echo "Run 'scripts/run.sh pipeline' first." >&2
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
    rm -rf artifacts/x86_64-linux/* artifacts/aarch64-macos/*
    mkdir -p artifacts/x86_64-linux artifacts/aarch64-macos
    touch artifacts/x86_64-linux/.gitkeep artifacts/aarch64-macos/.gitkeep
    echo "Cleaned artifacts/ (directories kept)"
}

cmd_install_tools() {
    cat <<'EOF'
=== Required tools ===
1. Nightly toolchain (for macro expansion / HIR / MIR dumps):
     rustup toolchain install nightly

2. rustfilt (for demangled symbol tables):
     cargo install rustfilt

3. llvm-objdump:
     Linux:  apt install llvm      (or: dnf install llvm)
     macOS:  brew install llvm
EOF
}

cmd_help() {
    cat <<'EOF'
Usage: scripts/run.sh <command>

Commands:
  pipeline       Dump compiler IRs, assembly, and build the release binary
  inspect        Inspect the compiled binary for this machine's platform
  all            Run pipeline, then inspect
  clean          Remove generated artifacts (keeps directory structure)
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
