#!/usr/bin/env bash
# Step 01: Preprocessing (macro expansion + #include).
#
# WHAT THIS IS: before a C compiler parses anything, the preprocessor runs
# -- it expands #include directives (pasting in header contents verbatim)
# and any #define macros. This is the closest C analogue to the Rust
# project's "macro expansion" stage: it's the last point where the output
# is still plain, compilable C, before any real compiler analysis happens.
#
# NOTE: because #include <stdio.h> pastes in the whole prototype chain from
# libc's headers, most of this file's length is standard-library boilerplate
# unrelated to our one line of code -- that's expected and is itself worth
# noting in the paper (Rust's macro expansion for one println! call is far
# smaller than C's preprocessed output for one printf call, because Rust's
# std isn't pulled in by textual #include).
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${SRC:?SRC not set -- run this via scripts/run.sh, not directly}"
: "${TARGET:?TARGET not set -- run this via scripts/run.sh, not directly}"

echo "[01] Dumping preprocessed source..."
clang --target="$TARGET" -E -P "$SRC" > "$OUT/01-preprocessed.c"
