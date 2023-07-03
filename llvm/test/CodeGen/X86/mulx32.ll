; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown -mattr=+bmi2 | FileCheck %s
; RUN: llc < %s -mtriple=i686-unknown -mcpu=core-avx2 | FileCheck %s

define i64 @f1(i32 %a, i32 %b) {
; CHECK-LABEL: f1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %edx
; CHECK-NEXT:    mulxl {{[0-9]+}}(%esp), %eax, %edx
; CHECK-NEXT:    retl
  %x = zext i32 %a to i64
  %y = zext i32 %b to i64
  %r = mul i64 %x, %y
  ret i64 %r
}

define i64 @f2(i32 %a, ptr %p) {
; CHECK-LABEL: f2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %edx
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    mulxl (%eax), %eax, %edx
; CHECK-NEXT:    retl
  %b = load i32, ptr %p
  %x = zext i32 %a to i64
  %y = zext i32 %b to i64
  %r = mul i64 %x, %y
  ret i64 %r
}
