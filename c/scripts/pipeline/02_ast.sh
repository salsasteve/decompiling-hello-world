#!/usr/bin/env bash
# Step 02: AST (Abstract Syntax Tree) dump.
#
# WHAT THIS IS: after preprocessing, clang parses the source into a tree of
# nodes (FunctionDecl, CallExpr, StringLiteral, ...) and resolves types.
# This is the closest analogue to the Rust project's HIR stage: still
# recognisably tied to the source structure, but no longer raw text -- it's
# clang's own internal representation of "what this program means,"
# annotated with resolved types for every expression.
set -euo pipefail
: "${OUT:?OUT not set -- run this via scripts/run.sh, not directly}"
: "${SRC:?SRC not set -- run this via scripts/run.sh, not directly}"
: "${TARGET:?TARGET not set -- run this via scripts/run.sh, not directly}"

echo "[02] Dumping AST..."
clang --target="$TARGET" -Xclang -ast-dump -fsyntax-only "$SRC" > "$OUT/02-ast.txt" 2>&1
