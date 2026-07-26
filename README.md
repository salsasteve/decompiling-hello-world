# Decompiling Hello World: A Cross-Architecture Assembly Comparison

## Overview

This is a research project comparing the assembly output produced by the Rust
compiler for an identical "Hello, world!" source file and identical compiler
flags, across two different CPU architectures: **x86-64** (AMD Ryzen 7
9800X3D, Linux) and **AArch64** (Apple M4, macOS). By holding the source code,
compiler version, and optimization flags constant while varying only the
target ISA, this project isolates and documents the architectural
differences visible at every stage of the compilation pipeline — from macro
expansion down to the final machine code and linked binary. It is part of a
larger paper on computer architecture.

A sibling project doing the same comparison with C/LLVM (clang) instead of
Rust lives alongside this one in [`c/`](c/README.md), sharing this repo's
`artifacts/<platform>/` layout under a `c/` subdirectory.

## Requirements

- `rustc` — both the stable toolchain and `nightly` (nightly is required for
  unstable `-Zunpretty` output: expanded macros, HIR, and MIR)
- `cargo`
- `llvm-objdump`
- `nm`
- `strings`
- `rustfilt` — optional but recommended for demangled symbol tables

Platform-specific tools:

- `readelf` and `ldd` — Linux only
- `otool` — macOS only

## Quick start

There's no Makefile or build system to install — everything runs through one
plain shell script, `scripts/run.sh`:

```sh
scripts/run.sh install-tools   # print instructions for installing the tools above
scripts/run.sh pipeline        # run the full compiler pipeline dump and build the binary
scripts/run.sh inspect         # inspect the resulting binary
```

Or simply:

```sh
scripts/run.sh all
```

## How the pipeline is organized

If you haven't looked at a compiler's internals before, the short version is:
source code doesn't turn into machine code in one leap. It passes through
several progressively lower-level representations first, and each one is
worth looking at on its own. Each stage below is a separate, small script
under `scripts/pipeline/`, numbered in the order it runs. Every script starts
with a comment explaining, in plain language, what that stage is and why it's
useful for this comparison — open any one of them if you want the details.

| Stage | Script | Plain-English summary |
|---|---|---|
| Versions | `pipeline/00_versions.sh` | Records exactly which compiler produced everything else, so results are reproducible. |
| Macro expansion | `pipeline/01_expand.sh` | Rewrites macros like `println!` into the plain Rust code they stand for. |
| HIR | `pipeline/02_hir.sh` | Rust source, desugared and partially type-checked — still readable as Rust. |
| MIR | `pipeline/03_mir.sh` | A control-flow graph of simple steps — no longer looks like Rust. Where the borrow checker runs. |
| LLVM IR | `pipeline/04_llvm_ir.sh` | An architecture-independent assembly-like language. Should look nearly the same on both CPUs — the whole point of this comparison. |
| Assembly | `pipeline/05_asm.sh` | Real instructions for one specific CPU. This is where x86-64 and AArch64 actually diverge. |
| Build | `pipeline/06_build.sh` | Links everything into a runnable binary via `cargo build --release`. |

`scripts/run.sh pipeline` just runs these seven scripts in order. Likewise,
`scripts/run.sh inspect` runs the small scripts under `scripts/inspect/`
(`basic_info.sh`, `symbols.sh`, `disassemble.sh`, plus one of
`linux_specific.sh` / `macos_specific.sh` depending on the OS) — each does
one inspection and nothing else.

### Where this pipeline is documented

These stage boundaries aren't specific to this project — they're rustc's
actual internal compilation pipeline. Primary sources, useful for citing in
the paper:

- **[rustc-dev-guide](https://rustc-dev-guide.rust-lang.org/)** — the
  official compiler internals book. Its *"Overview of the Compiler"*
  chapter lays out the same pipeline used here (AST → macro expansion →
  HIR → MIR → LLVM IR → machine code), and the *"The HIR"* / *"The MIR"*
  chapters explain what each representation is for.
- **[The Unstable Book — `-Zunpretty`](https://doc.rust-lang.org/unstable-book/compiler-flags/unpretty.html)**
  — the spec for the exact flag values used in `01_expand.sh`, `02_hir.sh`,
  and `03_mir.sh` (`expanded`, `hir`, `mir`).
- **[LLVM Language Reference](https://llvm.org/docs/LangRef.html)** —
  defines LLVM IR (stage 04). **[LLVM Code Generator docs](https://llvm.org/docs/CodeGenerator.html)**
  — describes how IR is lowered to target-specific assembly (stage 05),
  which is the actual mechanism behind the x86-64/AArch64 divergence this
  project documents.

### Verifying you're looking at the right stage

Each intermediate representation has a distinct, recognizable shape, so you
can sanity-check by eye that a file is what it claims to be:

| Stage | File | Looks like |
|---|---|---|
| Macro expansion | `01-expanded.rs` | Still valid Rust, but `println!` is replaced by its expansion (a call using `std::io::_print` / `format_args!`) |
| HIR | `02-hir.rs` | Still Rust-ish, but desugared — no macros left at all |
| MIR | `03-mir.txt` | Numbered basic blocks (`bb0:`, `bb1:`), `_1 = ...` temporaries, explicit `goto`/`switchInt` — no longer looks like source |
| LLVM IR | `04-ir.ll` | Starts with `define`, uses `%`-prefixed SSA registers, LLVM types like `i32`/`i8*` — LLVM's own syntax |
| Assembly | `05-hello.s` | Real mnemonics for the target: `mov`/`call`/`ret` (x86-64) or `mov`/`bl`/`ret` (AArch64) |

### Running one stage at a time

`scripts/run.sh pipeline` runs all seven stages back to back, but you can
also run a single stage by hand and inspect its output before moving to the
next — useful when you're first getting a feel for what changes between
stages. Each `pipeline/*.sh` script expects `OUT`, `SRC`, `TARGET`, and
`PLAT` to already be set in the environment (normally `run.sh` does this for
you), so export them once in your shell session first:

```sh
export OUT=artifacts/x86_64-linux/rust SRC=src/hello/src/main.rs \
       TARGET=x86_64-unknown-linux-gnu PLAT=x86_64-linux
mkdir -p "$OUT"

bash scripts/pipeline/01_expand.sh   && cat "$OUT/01-expanded.rs"
bash scripts/pipeline/02_hir.sh      && cat "$OUT/02-hir.rs"
bash scripts/pipeline/03_mir.sh      && cat "$OUT/03-mir.txt"
bash scripts/pipeline/04_llvm_ir.sh  && cat "$OUT/04-ir.ll"
bash scripts/pipeline/05_asm.sh      && cat "$OUT/05-hello.s"
```

On macOS/AArch64, use `OUT=artifacts/aarch64-macos/rust TARGET=aarch64-apple-darwin PLAT=aarch64-macos` instead.

## What gets generated

| File | Produced by | Contents |
|---|---|---|
| `00-versions.txt` | `pipeline/00_versions.sh` | `rustc`/`rustup`/`uname` version info, plus exact CPU model and OS build (`lscpu` + `/etc/os-release` on Linux, `system_profiler`/`sw_vers` on macOS) |
| `01-expanded.rs` | `pipeline/01_expand.sh` | Source after macro expansion (nightly) |
| `02-hir.rs` | `pipeline/02_hir.sh` | High-level IR (HIR) (nightly) |
| `03-mir.txt` | `pipeline/03_mir.sh` | Mid-level IR (MIR), release-optimized (nightly) |
| `04-ir.ll` | `pipeline/04_llvm_ir.sh` | LLVM IR emitted for the target triple |
| `05-hello.s` | `pipeline/05_asm.sh` | Final target assembly (Intel syntax on x86-64) |
| `06-build-log.txt` | `pipeline/06_build.sh` | `cargo build --release` output log |
| `hello` | `pipeline/06_build.sh` | The compiled release binary |
| `bin-file.txt` | `inspect/basic_info.sh` | `file` output — binary format/architecture |
| `bin-size.txt` | `inspect/basic_info.sh` | `size` output — section sizes |
| `bin-strings.txt` | `inspect/basic_info.sh` | `strings` output — embedded string constants |
| `bin-disasm.txt` | `inspect/disassemble.sh` | `llvm-objdump -d --demangle` full disassembly |
| `bin-nm-raw.txt` | `inspect/symbols.sh` | `nm` output — raw (mangled) symbol table |
| `bin-symbol-count.txt` | `inspect/symbols.sh` | Count of symbols from `nm` |
| `bin-nm-demangled.txt` | `inspect/symbols.sh` | `nm \| rustfilt` — demangled symbol table (if `rustfilt` installed) |
| `bin-readelf.txt` | `inspect/linux_specific.sh` | `readelf -hSl` — ELF header, sections, program headers |
| `bin-ldd.txt` | `inspect/linux_specific.sh` | `ldd` — dynamic library dependencies |
| `bin-loadcmds.txt` | `inspect/macos_specific.sh` | `otool -l` — Mach-O load commands |
| `bin-dylibs.txt` | `inspect/macos_specific.sh` | `otool -L` — linked dynamic libraries |
| `bin-pac-count.txt` | `inspect/macos_specific.sh` | Count of `paciasp`/`autiasp` pointer-authentication instructions |

## Artifacts directory layout

A fully populated `artifacts/x86_64-linux/rust/` directory looks like:

```
artifacts/x86_64-linux/rust/
├── 00-versions.txt
├── 01-expanded.rs
├── 02-hir.rs
├── 03-mir.txt
├── 04-ir.ll
├── 05-hello.s
├── 06-build-log.txt
├── hello
├── bin-file.txt
├── bin-size.txt
├── bin-strings.txt
├── bin-disasm.txt
├── bin-nm-raw.txt
├── bin-symbol-count.txt
├── bin-nm-demangled.txt
├── bin-readelf.txt
└── bin-ldd.txt
```

`artifacts/aarch64-macos/rust/` mirrors this layout, substituting
`bin-loadcmds.txt`, `bin-dylibs.txt`, and `bin-pac-count.txt` for the
Linux-specific files.

`artifacts/<platform>/c/` holds the equivalent output for the sibling C/LLVM
project under [`c/`](c/README.md) — same two platforms, same numbered-stage
idea, different compiler.

## Key files for the paper

- **`05-hello.s`** — the main assembly listing used for the cross-architecture
  comparison. This is where ISA differences (register naming, calling
  conventions, instruction selection, addressing modes) are most visible.
- **`04-ir.ll`** — the LLVM IR. This should be near-identical between the two
  platforms, which is the key evidence that divergence happens in the LLVM
  backend / target lowering stage, not in the frontend or mid-level
  optimization passes.
- **`bin-nm-demangled.txt`** — the demangled symbol table, showing the Rust
  runtime and standard library symbols linked into the binary.

## Running on both machines

Clone this same repository on both the x86-64 Linux machine and the AArch64
macOS machine. On each machine, run:

```sh
scripts/run.sh all
```

This populates the corresponding `artifacts/<platform>/` directory in place.
Once both machines have been run, combine the two `artifacts/` directories
(via `git commit`/`push`/`pull`, or by copying the directories directly) so
that both platforms' outputs are available side-by-side for comparison.
