; Regression test for PR51200.
;
; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
;
; This transformation requires the pointer size, as it assumes that size_t is
; the size of a pointer.

@percent_s = constant [3 x i8] c"%s\00"

declare i32 @sprintf(ptr, ptr, ...)

define i32 @PR51200(ptr %p, ptr %p2) {
; CHECK-LABEL: @PR51200(
; Don't check anything, just expect the test to compile successfully.
;
  %call = call i32 (ptr, ptr, ...) @sprintf(ptr %p, ptr @percent_s, ptr %p2)
  ret i32 %call
}
