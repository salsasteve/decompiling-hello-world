# Decompiling Hello World (C/LLVM edition)

## Overview

This is the C sibling of the [Rust project](../README.md) one directory up.
Same idea: compile an identical "Hello, world!" source file with identical
compiler flags on two different CPU architectures -- **x86-64** (AMD, Linux)
and **AArch64** (Apple Silicon, macOS) -- and record every stage of the
pipeline so the architectural divergence can be documented and compared.

The compiler here is **clang/LLVM**, chosen specifically because it's one
toolchain that runs natively on both target platforms: Apple ships clang as
its default compiler on macOS, and clang/LLVM packages are first-class on
Linux. Using the same compiler family as both the Rust project's backend
(rustc itself is built on LLVM) and this C project's frontend also makes it
possible to compare "same LLVM backend, different frontend" (C vs Rust) in
addition to "same frontend, different CPU."

## Requirements

- `clang` (LLVM's C compiler)
- `llvm-objdump`
- `nm`, `size`, `strings`, `file` -- standard on both platforms

Platform-specific tools:

- `readelf` and `ldd` -- Linux only
- `otool` -- macOS only

### Getting a matching clang/LLVM version on both machines

The whole comparison only holds if both machines are running the *same*
clang/LLVM version. System package managers don't guarantee this: apt/dnf on
Linux and Homebrew/Xcode on macOS frequently ship different point releases.
Two options, in order of preference:

1. **Download the same prebuilt release for both platforms** from
   [LLVM's GitHub releases](https://github.com/llvm/llvm-project/releases)
   (they publish binaries for `x86_64-linux` and `arm64-apple-macos`) and put
   it first on `PATH` on each machine.
2. If relying on the system-provided clang, run `c/scripts/run.sh pipeline`
   on both machines and diff the resulting `00-versions.txt` files. If the
   clang/LLVM versions don't match, say so explicitly in the paper's
   Methodology section rather than treating the comparison as clean.

## Quick start

```sh
c/scripts/run.sh install-tools   # print instructions for installing the tools above
c/scripts/run.sh pipeline        # run the full compiler pipeline dump and build the binary
c/scripts/run.sh inspect         # inspect the resulting binary
```

Or simply:

```sh
c/scripts/run.sh all
```

All commands work from anywhere in the repo -- the script `cd`s to the repo
root itself.

## How the pipeline is organized

Numbered stages under `c/scripts/pipeline/`, mirroring the Rust project's
stage-by-stage structure as closely as C/LLVM's actual pipeline allows. C
doesn't have Rust's HIR/MIR passes -- clang goes source → AST → LLVM IR
directly -- so the closest honest analogue is used at each step:

| Stage | Script | Plain-English summary | Rust project's equivalent |
|---|---|---|---|
| Versions | `pipeline/00_versions.sh` | Records exactly which clang/LLVM version produced everything else. | `00_versions.sh` |
| Preprocessing | `pipeline/01_preprocess.sh` | Expands `#include` and any macros into plain, compilable C. | `01_expand.sh` (macro expansion) |
| AST | `pipeline/02_ast.sh` | clang's parsed, type-resolved tree -- still tied to source structure. | `02_hir.sh` (HIR) |
| Unoptimized LLVM IR | `pipeline/03_ir_unopt.sh` | A very literal translation straight from the AST, `-O0`, before any optimization. | `03_mir.sh` (MIR) |
| Optimized LLVM IR | `pipeline/04_ir_opt.sh` | LLVM IR after the `-O3` middle-end pipeline. Architecture-independent -- should look nearly the same on both CPUs. | `04_llvm_ir.sh` |
| Assembly | `pipeline/05_asm.sh` | Real instructions for one specific CPU. Where x86-64 and AArch64 actually diverge. | `05_asm.sh` |
| Build | `pipeline/06_build.sh` | Links everything into a runnable binary. | `06_build.sh` |

`c/scripts/run.sh pipeline` runs these seven scripts in order. Likewise,
`c/scripts/run.sh inspect` runs the small scripts under `c/scripts/inspect/`
(`basic_info.sh`, `symbols.sh`, `disassemble.sh`, plus one of
`linux_specific.sh` / `macos_specific.sh`) -- identical in spirit to the
Rust project's inspect scripts, minus the `rustfilt` demangling step (plain
C doesn't mangle names).

### Verifying you're looking at the right stage

| Stage | File | Looks like |
|---|---|---|
| Preprocessing | `01-preprocessed.c` | Valid C, `#include` fully expanded (mostly libc header boilerplate), no `#define` macros left |
| AST | `02-ast.txt` | clang's tree-dump syntax: `FunctionDecl`, `CallExpr`, `ImplicitCastExpr`, with resolved types on every node |
| Unoptimized LLVM IR | `03-ir-unopt.ll` | Starts with `define`, every local variable has its own `alloca` (stack slot), lots of redundant loads/stores |
| Optimized LLVM IR | `04-ir-opt.ll` | Same LLVM syntax, but `alloca`s are gone (promoted to SSA registers), dead code eliminated |
| Assembly | `05-hello.s` | Real mnemonics for the target: `mov`/`call`/`ret` (x86-64) or `mov`/`bl`/`ret` (AArch64) |

### Running one stage at a time

Each `pipeline/*.sh` script expects `OUT`, `SRC`, `TARGET`, and `PLAT` to
already be set (normally `run.sh` does this for you). Run from the repo
root:

```sh
export OUT=artifacts/x86_64-linux/c SRC=c/src/hello/hello.c \
       TARGET=x86_64-unknown-linux-gnu PLAT=x86_64-linux
mkdir -p "$OUT"

bash c/scripts/pipeline/01_preprocess.sh && cat "$OUT/01-preprocessed.c"
bash c/scripts/pipeline/02_ast.sh        && cat "$OUT/02-ast.txt"
bash c/scripts/pipeline/03_ir_unopt.sh   && cat "$OUT/03-ir-unopt.ll"
bash c/scripts/pipeline/04_ir_opt.sh     && cat "$OUT/04-ir-opt.ll"
bash c/scripts/pipeline/05_asm.sh        && cat "$OUT/05-hello.s"
```

On macOS/AArch64, use
`OUT=artifacts/aarch64-macos/c TARGET=aarch64-apple-darwin PLAT=aarch64-macos`
instead.

## What gets generated

| File | Produced by | Contents |
|---|---|---|
| `00-versions.txt` | `pipeline/00_versions.sh` | `clang`/`uname` version info, plus exact CPU model and OS build |
| `01-preprocessed.c` | `pipeline/01_preprocess.sh` | Source after preprocessing (`#include` + macro expansion) |
| `02-ast.txt` | `pipeline/02_ast.sh` | clang's AST dump |
| `03-ir-unopt.ll` | `pipeline/03_ir_unopt.sh` | LLVM IR at `-O0`, straight from the AST |
| `04-ir-opt.ll` | `pipeline/04_ir_opt.sh` | LLVM IR after `-O3` optimization |
| `05-hello.s` | `pipeline/05_asm.sh` | Final target assembly (Intel syntax on x86-64) |
| `06-build-log.txt` | `pipeline/06_build.sh` | clang build output log |
| `hello` | `pipeline/06_build.sh` | The compiled binary |
| `bin-file.txt` | `inspect/basic_info.sh` | `file` output -- binary format/architecture |
| `bin-size.txt` | `inspect/basic_info.sh` | `size` output -- section sizes |
| `bin-strings.txt` | `inspect/basic_info.sh` | `strings` output -- embedded string constants |
| `bin-disasm.txt` | `inspect/disassemble.sh` | `llvm-objdump -d` full disassembly |
| `bin-nm-raw.txt` | `inspect/symbols.sh` | `nm` output -- symbol table (unmangled, plain C) |
| `bin-symbol-count.txt` | `inspect/symbols.sh` | Count of symbols from `nm` |
| `bin-readelf.txt` | `inspect/linux_specific.sh` | `readelf -hSl` -- ELF header, sections, program headers |
| `bin-ldd.txt` | `inspect/linux_specific.sh` | `ldd` -- dynamic library dependencies |
| `bin-loadcmds.txt` | `inspect/macos_specific.sh` | `otool -l` -- Mach-O load commands |
| `bin-dylibs.txt` | `inspect/macos_specific.sh` | `otool -L` -- linked dynamic libraries |
| `bin-pac-count.txt` | `inspect/macos_specific.sh` | Count of `paciasp`/`autiasp` pointer-authentication instructions |

## Artifacts directory layout

Output lands in `artifacts/<platform>/c/` at the repo root, alongside the
Rust project's `artifacts/<platform>/rust/`:

```
artifacts/
├── x86_64-linux/
│   ├── rust/   (Rust project's output)
│   └── c/      (this project's output)
└── aarch64-macos/
    ├── rust/
    └── c/
```

## Key files for the comparison

- **`05-hello.s`** -- the main assembly listing for the cross-architecture
  comparison.
- **`04-ir-opt.ll`** -- the optimized LLVM IR. Should be near-identical
  between the two platforms (modulo the `target triple`/`target datalayout`
  header), the same evidence used in the Rust project to show divergence
  happens in the backend, not upstream of it.
- **Comparing against `../artifacts/<platform>/rust/04-ir.ll`** -- since both
  projects go through the same LLVM optimizer and backend, differences
  between the C and Rust LLVM IR/assembly for equivalent programs isolate
  what each *frontend* contributes, separately from what the *target*
  contributes.

## Running on both machines

Clone this repo on both machines (same clone as the Rust project -- it's the
same repo). On each machine, run:

```sh
c/scripts/run.sh all
```

This populates `artifacts/<platform>/c/` in place. Once both machines have
run, combine the two `artifacts/` directories (via `git commit`/`push`/`pull`)
so both platforms' output is available side by side.
