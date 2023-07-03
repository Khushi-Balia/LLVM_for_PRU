; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes
; RUN: opt -passes=argpromotion -S %s | FileCheck %s

@glob = external global ptr

; No arguments in @callee can be promoted, but it contains a dead GEP. Make
; sure it is not removed, as we do not perform any promotion.
define i32 @caller(ptr %ptr) {
; CHECK-LABEL: define {{[^@]+}}@caller
; CHECK-SAME: (ptr [[PTR:%.*]]) {
; CHECK-NEXT:    call void @callee(ptr [[PTR]], ptr [[PTR]], ptr [[PTR]])
; CHECK-NEXT:    ret i32 0
;
  call void @callee(ptr %ptr, ptr %ptr, ptr %ptr)
  ret i32 0
}

define internal void @callee(ptr %arg, ptr %arg1, ptr %arg2) {
; CHECK-LABEL: define {{[^@]+}}@callee
; CHECK-SAME: (ptr [[ARG:%.*]], ptr [[ARG1:%.*]], ptr [[ARG2:%.*]]) {
; CHECK-NEXT:    call void @external_fn(ptr [[ARG]], ptr [[ARG1]])
; CHECK-NEXT:    [[DEAD_GEP:%.*]] = getelementptr inbounds i32, ptr [[ARG1]], i32 17
; CHECK-NEXT:    store ptr [[ARG2]], ptr @glob, align 8
; CHECK-NEXT:    ret void
;
  call void @external_fn(ptr %arg, ptr %arg1)
  %dead.gep = getelementptr inbounds i32, ptr %arg1, i32 17
  store ptr %arg2, ptr @glob, align 8
  ret  void
}

declare void @external_fn(ptr, ptr)
