; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-none-linux-gnu | FileCheck %s

; This used to miscompile because foldCSELOfCSEL function
; doesn't check const x != y
define i1 @test() {
; CHECK-LABEL: test:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #9007199254740990
; CHECK-NEXT:    movk x8, #65503, lsl #16
; CHECK-NEXT:    movk x8, #65407, lsl #32
; CHECK-NEXT:    cmp x8, x8
; CHECK-NEXT:    csel x9, x8, x8, gt
; CHECK-NEXT:    cmp x9, x8
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %1 = select i1 false, i64 0, i64 9006649496829950
  %2 = call i64 @llvm.smax.i64(i64 %1, i64 9006649496829950)
  %3 = icmp eq i64 %2, 9006649496829950
  ret i1 %3
}

declare i64 @llvm.smax.i64(i64, i64)
