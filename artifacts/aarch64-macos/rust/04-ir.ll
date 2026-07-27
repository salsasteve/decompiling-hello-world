; ModuleID = 'main.8f81e49356787d17-cgu.0'
source_filename = "main.8f81e49356787d17-cgu.0"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx11.0.0"

@vtable.0 = private unnamed_addr constant <{ [24 x i8], ptr, ptr, ptr }> <{ [24 x i8] c"\00\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h35fbfd43d88ec7aeE", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17hbcef59d852f4b506E", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17hbcef59d852f4b506E" }>, align 8
@alloc_3213114faf700a46436312d7d5d956d1 = private unnamed_addr constant [14 x i8] c"Hello, world!\0A", align 1

; <() as std::process::Termination>::report
; Function Attrs: inlinehint uwtable
define internal noundef i8 @_RNvXsZ_NtCsaLOjE9VYtxK_3std7processuNtB5_11Termination6report() unnamed_addr #0 {
start:
  ret i8 0
}

; std::rt::lang_start
; Function Attrs: uwtable
define hidden noundef i64 @_ZN3std2rt10lang_start17hf66e9cda02e72e37E(ptr noundef nonnull %main, i64 noundef %argc, ptr noundef %argv, i8 noundef %sigpipe) unnamed_addr #1 {
start:
  %_7 = alloca [8 x i8], align 8
  call void @llvm.lifetime.start.p0(ptr %_7)
  store ptr %main, ptr %_7, align 8
; call std::rt::lang_start_internal
  %_0 = call noundef i64 @_RNvNtCsaLOjE9VYtxK_3std2rt19lang_start_internal(ptr noundef nonnull %_7, ptr noalias noundef readonly align 8 captures(address, read_provenance) dereferenceable(48) @vtable.0, i64 noundef %argc, ptr noundef %argv, i8 noundef %sigpipe)
  call void @llvm.lifetime.end.p0(ptr %_7)
  ret i64 %_0
}

; std::rt::lang_start::{{closure}}
; Function Attrs: inlinehint uwtable
define internal noundef i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17hbcef59d852f4b506E"(ptr noalias noundef readonly align 8 captures(address, read_provenance) dereferenceable(8) %_1) unnamed_addr #0 {
start:
  %_4 = load ptr, ptr %_1, align 8, !nonnull !3, !noundef !3
; call std::sys::backtrace::__rust_begin_short_backtrace
  call void @_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hb05ff8d5cc5951c5E(ptr noundef nonnull %_4) #7
; call <() as std::process::Termination>::report
  %self = call noundef i8 @_RNvXsZ_NtCsaLOjE9VYtxK_3std7processuNtB5_11Termination6report() #8
  %_0 = zext i8 %self to i32
  ret i32 %_0
}

; std::sys::backtrace::__rust_begin_short_backtrace
; Function Attrs: noinline uwtable
define internal void @_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hb05ff8d5cc5951c5E(ptr noundef nonnull %f) unnamed_addr #2 {
start:
; call core::ops::function::FnOnce::call_once
  call void @_ZN4core3ops8function6FnOnce9call_once17hcc16df947e256ec9E(ptr noundef nonnull %f) #8
  call void asm sideeffect "", "~{memory}"(), !srcloc !4
  ret void
}

; core::ops::function::FnOnce::call_once{{vtable.shim}}
; Function Attrs: inlinehint uwtable
define internal noundef i32 @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h35fbfd43d88ec7aeE"(ptr noundef %_1) unnamed_addr #0 {
start:
  %_2 = alloca [0 x i8], align 1
  %0 = load ptr, ptr %_1, align 8, !nonnull !3, !noundef !3
; call core::ops::function::FnOnce::call_once
  %_0 = call noundef i32 @_ZN4core3ops8function6FnOnce9call_once17hed492bd412beb9cfE(ptr noundef nonnull %0) #8
  ret i32 %_0
}

; core::ops::function::FnOnce::call_once
; Function Attrs: inlinehint uwtable
define internal void @_ZN4core3ops8function6FnOnce9call_once17hcc16df947e256ec9E(ptr noundef nonnull %_1) unnamed_addr #0 {
start:
  %_2 = alloca [0 x i8], align 1
  call void %_1()
  ret void
}

; core::ops::function::FnOnce::call_once
; Function Attrs: inlinehint uwtable
define internal noundef i32 @_ZN4core3ops8function6FnOnce9call_once17hed492bd412beb9cfE(ptr noundef nonnull %0) unnamed_addr #0 personality ptr @rust_eh_personality {
start:
  %1 = alloca [16 x i8], align 8
  %_2 = alloca [0 x i8], align 1
  %_1 = alloca [8 x i8], align 8
  store ptr %0, ptr %_1, align 8
; invoke std::rt::lang_start::{{closure}}
  %_0 = invoke noundef i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17hbcef59d852f4b506E"(ptr noalias noundef readonly align 8 captures(address, read_provenance) dereferenceable(8) %_1)
          to label %bb1 unwind label %cleanup

bb3:                                              ; preds = %cleanup
  %2 = load ptr, ptr %1, align 8, !noundef !3
  %3 = getelementptr inbounds i8, ptr %1, i64 8
  %4 = load i32, ptr %3, align 8, !noundef !3
  call void @llvm.lifetime.end.p0(ptr %1)
  %5 = insertvalue { ptr, i32 } poison, ptr %2, 0
  %6 = insertvalue { ptr, i32 } %5, i32 %4, 1
  resume { ptr, i32 } %6

cleanup:                                          ; preds = %start
  %7 = landingpad { ptr, i32 }
          cleanup
  %8 = extractvalue { ptr, i32 } %7, 0
  %9 = extractvalue { ptr, i32 } %7, 1
  call void @llvm.lifetime.start.p0(ptr %1)
  store ptr %8, ptr %1, align 8
  %10 = getelementptr inbounds i8, ptr %1, i64 8
  store i32 %9, ptr %10, align 8
  br label %bb3

bb1:                                              ; preds = %start
  ret i32 %_0
}

; main::main
; Function Attrs: uwtable
define hidden void @_ZN4main4main17h2dd6e7c25b480450E() unnamed_addr #1 {
start:
  call void @llvm.assume(i1 true)
  %0 = icmp ne ptr inttoptr (i64 29 to ptr), null
  call void @llvm.assume(i1 %0)
; call std::io::stdio::_print
  call void @_RNvNtNtCsaLOjE9VYtxK_3std2io5stdio6__print(ptr noundef nonnull @alloc_3213114faf700a46436312d7d5d956d1, ptr noundef nonnull inttoptr (i64 29 to ptr))
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #3

; std::rt::lang_start_internal
; Function Attrs: uwtable
declare noundef i64 @_RNvNtCsaLOjE9VYtxK_3std2rt19lang_start_internal(ptr noundef nonnull, ptr noalias noundef readonly align 8 captures(address, read_provenance) dereferenceable(48), i64 noundef, ptr noundef, i8 noundef) unnamed_addr #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #3

; Function Attrs: nounwind uwtable
declare noundef range(i32 0, 10) i32 @rust_eh_personality(i32 noundef, i32 noundef, i64 noundef, ptr noundef, ptr noundef) unnamed_addr #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #5

; std::io::stdio::_print
; Function Attrs: uwtable
declare void @_RNvNtNtCsaLOjE9VYtxK_3std2io5stdio6__print(ptr noundef nonnull, ptr noundef nonnull) unnamed_addr #1

define i32 @main(i32 %0, ptr %1) unnamed_addr #6 {
top:
  %2 = sext i32 %0 to i64
; call std::rt::lang_start
  %3 = call i64 @_ZN3std2rt10lang_start17hf66e9cda02e72e37E(ptr @_ZN4main4main17h2dd6e7c25b480450E, i64 %2, ptr %1, i8 0)
  %4 = trunc i64 %3 to i32
  ret i32 %4
}

attributes #0 = { inlinehint uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="apple-m1" }
attributes #1 = { uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="apple-m1" }
attributes #2 = { noinline uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="apple-m1" }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #4 = { nounwind uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="apple-m1" }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #6 = { "frame-pointer"="non-leaf" "target-cpu"="apple-m1" }
attributes #7 = { noinline }
attributes #8 = { inlinehint }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 7, !"PIE Level", i32 2}
!2 = !{!"rustc version 1.96.0 (ac68faa20 2026-05-25)"}
!3 = !{}
!4 = !{i64 5869008386841010}
