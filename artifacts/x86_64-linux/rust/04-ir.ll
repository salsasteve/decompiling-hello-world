; ModuleID = 'main.8f81e49356787d17-cgu.0'
source_filename = "main.8f81e49356787d17-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@vtable.0 = private unnamed_addr constant <{ [24 x i8], ptr, ptr, ptr }> <{ [24 x i8] c"\00\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h601a936d8304b915E", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he6dd0c326092176dE", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he6dd0c326092176dE" }>, align 8
@alloc_3213114faf700a46436312d7d5d956d1 = private unnamed_addr constant [14 x i8] c"Hello, world!\0A", align 1

; std::rt::lang_start
; Function Attrs: nonlazybind uwtable
define hidden noundef i64 @_ZN3std2rt10lang_start17h37ec48243b8dd23aE(ptr noundef nonnull %main, i64 noundef %argc, ptr noundef %argv, i8 noundef %sigpipe) unnamed_addr #0 {
start:
  %_7 = alloca [8 x i8], align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %_7)
  store ptr %main, ptr %_7, align 8
; call std::rt::lang_start_internal
  %_0 = call noundef i64 @_RNvNtCs75vJTIYSa2J_3std2rt19lang_start_internal(ptr noundef nonnull %_7, ptr noalias noundef readonly align 8 captures(address, read_provenance) dereferenceable(48) @vtable.0, i64 noundef %argc, ptr noundef %argv, i8 noundef %sigpipe)
  call void @llvm.lifetime.end.p0(ptr nonnull %_7)
  ret i64 %_0
}

; std::rt::lang_start::{{closure}}
; Function Attrs: inlinehint nonlazybind uwtable
define internal noundef i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he6dd0c326092176dE"(ptr noalias noundef readonly align 8 captures(none) dereferenceable(8) %_1) unnamed_addr #1 {
start:
  %_4 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
; call std::sys::backtrace::__rust_begin_short_backtrace
  tail call fastcc void @_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hafa657e659eb3b9aE(ptr noundef nonnull %_4) #6
  ret i32 0
}

; std::sys::backtrace::__rust_begin_short_backtrace
; Function Attrs: noinline nonlazybind uwtable
define internal fastcc void @_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hafa657e659eb3b9aE(ptr noundef nonnull readonly captures(none) %f) unnamed_addr #2 {
start:
  tail call void %f()
  tail call void asm sideeffect "", "~{memory}"() #7, !srcloc !5
  ret void
}

; core::ops::function::FnOnce::call_once{{vtable.shim}}
; Function Attrs: inlinehint nonlazybind uwtable
define internal noundef i32 @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h601a936d8304b915E"(ptr noundef readonly captures(none) %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %0 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
; call std::sys::backtrace::__rust_begin_short_backtrace
  tail call fastcc void @_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hafa657e659eb3b9aE(ptr noundef nonnull readonly %0) #6, !noalias !6
  ret i32 0
}

; main::main
; Function Attrs: nonlazybind uwtable
define hidden void @_ZN4main4main17h2dd6e7c25b480450E() unnamed_addr #0 {
start:
; call std::io::stdio::_print
  tail call void @_RNvNtNtCs75vJTIYSa2J_3std2io5stdio6__print(ptr noundef nonnull @alloc_3213114faf700a46436312d7d5d956d1, ptr noundef nonnull inttoptr (i64 29 to ptr))
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #3

; std::rt::lang_start_internal
; Function Attrs: nonlazybind uwtable
declare noundef i64 @_RNvNtCs75vJTIYSa2J_3std2rt19lang_start_internal(ptr noundef nonnull, ptr noalias noundef readonly align 8 captures(address, read_provenance) dereferenceable(48), i64 noundef, ptr noundef, i8 noundef) unnamed_addr #0

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #3

; Function Attrs: nounwind nonlazybind uwtable
declare noundef range(i32 0, 10) i32 @rust_eh_personality(i32 noundef, i32 noundef, i64 noundef, ptr noundef, ptr noundef) unnamed_addr #4

; std::io::stdio::_print
; Function Attrs: nonlazybind uwtable
declare void @_RNvNtNtCs75vJTIYSa2J_3std2io5stdio6__print(ptr noundef nonnull, ptr noundef nonnull) unnamed_addr #0

; Function Attrs: nonlazybind
define noundef i32 @main(i32 %0, ptr %1) unnamed_addr #5 {
top:
  %_7.i = alloca [8 x i8], align 8
  %2 = sext i32 %0 to i64
  call void @llvm.lifetime.start.p0(ptr nonnull %_7.i)
  store ptr @_ZN4main4main17h2dd6e7c25b480450E, ptr %_7.i, align 8
; call std::rt::lang_start_internal
  %_0.i = call noundef i64 @_RNvNtCs75vJTIYSa2J_3std2rt19lang_start_internal(ptr noundef nonnull %_7.i, ptr noalias noundef readonly align 8 captures(address, read_provenance) dereferenceable(48) @vtable.0, i64 noundef %2, ptr noundef %1, i8 noundef 0)
  call void @llvm.lifetime.end.p0(ptr nonnull %_7.i)
  %3 = trunc i64 %_0.i to i32
  ret i32 %3
}

attributes #0 = { nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #1 = { inlinehint nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #2 = { noinline nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #4 = { nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #5 = { nonlazybind "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #6 = { noinline }
attributes #7 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 7, !"PIE Level", i32 2}
!2 = !{i32 2, !"RtLibUseGOT", i32 1}
!3 = !{!"rustc version 1.96.0 (ac68faa20 2026-05-25)"}
!4 = !{}
!5 = !{i64 6282343154602399}
!6 = !{!7}
!7 = distinct !{!7, !8, !"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he6dd0c326092176dE: %_1"}
!8 = distinct !{!8, !"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he6dd0c326092176dE"}
